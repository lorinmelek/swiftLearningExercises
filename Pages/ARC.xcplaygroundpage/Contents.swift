//: Automatic Reference Counting
//: Thiz automatically tracks strong references to class instances at compile time and runtime, deallocating them when the reference count drops to zero helping manage memory safely and efficiently.

class Person {
    let name: String
    init(name: String) { self.name = name; print("\(name) initialized") }
    deinit { print("\(name) deinitialized") }
}

var person1: Person? = Person(name: "Alex")
var person2 = person1 // Strong reference

person1 = nil  // person2 ia a strong referans. object do not deleted
person2 = nil  // there is no reference anymore. `deinit` called

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// struct ile örneklendir /lazy weak
// arc ın görevi ne mantık olarak göster
// memory leak 
