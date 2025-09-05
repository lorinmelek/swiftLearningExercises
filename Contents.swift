/* # A Swift Tour
    This playground is a brief tour of the Swift programming language.
    It introduces the basic concepts of the language, and provides a brief overview of its syntax.
*/

//: ## Constants and Variables

//: You declare constants with the `let` keyword and variables with the `var` keyword
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
//: You can declare multiple constants or variables on a single line, separated by commas
var x = 0.0, y = 0.0, z = 0.0
//: Constants and variables must be declared before they are used
//: You can use type annotations to specify the type of a constant or variable
var welcomeMessage: String  // Type annotation
welcomeMessage = "Hello"
//: You can change the value of a variable after it is declared
currentLoginAttempt += 1
//: You cannot change the value of a constant after it is declared
// maximumNumberOfLoginAttempts += 1 // This will cause an error


//: ## Semicolons and Integers

//: You do not need to write a semicolon at the end of a line, unless you want to write multiple statements on a single line
let cat = "🐱"; print(cat)
//: Swift has several integer types, with different sizes and signedness
let minValue = UInt8.min  // Minimum value for an 8-bit unsigned integer
let maxValue = UInt8.max  // Maximum value for an 8-bit unsigned integer
//: ## Type Safety and Type Inference
//: Swift is a type-safe language, which means that the type of a variable cannot be changed after it is declared
var welcome = "Hello"  // Inferred to be of type String
// welcome = 42 // This will cause an error
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
print(widthLabel) // "The width is 94"

//: You can use string interpolation to include the value of a variable in a string
let apples = 3          // Inferred to be of type Int
let oranges = 5        // Inferred to be of type Int
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
print(appleSummary) // "I have 3 apples."
print(fruitSummary) // "I have 8 pieces of fruit."


//: ## Arrays and Dictionaries
//: You can create an array using square brackets
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
//: You can create a dictionary using square brackets and colons
var occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic"]
occupations["Jayne"] = "Public Relations"
//: You can create empty arrays and dictionaries using the initializer syntax
let emptyArray = [String]()  // Empty array of Strings
let emptyDictionary = [String: Float]()  // Empty dictionary with String keys and Float values
//: You can also create empty arrays and dictionaries using shorthand syntax
shoppingList = []  // Empty array of Strings
occupations = [:]  // Empty dictionary with String keys and String values


//: ## Control Flow - For Loops and If Statements

//: You can use a `for` loop to iterate over the elements of an array or dictionary
for item in shoppingList {
    print(item)
}
for (name, occupation) in occupations {
    print("\(name): \(occupation)")
}

//: You can use an `if` statement to execute code based on a condition
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print("Team score: \(teamScore)") // "Team score: 11"
//: You can use `if` and `let` together to work with optional values
var optionalString: String? = "Hello"
print(optionalString == nil) // false
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello, stranger"
}
print(greeting) // "Hello, John Appleseed"

//: You can use the nil-coalescing operator (`??`) to provide a default value for an optional
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
print(informalGreeting) // "Hi John Appleseed"

//: You can use a `switch` statement to execute code based on the value of a variable
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":  // Multiple values in a single case
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):  // Value binding and a where clause
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

//: You can use a `for` loop with a range to iterate over a sequence of numbers
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)
// Prints "25"


// Functions and Closures
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
// Prints "Hello Bob, today is Tuesday."
//: You can use a shorthand syntax to write closures
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// Sort names in reverse order using a closure
let reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reversedNames) // ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

//: You can simplify the closure by using type inference and shorthand argument names
let simplifiedReversedNames = names.sorted(by: { s1, s2 in s1 > s2 })
let evenMoreSimplifiedReversedNames = names.sorted(by: { $0 > $1 })
let shortestReversedNames = names.sorted(by: >)
print(shortestReversedNames) // ["Ewa", "Daniella", "Chris", "Barry", "Alex"]


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


//: You can define a class with a property that has a getter and setter
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


//: ## Enumerations and Structures

//: You can define an enumeration using the `enum` keyword
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue
print("Ace raw value: \(aceRawValue)")  // Ace raw value: 1

//: You can define an enumeration with associated values
enum ServerResponse {
    case result(String, String)
    case failure(String)
}
let success = ServerResponse.result("6:00 am", "8:09 pm")   // success is of type ServerResponse
let failure = ServerResponse.failure("Out of cheese.")        // failure is of type ServerResponse
switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
}

//: You can define a structure using the `struct` keyword
struct Card {
    var rank: Rank
    var suit: String
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit)"
    }
}
let threeOfSpades = Card(rank: .three, suit: "spades")
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
print(threeOfSpadesDescription)  // "The 3 of spades"


//: ## Concurrency

//: ## With this structure, you can run multiple tasks simultaneously in Swift and collect their results as they complete. This provides both speed and organized concurrency.
//: ## Use async let to call an asynchronous function, letting it run in parallel with other asynchronous code. When you use the value it returns, write await.
func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}
func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), user ID \(userID)"
    print(greeting)
}

//: ## Use Task to call asynchronous functions from synchronous code, without waiting for them to return.
Task {
    await connectUser(to: "primary")
}
// Prints "Hello Guest, user ID 97"


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


//: ## Error Handling

enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
// Prints "Job sent"

//: ## try? attempts a throwing function and returns its result as an optional — nil if an error is thrown.
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

//: ## defer ensures cleanup code is executed at the end of the scope, no matter how the function exits.
/*
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]


func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }


    let result = fridgeContent.contains(food)
    return result
}
if fridgeContains("banana") {
    print("Found a banana")
}
print(fridgeIsOpen)
 */
// Prints "false"


//: Generics

//: ## A generic function lets you write one function that works with any type, instead of duplicating code for each type.
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes: 4)

//: ## A generic enum stores values of any type, letting you wrap or represent optional or stateful data flexibly.
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)


//: ## A where clause adds constraints to generic parameters, requiring them to conform to protocols or match each other.

func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
   return false
}
anyCommonElements([1, 2, 3], [3])



//: ## Language Guide
//: The Basics
