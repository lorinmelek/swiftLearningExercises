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

//örneklendir
