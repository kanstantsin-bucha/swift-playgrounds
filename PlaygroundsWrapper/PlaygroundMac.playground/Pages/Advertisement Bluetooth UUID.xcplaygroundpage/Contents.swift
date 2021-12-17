//: [Previous](@previous)

import Foundation
import CoreBluetooth

public class OverflowAreaUtils {
    // swiftlint:disable line_length
    public static let serialized: String = """
        {\"121\":\"00000088\",\"117\":\"000000A8\",\"68\":\"00000007\",\"72\":\"00000027\",\"73\":\"000000AF\",\"69\":\"0000008F\",\"122\":\"00000019\",\"118\":\"00000039\",\"74\":\"0000003E\",\"75\":\"000000B6\",\"123\":\"00000091\",\"119\":\"000000B1\",\"80\":\"0000008B\",\"76\":\"00000015\",\"81\":\"00000003\",\"124\":\"00000032\",\"77\":\"0000009D\",\"82\":\"00000092\",\"78\":\"0000000C\",\"83\":\"0000001A\",\"125\":\"000000BA\",\"79\":\"00000084\",\"84\":\"000000B9\",\"126\":\"0000002B\",\"85\":\"00000031\",\"86\":\"000000A0\",\"90\":\"00000080\",\"127\":\"000000A3\",\"87\":\"00000028\",\"91\":\"00000008\",\"88\":\"00000099\",\"92\":\"000000AB\",\"10\":\"00000005\",\"89\":\"00000011\",\"11\":\"0000008D\",\"93\":\"00000023\",\"94\":\"000000B2\",\"12\":\"0000002E\",\"95\":\"0000003A\",\"13\":\"000000A6\",\"96\":\"000000AC\",\"14\":\"00000037\",\"97\":\"00000024\",\"15\":\"000000BF\",\"98\":\"000000B5\",\"16\":\"000000B0\",\"20\":\"00000082\",\"99\":\"0000003D\",\"17\":\"00000038\",\"21\":\"0000000A\",\"18\":\"000000A9\",\"22\":\"0000009B\",\"19\":\"00000021\",\"23\":\"00000013\",\"24\":\"000000A2\",\"25\":\"0000002A\",\"30\":\"00000089\",\"26\":\"000000BB\",\"31\":\"00000001\",\"27\":\"00000033\",\"32\":\"00000097\",\"28\":\"00000090\",\"100\":\"0000009E\",\"33\":\"0000001F\",\"29\":\"00000018\",\"34\":\"0000008E\",\"101\":\"00000016\",\"35\":\"00000006\",\"102\":\"00000087\",\"40\":\"00000085\",\"36\":\"000000A5\",\"41\":\"0000000D\",\"37\":\"0000002D\",\"103\":\"0000000F\",\"42\":\"0000009C\",\"38\":\"000000BC\",\"0\":\"0000000E\",\"1\":\"00000086\",\"43\":\"00000014\",\"2\":\"00000017\",\"39\":\"00000034\",\"104\":\"000000BE\",\"3\":\"0000009F\",\"44\":\"000000B7\",\"4\":\"0000003C\",\"45\":\"0000003F\",\"5\":\"000000B4\",\"105\":\"00000036\",\"6\":\"00000025\",\"46\":\"000000AE\",\"50\":\"00000030\",\"7\":\"000000AD\",\"8\":\"0000001C\",\"47\":\"00000026\",\"110\":\"00000095\",\"106\":\"000000A7\",\"51\":\"000000B8\",\"9\":\"00000094\",\"48\":\"00000029\",\"52\":\"0000001B\",\"111\":\"0000001D\",\"107\":\"0000002F\",\"49\":\"000000A1\",\"53\":\"00000093\",\"54\":\"00000002\",\"112\":\"00000012\",\"55\":\"0000008A\",\"108\":\"0000008C\",\"56\":\"0000003B\",\"60\":\"00000009\",\"113\":\"0000009A\",\"109\":\"00000004\",\"57\":\"000000B3\",\"61\":\"00000081\",\"58\":\"00000022\",\"62\":\"00000010\",\"114\":\"0000000B\",\"59\":\"000000AA\",\"63\":\"00000098\",\"64\":\"00000035\",\"115\":\"00000083\",\"65\":\"000000BD\",\"120\":\"00000076\",\"116\":\"00000020\",\"70\":\"0000001E\",\"66\":\"0000002C\",\"71\":\"00000096\",\"67\":\"000000A4\"}
    """
    // swiftlint:enable line_length

    var overflowServiceUuidsByBitPosition = Dictionary<Int, CBUUID>()

    enum Bit { case zero, one }

    func bit(_ i: Int, of uint8: UInt8) -> Bit {
      let first8PowersOf2 = (0...7).map { return UInt8(1) << $0 }
      return (uint8 & first8PowersOf2[i] != 0) ? Bit.one : Bit.zero
    }

    public init() {
        guard let data = OverflowAreaUtils.serialized.data(using: .utf8),
              let object = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            print("OverflowAreaUtils can't decode data")
            return
        }
        for elem in object {
            guard let key = Int(elem.key),
                  let value = elem.value as? String else {
                      print("OverflowAreaUtils can't transform key: \(elem.key) value: \(elem.value)")
                continue
            }
            overflowServiceUuidsByBitPosition[key] = CBUUID(string: value)
        }
    }

    public func toOverflowServiceUuids(uuid: CBUUID) -> [CBUUID] {
        let data = uuid.data
        let array = data.withUnsafeBytes({ body in Array(body) })
        return toOverflowServiceUuids(bytes: array)
    }

    public func toOverflowServiceUuids(bytes: [UInt8]) -> [CBUUID] {
        var cbUuids: [CBUUID] = []
        let bytes = Array(([UInt8].init(repeating: 0x0, count: 16 - bytes.count) + bytes).reversed())
        for byteNumber in 0...15 {
            for bitNumber in 0...7 {
                let bitPosition = (byteNumber)*8+bitNumber
                if self.bit(bitNumber, of: bytes[byteNumber]) == .one,
                   let uuid = overflowServiceUuidsByBitPosition[bitPosition] {
                    cbUuids.append(uuid)
                }
            }
        }
        return cbUuids
    }
}

print("[0000000E, 00000089, 0000003F, 00000007, 0000003A, 00000088]")
print("-------")

let uuidStrings = [
    "24000000-0200-2000-0400-000000000020",
    "02000000-8000-0010-0000-200040000001",
    "00080000-0004-0020-0030-000004000000",
    "00000009-0008-0040-0000-001000000008"

]
for uuidString in uuidStrings {
    let uuid = UUID(uuidString: uuidString)!
    let cb = CBUUID(nsuuid: uuid)
    print(OverflowAreaUtils().toOverflowServiceUuids(uuid: cb))
}








//: [Next](@next)
