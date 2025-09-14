//: ## Protocols and Extensions
                        
protocol ExampleProtocol {
     var simpleDescription: String { get }
     mutating func adjust()
}

//: ## Classes, enumerations, and structures can all adopt protocols.

class SimpleClass: ExampleProtocol {
     var simpleDescription: String = "A very simple class."
     var anotherProperty: Int = 69105
     func adjust() {
          simpleDescription += "  Now 100% adjusted."
     }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
     var simpleDescription: String = "A simple structure"
     mutating func adjust() { //: mutating func allows a method in a struct or enum to modify its properties or reassign self. When variable in it should be change by value."
          simpleDescription += " (adjusted)"
     }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
                    
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
 }
print(7.simpleDescription)
// Prints "The number 7"

//: ## Even if the runtime object is a class, when you reference it through a protocol type, the compiler only exposes what the protocol defines — nothing extra.
let protocolValue: any ExampleProtocol = a
print(protocolValue.simpleDescription)
// Prints "A very simple class.  Now 100% adjusted."
// print(protocolValue.anotherProperty)  // Uncomment to see the error

//: ## Protocols and Extensions Examples

// Protocol with Associated Type
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // concrete type Item = Int
    private var items = [Int]()
    mutating func append(_ item: Int) {
        items.append(item)
    }
    var count: Int { items.count }
    subscript(i: Int) -> Int { items[i] }
}

var stack = IntStack()
stack.append(10)
stack.append(20)
print("Stack count:", stack.count) // 2
print("Stack[0]:", stack[0])       // 10


// Protocol Inheritance + Default Implementation
protocol Describable {
    func describe() -> String
}
protocol JSONConvertible: Describable {
    func toJSON() -> String
}

extension JSONConvertible {
    func describe() -> String { "JSONConvertible object" }
    func toJSON() -> String { "{}" } // default implementation
}

struct User: JSONConvertible {
    let name: String
    let age: Int
    func toJSON() -> String {
        return "{ \"name\": \"\(name)\", \"age\": \(age) }"
    }
}

let user = User(name: "Alice", age: 30)
print(user.describe())  // JSONConvertible object
print(user.toJSON())    // { "name": "Alice", "age": 30 }


// Protocol Extensions with Constraints
protocol Summable {}
extension Int: Summable {}
extension Double: Summable {}

extension Array where Element: Summable {
    func sum() -> Element {
        return reduce(0) { ($0 as! Numeric) + ($1 as! Numeric) } // see note below
    }
}
// NOTE: Swift does not have a "Summable" operator by default.
// A better real-world way: constrain to Numeric.

extension Array where Element: Numeric {
    func numericSum() -> Element {
        return reduce(0, +)
    }
}

print([1, 2, 3].numericSum())      // 6
print([1.5, 2.5, 3.5].numericSum()) // 7.5


// Using Protocols for Polymorphism
protocol Vehicle {
    var maxSpeed: Int { get }
    func startEngine()
}

class Car: Vehicle {
    var maxSpeed: Int { 180 }
    func startEngine() { print("Car engine started") }
}

class Bike: Vehicle {
    var maxSpeed: Int { 60 }
    func startEngine() { print("Bike ready") }
}

let vehicles: [Vehicle] = [Car(), Bike()]
for v in vehicles {
    print("Max speed:", v.maxSpeed)
    v.startEngine()
}


// Extending Built in Types
extension String {
    func reversedWords() -> String {
        return self.split(separator: " ")
                   .reversed()
                   .joined(separator: " ")
    }
}
print("Swift is powerful".reversedWords()) // "powerful is Swift"

