//: [Previous](@previous)

import Foundation

@objcMembers class PhoneNumber: NSObject {
    var canonizedPhoneNum: String?
    init(canonizedPhoneNum: String?) {
        self.canonizedPhoneNum = canonizedPhoneNum
    }
}

@objcMembers class Member: NSObject {
    var phoneNumbers: NSSet?
    init(phoneNumbers: [PhoneNumber]) {
        self.phoneNumbers = NSSet(array: phoneNumbers)
    }
}

let members = [
    Member(phoneNumbers: [
        PhoneNumber(canonizedPhoneNum: "12"),
        PhoneNumber(canonizedPhoneNum: nil),
        PhoneNumber(canonizedPhoneNum: "12sdfsdf")] ),
    Member(phoneNumbers: [ PhoneNumber(canonizedPhoneNum: "13") ] )
] as NSArray
let opt = false
let something: String? = opt ? nil : ""

let predicate = NSPredicate(format: "ANY %K == %@", #keyPath(Member.phoneNumbers.canonizedPhoneNum), something)
print(members.filtered(using: predicate))

//: [Next](@next)
