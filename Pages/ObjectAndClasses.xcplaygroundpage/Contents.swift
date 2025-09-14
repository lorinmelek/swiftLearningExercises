
//: ## Objects and Classes

//: You can define a class using the `class` keyword
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
print(shapeDescription) // "A shape with 7 sides."

//: You can create a subclass using the `:` syntax
class NamedShape: Shape {
    var name: String
    init(name: String) {
        self.name = name
    }
    override func simpleDescription() -> String {
        return "A shape named \(name) with \(numberOfSides) sides."
    }
}

var namedShape = NamedShape(name: "MyShape")
namedShape.numberOfSides = 5
print(namedShape.simpleDescription()) // "A shape named MyShape with 5 sides."


class Square: NamedShape {
    var sideLength: Double
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    func area() -> Double {
        return sideLength * sideLength
    }
    override func simpleDescription() -> String {
            return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.0, name: "my test square")
test.area()
test.simpleDescription()
print(test.area())  // 25.0
print(test.simpleDescription())  // "A square with sides of length 5.0."

//: You can define a class with a property that has a getter and setter using `get` and `set`
class Circle: NamedShape {
    var radius: Double
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 0
    }
    var circumference: Double {
        get {
            return 2 * .pi * radius
        }
        set {
            radius = newValue / (2 * .pi)
        }
    }
    override func simpleDescription() -> String {
        return "A circle with radius \(radius)."
    }
}
let circle = Circle(radius: 3.0, name: "my circle")
print(circle.circumference)  // 18.84955592153876
circle.circumference = 31.41592653589793
print(circle.radius)  // 5.0
print(circle.simpleDescription())  // "A circle with radius 5.0."

//: ## Static Members in Classes
//: `static` means the property or method belongs to the class itself,
//: not to individual objects. You access them with ClassName.property.

class MathHelper {
    static let pi = 3.14159
    
    static func square(_ x: Double) -> Double {
        return x * x
    }
}

print(MathHelper.pi)                // 3.14159
print(MathHelper.square(5))         // 25.0

// let helper = MathHelper() // not needed


//: ## Final Classes
//: `final` prevents a class from being subclassed.
//: Useful when you want to guarantee no one overrides or inherits your class.

final class Logger {
    func log(_ message: String) {
        print("LOG:", message)
    }
}

let logger = Logger()
logger.log("App started.")  // App started.

// Trying to inherit from Logger would be a compile-time error:
// class CustomLogger: Logger {}   // cannot inherit from final class
