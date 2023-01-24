//: [Previous](@previous)

import Foundation

//: ![The real head of the household?](checks.jpeg)


[1..<4].enumerated().reduce(into: 0) { (result, item) in

}

public enum DisappearingMessagesChangeTimebombType: UInt16, Codable {
    case systemOn
    case systemOff
    case messageOn
    case messageOff

    public func isSystem() -> Bool {
        let systemSubset = NSSet(array: [Self.systemOn, Self.systemOff])
        return systemSubset.contains(self)
    }

    public func isMessage() -> Bool {
        let systemSubset = NSSet(array: [Self.messageOn, Self.messageOff])
        return systemSubset.contains(self)
    }

    public func isTimebombOff() -> Bool {
        let systemSubset = NSSet(array: [Self.systemOff, Self.messageOff])
        return systemSubset.contains(self)
    }

    public var desc: String { "\(isSystem() ? "S" : "M")_\(isTimebombOff() ? "OFF" : "ON")" }
}

let type = DisappearingMessagesChangeTimebombType.systemOff

fileprivate struct DisappearingBound {
    let token: UInt64
    let type: DisappearingMessagesChangeTimebombType
}

fileprivate class DisappearingBlock: Equatable {
    let tokensRange: ClosedRange<UInt64>
    let lowerBound: DisappearingBound
    let upperBound: DisappearingBound
    let previousChainedBlock: DisappearingBlock?
    private let dmRange: ClosedRange<UInt64>

    private(set) var deletingTokens: Set<UInt64> = []
    private(set) var presentsTokens: Set<UInt64> = []

    var isIncludeDeleted: Bool { !deletingTokens.isEmpty }
    var isEmpty: Bool {
        self
        let count = presentsTokens.count - deletingTokens.count
        return count <= 0
    }
    var isReadyToCollapse: Bool { isIncludeDeleted && isEmpty }

    init(lowerBound: DisappearingBound, upperBound: DisappearingBound, previous: DisappearingBlock?) {
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.tokensRange = lowerBound.token...upperBound.token
        self.dmRange = Self.lowerBoundToken(lowerBound)...upperBound.token - 1
        self.previousChainedBlock = previous?.tokensRange.upperBound == tokensRange.lowerBound ? previous : nil
    }

    static func lowerBoundToken(_ lowerBound: DisappearingBound) -> UInt64 {
        guard lowerBound.type.isMessage(), !lowerBound.type.isTimebombOff() else { return lowerBound.token + 1 }
        return lowerBound.token
    }

    static func == (lhs: DisappearingBlock, rhs: DisappearingBlock) -> Bool {
        return lhs.tokensRange == rhs.tokensRange
    }
}

fileprivate extension DisappearingBlock {
    func isAllChainedEmpty() -> Bool {
        guard isEmpty else { return false }
        guard let previous = previousChainedBlock else {
            print("last in my is ready to collapse: \(isReadyToCollapse)")
            return isReadyToCollapse
        }
        return previous.isAllChainedEmpty()
    }

    func tryInclude(deletingToken: UInt64) -> Bool {
        guard dmRange.contains(deletingToken) else { return false }
        deletingTokens.insert(deletingToken)
        return true
    }

    func tryInclude(presentsToken: UInt64) -> Bool {
        guard dmRange.contains(presentsToken) else { return false }
        presentsTokens.insert(presentsToken)
        return true
    }
}



fileprivate struct DisappearingBlocksBuilder {
    let cangesRange: ClosedRange<UInt64>?
    let blocks: [DisappearingBlock]
    let changingBlocks: ArraySlice<DisappearingBlock>
    init(timebombEntries: [UInt64: DisappearingMessagesChangeTimebombType],
         deletingMessages: [UInt64]) {
        let emptyBlocks = Self.generateEmptyBlocks(entries: timebombEntries)
        self.blocks = Self.fill(blocks: emptyBlocks, with: deletingMessages)

        changingBlocks = blocks[blocks.indices].filter { $0.isIncludeDeleted }

        guard !changingBlocks.isEmpty, let first = changingBlocks.first, let last = changingBlocks.last else {
            cangesRange = nil
            return
        }
        guard first != last else {
            cangesRange = first.tokensRange
            return
        }
        cangesRange = first.tokensRange.lowerBound...last.tokensRange.upperBound
    }

    private static func fill(blocks: [DisappearingBlock],
                             with tokens: [UInt64]) -> [DisappearingBlock] {
        var sortedTokens = tokens.sorted()[tokens.indices]
        blocks.forEach { block in
            sortedTokens = sortedTokens.filter({ token -> Bool in
                return !block.tryInclude(deletingToken: token)
            })
        }
        return blocks
    }

    private static func generateEmptyBlocks(entries: [UInt64: DisappearingMessagesChangeTimebombType]) -> [DisappearingBlock] {
        var previousToken: UInt64?
        var previousBlock: DisappearingBlock?
        return entries.keys.sorted().compactMap { token -> DisappearingBlock? in


            guard let lowerBoundToken = previousToken,
                let lowerBoundType = entries[lowerBoundToken],
                !lowerBoundType.isTimebombOff(),
                let upperBoundType = entries[token] else {
                    previousToken = token
                    return  nil
            }
            let lowerBound = DisappearingBound(token: lowerBoundToken, type: lowerBoundType)
            let upperBound = DisappearingBound(token: token, type: upperBoundType)
            let result = DisappearingBlock(lowerBound: lowerBound, upperBound: upperBound, previous: previousBlock)

            previousToken = token
            previousBlock = result
            return result
        }
    }
}



fileprivate struct DisappearingBlocksChecker {
    let systemTokendToDeleteFromDB: [UInt64]
    let tokendToRemoveFromMetadata: [UInt64]
    let blocks: [DisappearingBlock]
    let emptyBlocks: ArraySlice<DisappearingBlock>
    init(prefilledBlocks: [DisappearingBlock],
         currentUids: [UInt64]) {

        self.blocks = Self.fill(blocks: prefilledBlocks, with: currentUids)

        emptyBlocks = blocks[blocks.indices].filter { $0.isReadyToCollapse }

        var deleteSet: Set<UInt64> = []
        var removeSet: Set<UInt64> = []

        emptyBlocks.forEach { block in
            print("processing empty DM block: \(block)")
            Self.proceedRedundant(block.lowerBound, deleteSet: &deleteSet, removeSet: &removeSet)
            guard Self.isUpperBoundRedundant(block) else { return }
            Self.proceedRedundant(block.upperBound, deleteSet: &deleteSet, removeSet: &removeSet)
        }
        systemTokendToDeleteFromDB = Array(deleteSet).sorted()
        tokendToRemoveFromMetadata = Array(removeSet).sorted()
    }

    private static func proceedRedundant(_ bound: DisappearingBound, deleteSet: inout Set<UInt64>, removeSet: inout Set<UInt64>) {
        removeSet.insert(bound.token)
        print("remove: added: \(bound.token)")
        guard bound.type.isSystem() else { return }
        print("delete: added: \(bound.token)")
        deleteSet.insert(bound.token)
    }

    private static func isUpperBoundRedundant(_ block: DisappearingBlock) -> Bool {
        guard block.upperBound.type.isTimebombOff() else { return false }
        return block.isAllChainedEmpty()
    }

    private static func fill(blocks: [DisappearingBlock],
                             with tokens: [UInt64]) -> [DisappearingBlock] {
        var sortedTokens = tokens.sorted()[tokens.indices]
        blocks.forEach { block in
            sortedTokens = sortedTokens.filter({ uid -> Bool in
                return !block.tryInclude(presentsToken: uid)
            })
        }
        return blocks
    }
}

extension DisappearingBlocksBuilder: CustomStringConvertible {
    var description: String {
        var result = "range to fetch \(String(describing: cangesRange))\n"
        blocks.forEach { block in
            result = result + "\(block.fullDescription)\n"
        }
        return result
    }
}

extension DisappearingBound: CustomStringConvertible {
    var description: String { return "\(token)\(type.desc)" }
}

extension DisappearingBlock: CustomStringConvertible {
    var description: String {
        return "\(isReadyToCollapse ? "*" : " ")<\(lowerBound)...\(upperBound)>"
    }

    var fullDescription: String {
        let remained = presentsTokens.subtracting(deletingTokens)
        return "\(description), deleted: \(Array(deletingTokens).sorted()), remained: \(Array(remained).sorted()), previous: \(String(describing: previousChainedBlock))"
    }
}

extension DisappearingBlocksChecker: CustomStringConvertible {
    var description: String {
        var result = "change: delete: \(systemTokendToDeleteFromDB), remove: \(tokendToRemoveFromMetadata)\n"
        blocks.forEach { block in
            result = result + "\(block.fullDescription)\n"
        }
        return result
    }
}

// check 1
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .systemOn, 20: .systemOn, 30: .systemOff, 40: .systemOn, 50: .systemOff],
//    deletingMessages: [11, 12, 13 21, 22, 23, 31, 32, 33, 41, 42, 43])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [11, 12, 13 20, 21, 22, 23, 30, 31, 32, 33, 40, 41, 42, 43, 50])

//// check 2
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .messageOn, 20: .systemOn, 30: .systemOff, 40: .systemOn, 50: .messageOff],
//    deletingMessages: [10, 11, 12, 13, 21, 22, 23, 31, 32, 33, 41, 42, 43])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [10, 11, 12, 13, 20, 21, 22, 23, 30, 31, 32, 33, 40, 41, 42, 43, 50])

// check3
fileprivate let builder = DisappearingBlocksBuilder(
    timebombEntries: [10: .systemOn, 20: .messageOn, 30: .systemOff, 40: .messageOn, 50: .messageOff],
    deletingMessages: [11, 12, 13, 20, 21, 22, 23, 31, 32, 33, 40, 41, 42, 43])

fileprivate let checker = DisappearingBlocksChecker(
    prefilledBlocks: builder.blocks,
    currentUids: [11, 12, 13, 20, 21, 22, 23, 30, 31, 32, 33, 40, 41, 42, 43, 50])


//// check4
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .systemOn, 20: .messageOn, 30: .messageOn, 39: .systemOff, 40: .systemOn, 50: .messageOff],
//    deletingMessages: [11, 12, 13, 20, 21, 22, 23, 30, 31, 32, 33, 41, 42, 43])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [11, 12, 13, 20, 21, 22, 23, 30, 31, 32, 33, 40, 41, 42, 43, 50])

//// check5
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .systemOn, 19: .messageOff, 20: .systemOn, 30: .messageOn, 39: .systemOff,
//                      40: .messageOn, 45: .messageOn, 50: .systemOff],
//    deletingMessages: [11, 12, 13, 21, 230, 31, 32, 40, 41, 45, 47])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [11, 12, 13, 20, 21, 22, 30, 31, 32, 40, 41, 45, 47, 50])

//// check6
//// we shouldn't remove the bound until all range will be deleted from conversation
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .systemOn, 19: .messageOff, 20: .systemOn, 30: .messageOn, 39: .systemOff,
//                      40: .messageOn, 45: .messageOn, 50: .systemOff],
//    deletingMessages: [45])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [11, 12, 13, 20, 21, 22, 30, 31, 32, 40, 41, 45, 47, 50])

//// check7
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .systemOn, 20: .systemOn, 30: .systemOff, 40: .systemOn, 50: .systemOff],
//    deletingMessages: [11, 13, 21, 22, 23, 31, 32, 33, 41, 42, 43])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [20, 21, 23, 30, 31, 32, 33, 40, 41, 42, 43, 50])

//// check8
// we should not delete bounds for which we don't fetch tokens - they aren't empty
//fileprivate let builder = DisappearingBlocksBuilder(
//    timebombEntries: [10: .systemOn, 20: .systemOn, 30: .systemOff, 40: .systemOn, 50: .systemOff],
//    deletingMessages: [21, 22, 23, 31, 32, 33, 41, 42, 43])
//
//fileprivate let checker = DisappearingBlocksChecker(
//    prefilledBlocks: builder.blocks,
//    currentUids: [20, 21, 22, 23, 30, 31, 32, 33, 40, 41, 42, 43, 50])


print("----------")
print("----- builder ----")
print(builder)
print("----------")

print("----------")
print(checker)
print("----------")


//let date = Date()
//let slightlyEarlier = date - 0.001
//print(date)
//print(slightlyEarlier)

//struct MyOptions : OptionSet {
//    let rawValue: Int
//
//    static let None         = MyOptions(rawValue: 0)
//    static let FirstOption  = MyOptions(rawValue: 1 << 0)
//    static let SecondOption = MyOptions(rawValue: 1 << 1)
//    static let ThirdOption  = MyOptions(rawValue: 1 << 2)
//}
//
//func test(options: MyOptions) {
//    print(options)
//}
//
//test(options: [.FirstOption, .SecondOption])

//let range = 1...3
//range.upperBound
//
//
//func triangular(_ n: Int) -> Int{
// guard n>0 else { return  0}
// guard n>1 else { return  1}
// var result = 1
// var row = 1
// for _ in 2...n {
//   result += row + 1
//   row += 1
//   print(row)
// }
// return result
//}
//
//triangular(0)

//func makeRanges(array: [UInt64]) -> [ClosedRange<UInt64>] {
//    let array = array.sorted()
//    guard var lowerBound = array.first else {
//        return []
//    }
//    guard let last = array.last, lowerBound != last else {
//        return [lowerBound...lowerBound]
//    }
//    var result: [ClosedRange<UInt64>] = []
//    var previous = lowerBound
//    let slice = array.dropFirst()
//    slice.forEach { current in
//        if (previous != current && previous + 1 != current) {
//            result.append(lowerBound...previous)
//            lowerBound = current
//        }
//        previous = current
//    }
//    result.append(lowerBound...last)
//    return result
//}
//
//print(makeRanges(array: [1]))
//print(makeRanges(array: [1,2]))
//print(makeRanges(array: [1,4]))
//print(makeRanges(array: [1,1]))
//print(makeRanges(array: [1,2,3,5,6,9,0]))
//print(makeRanges(array: [1,2,2,3,5,6,9,0,11,13,12]))

//: [Next](@next)
