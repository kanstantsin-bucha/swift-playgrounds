//: [Previous](@previous)

import Foundation
//: ## A Swift Introduction to Core Data
//:
//: Let's create a basic Core Data model and populate it with two related entities. The two entities in our data model will be City and Neighborhood. There is a one-to-many relationship between cities and neighborhoods. A City has many Neighborhoods and each Neighborhood belongs to one City. Here's a diagram representing the model.
//:
//:     +---------------+              +----------------+
//:     | Member        |              |  PhoneNumber   |
//:     |---------------|              |----------------|
//:     | name          |              |  name          |
//:     |               |              |  canonizedPhoneNum
//:     |               |              |                |
//:     |               |              |                |
//:     | phoneNumbers  | <--------->> |  membe         |
//:     +---------------+              +----------------+
//:
//: To get started, we'll import the module for CoreData.

import CoreData

//: Next we'll declare the some String constants up front. This is good practice and helps avoid typos, as we'll be referring to these often. By declaring them as constants, we can also leverage code completion.

struct Entity {
    static let phoneNumber = "PhoneNumber"
    static let member = "Member"
}

struct Attribute {
    static let name = "name"
    static let age = "age"
    static let canonizedPhoneNum = "canonizedPhoneNum"
}

struct Relationship {
    static let phoneNumbers = "phoneNumbers"
    static let member = "member"
}

class PhoneNumber: NSManagedObject {
    @NSManaged var canonizedPhoneNum: String?
    @NSManaged var member: Member?
}

class Member: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var age: NSNumber?
    @NSManaged var phoneNumbers: Set<PhoneNumber>?
}

//: Next define the [Managed Object Model](https://developer.apple.com/library/mac/documentation/DataManagement/Devpedia-CoreData/managedObjectModel.html). Typically this is done inside Xcode with the [Core Data Model Editor](https://developer.apple.com/library/mac/recipes/xcode_help-core_data_modeling_tool/Articles/about_cd_modeling_tool.html). Entities and Relationships are laid out graphically and a `.momd` file is generated at compile time. But we're inside a playund and don't have access to the model editor. No problem, the model can still be [declared in code](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/Articles/cdBasics.html#//apple_ref/doc/uid/TP40001650-207332-TPXREF151). This requires some boilerplate, but it's also a good learning exercise.

let model = NSManagedObjectModel()

//: Next create entity descriptions for the entities in the model. Our model will have two entities: `City` and `Neighborhood`

let phoneNumberEntity = NSEntityDescription()
phoneNumberEntity.name = Entity.phoneNumber

let memberEntity = NSEntityDescription()
memberEntity.name = Entity.member
memberEntity.indexes = []

//: [Entities](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/Articles/cdMOM.html#//apple_ref/doc/uid/TP40002328-SW5) have properties, in the form of attributes and relationships. In our model, a `City` has attributes for `name`, `state`, and `population` whereas a `Neighborhood` only has attributes for `name` and `population`. Attributes have a type. The `name` and `state` attribute are `.stringAttributeType` and the `population` is given a `.integer64AttributeType`. All the attributes are marked as required by setting `isOptional` to `false`.

let nameAttribute = NSAttributeDescription()
nameAttribute.name = Attribute.name
nameAttribute.attributeType = NSAttributeType.stringAttributeType
nameAttribute.isOptional = false

let ageAttribute = NSAttributeDescription()
ageAttribute.name = Attribute.age
ageAttribute.attributeType = NSAttributeType.doubleAttributeType
ageAttribute.isOptional = true

let canonizedPhoneNumAttribute = NSAttributeDescription()
canonizedPhoneNumAttribute.name = Attribute.canonizedPhoneNum
canonizedPhoneNumAttribute.attributeType = NSAttributeType.stringAttributeType
canonizedPhoneNumAttribute.isOptional = true

//: Next declare the one-to-many relationship between `City` and `Neighborhoods`. The relationship needs to be declared on both ends, or between both entities. On one end of the relationship, the `neighborhoodEntity` is setup with a `maxCount` of zero. On the other end, the `cityEntity` is given a `maxCount` of one. This defines both ends of the relationship. To connect the relationship fully, set the `inverseRelationship` property on each relationship to point to the other.

let numberRelationship = NSRelationshipDescription()
let memberRelationship = NSRelationshipDescription()

memberRelationship.name = Relationship.member
memberRelationship.destinationEntity = memberEntity
memberRelationship.minCount = 0
memberRelationship.maxCount = 1
memberRelationship.deleteRule = NSDeleteRule.cascadeDeleteRule
memberRelationship.inverseRelationship = numberRelationship

numberRelationship.name = Relationship.phoneNumbers
numberRelationship.destinationEntity = phoneNumberEntity
numberRelationship.minCount = 0
numberRelationship.maxCount = 10
numberRelationship.deleteRule = NSDeleteRule.nullifyDeleteRule
numberRelationship.inverseRelationship = memberRelationship

//: The type and characteristics of the `name` and `population` attributes are identical between `City` and `Neighborhood`-- the are both required strings. Given this, we can share the `NSAttributeDescription` between `City` and `Neighborhood` and create a copy so the attributes are unique.

memberEntity.properties = [ nameAttribute, ageAttribute, numberRelationship ].map { return ($0.copy() as! NSPropertyDescription) }
phoneNumberEntity.properties = [ nameAttribute, canonizedPhoneNumAttribute, memberRelationship ].map { return ($0.copy() as! NSPropertyDescription) }
//: Setup the model with the entities we've created. At this point the model for our use case is fully defined. We can now fit the model into the rest of the stack.

model.entities = [memberEntity, phoneNumberEntity]

//: Create a [Persistent Store Coordinator](https://developer.apple.com/library/ios/documentation/DataManagement/Devpedia-CoreData/persistentStoreCoordinator.html) (PSC) to communicate with the model we've declared. The coordinator is typically attached to an on disk SQL store with a URL. Because we're in a playground an [in memory store](https://developer.apple.com/library/mac/Documentation/Cocoa/Conceptual/CoreData/Articles/cdUsingPersistentStores.html) is used instead. When creating the PSC, you may include various options in the configuration dictionary, including specifying things like [migration policies](https://developer.apple.com/library/mac/documentation/cocoa/conceptual/CoreDataVersioning/Articles/vmInitiating.html); we can ignore these options in our simplistic stack.

let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel:model)

do {
    try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
} catch {
    print("error creating psc: \(error)")
}

//: Create a [Managed Object Context](https://developer.apple.com/library/ios/documentation/DataManagement/Devpedia-CoreData/managedObjectContext.html) and attach the PSC to it. We'll use `.MainQueueConcurrencyType` in a single threaded environment.

let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

//: The stack is now setup and ready to use. Create a new `City` entity and insert it into the context. This is done by calling `insertNewObjectForEntityForName` on `NSEntityDescription` and including the name of the entity and the context that should create it. This will return an `NSManagedObject` instance for our entity. We can then set attribute values on the entity using key paths. A typical app, with a more complex data model, may [create subclasses of `NSManagedObject`](http://stackoverflow.com/questions/7947458/why-exactly-would-one-subclass-nsmanagedobject) for specific entities and set attributes using instance variables instead of key paths.
let phoneNumeberDescription = NSEntityDescription.entity(forEntityName: Entity.phoneNumber, in: managedObjectContext)

let member1 = NSEntityDescription.insertNewObject(forEntityName: Entity.member, into: managedObjectContext)
member1.setValue("Member 1", forKeyPath: Attribute.name)
member1.setValue(0.0, forKeyPath: Attribute.age)
let phoneNumber1 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber1.setValue("Num1", forKeyPath: Attribute.name)
phoneNumber1.setValue("12", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber1.setValue(member1, forKeyPath: Relationship.member)
let phoneNumber2 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber2.setValue("Num2", forKeyPath: Attribute.name)
phoneNumber2.setValue("13", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber2.setValue(member1, forKey: Relationship.member)
let phoneNumber3 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber3.setValue("Num3", forKeyPath: Attribute.name)
phoneNumber3.setValue("14", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber3.setValue(member1, forKey: Relationship.member)

let member2 = NSEntityDescription.insertNewObject(forEntityName: Entity.member, into: managedObjectContext)
member2.setValue("Member 2", forKeyPath: Attribute.name)
member2.setValue(1.0, forKeyPath: Attribute.age)
let phoneNumber21 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber21.setValue("Num1", forKeyPath: Attribute.name)
phoneNumber21.setValue("12", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber21.setValue(member2, forKeyPath: Relationship.member)
let phoneNumber22 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber22.setValue("Num2", forKeyPath: Attribute.name)
phoneNumber22.setValue("13", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber22.setValue(member2, forKey: Relationship.member)
let phoneNumber23 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber23.setValue("Num3", forKeyPath: Attribute.name)
phoneNumber23.setValue(nil, forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber23.setValue(member2, forKey: Relationship.member)

let member3 = NSEntityDescription.insertNewObject(forEntityName: Entity.member, into: managedObjectContext)
member3.setValue("Member 3", forKeyPath: Attribute.name)
let phoneNumber213 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber213.setValue("Num1", forKeyPath: Attribute.name)
phoneNumber213.setValue("12", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber213.setValue(member3, forKeyPath: Relationship.member)
let phoneNumber223 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber223.setValue("Num2", forKeyPath: Attribute.name)
phoneNumber223.setValue("13", forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber223.setValue(member3, forKey: Relationship.member)
let phoneNumber233 = NSManagedObject(entity: phoneNumeberDescription!, insertInto: managedObjectContext)
phoneNumber233.setValue("Num3", forKeyPath: Attribute.name)
phoneNumber233.setValue(nil, forKeyPath: Attribute.canonizedPhoneNum)
phoneNumber233.setValue(member3, forKey: Relationship.member)

class NotificationListener: NSObject {
    @objc func handleDidSaveNotification(_ notification:Notification) {
        print("did save notification received: \(notification)")
    }
}

let delegate = NotificationListener()
NotificationCenter.default.addObserver(delegate, selector: #selector(NotificationListener.handleDidSaveNotification(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)

//: Save the context so it's populated with the entities.
do {
    try managedObjectContext.save()
} catch {
    print("error saving context: \(error)")
}

//: After the context saved, we can query it by creating a [Fetch Request](https://developer.apple.com/library/ios/documentation/DataManagement/Devpedia-CoreData/fetchRequest.html). We'll use a [predicate](https://developer.apple.com/library/mac/documentation/cocoa/reference/Foundation/Classes/NSPredicate_Class/Reference/NSPredicate.html) to return `Neighborhood` entities with a `population` greater than 15000. Only two such entities exist in the data model.

var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity.member)
//fetchRequest.predicate = NSPredicate(format: "ANY %K == %@", "12", #keyPath(Member.phoneNumbers.canonizedPhoneNum), "12")
fetchRequest.predicate = NSPredicate(format: "ANY %K == %@", #keyPath(Member.phoneNumbers.canonizedPhoneNum), NSNull())

var results: [NSManagedObject] = []

do {
    results = try managedObjectContext.fetch(fetchRequest)
} catch {
    print("error executing fetch request: \(error)")
}
print(member2.value(forKeyPath: #keyPath(Member.phoneNumbers.canonizedPhoneNum)))
//assert(results.count >= 2, "wrong number of results")
print(results.compactMap { $0.value(forKey: Attribute.name) })



var fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: Entity.member)
//fetchRequest.predicate = NSPredicate(format: "ANY %K == %@", "12", #keyPath(Member.phoneNumbers.canonizedPhoneNum), "12")
fetchRequest2.predicate = NSPredicate(format: "(%K > 0)", #keyPath(Member.age)) //, #keyPath(Member.age))

var results2: [NSManagedObject] = []

do {
    results2 = try managedObjectContext.fetch(fetchRequest2)
} catch {
    print("error executing fetch request: \(error)")
}
print("\t-------\tMembers\t-------")
print(member1.value(forKeyPath: #keyPath(Member.age)))
print(member2.value(forKeyPath: #keyPath(Member.age)))
print(member3.value(forKeyPath: #keyPath(Member.age)))
print([member1, member2, member3].compactMap { $0.value(forKey: Attribute.age) })
print("\t-------\tResults\t-------")
print(results2.compactMap { $0.value(forKey: Attribute.name) })
print(results2)

//
////: Every managed object is assigned managed object id from the context. An [`NSManagedObjectID`](https://developer.apple.com/library/mac/documentation/cocoa/reference/CoreDataFramework/Classes/NSManagedObjectID_Class/Reference/NSManagedObjectID.html) is a unique id that can be used to reference managed objects across contexts. Consider the example below where `secondObject` is returned from another context by referencing a managed object id.
//
//var firstObject: NSManagedObject?
//var secondObject: NSManagedObject?
//
//guard let moid = results.first?.objectID else { fatalError("no object id was found") }
//let secondContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
//secondContext.persistentStoreCoordinator = persistentStoreCoordinator
//
//do {
//    firstObject = try managedObjectContext.existingObject(with: moid)
//    secondObject = try secondContext.existingObject(with: moid)
//} catch {
//    print("error finding objects: \(error)")
//}
//
//firstObject?.value(forKey: Attribute.Name)
//secondObject?.value(forKey: Attribute.Name)
//
////: Attributes and relationships on a managed object may be changed. When the context is saved the changes made to the managed objects are persisted. In the example below the `population` attribute of a `Neighborhood` entity is changed and the context to saved.
//
//fetchRequest = NSFetchRequest(entityName: Entity.Neighborhood)
//fetchRequest.predicate = NSPredicate(format: "name = %@", "Belltown")
//
//do {
//    results = try managedObjectContext.fetch(fetchRequest)
//} catch {
//    print("error executing fetch: \(error)")
//}
//
//var managedObject = results.first
//
//managedObject?.value(forKey: Attribute.Name)
//managedObject?.setValue(1000, forKey: Attribute.Population)
//
//do {
//    let objectId = (managedObject?.objectID)!
//    try managedObjectContext.save()
//    managedObject = try managedObjectContext.existingObject(with: objectId)
//} catch {
//    print("error finding object: \(error)")
//}
//
//managedObject?.value(forKey: Attribute.Name)
//
//guard let managedObject = managedObject else { fatalError() }
//
////: Objects can be deleted through the context. Once deleted, they can no longer be retrieved by object id.
//do {
//    managedObjectContext.delete(managedObject)
//    try managedObjectContext.save()
//} catch {
//    print("error deleting object: \(error)")
//}
//
////: This should fail, with object id not found. The object has been deleted.
//do {
//    let _ = try managedObjectContext.existingObject(with: managedObject.objectID)
//} catch {
//    print("expect to receive error finding object: \(error)")
//}
//
////: That wraps up a basic introduction to Core Data using a Swift and a Playground. The Core Data framework is big and there's [much more explore](http://www.objc.io/issue-4/). For more information, consider reading through the [Core Data Programming Guide](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/Articles/cdBasics.html) or looking at the source for a Core Data [template project in Xcode](http://code.tutsplus.com/tutorials/core-data-from-scratch-core-data-stack--cms-20926).


//: [Next](@next)
