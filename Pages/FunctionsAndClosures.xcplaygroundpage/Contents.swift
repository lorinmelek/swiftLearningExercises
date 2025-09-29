//: ## Functions

//: ### Basic Function Syntax
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday") // "Hello Bob, today is Tuesday."

//: ### Function Parameters and Return Values

//: Functions without parameters
func sayHelloWorld() -> String {
    return "Hello, world!"
}
print(sayHelloWorld())

//: Functions without return values
func greet(person: String) {
    print("Hello, \(person)!")
}
greet(person: "Dave")

//: Functions with multiple return values (using tuples)
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"

//: Optional tuple return types
func minMaxSafe(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMaxSafe(array: []) {
    print("min is \(bounds.min) and max is \(bounds.max)")
} else {
    print("Array is empty")
}

//: Functions with implicit return (single-expression functions)
func greeting(for person: String) -> String {
    "Hello, " + person + "!"  // No 'return' needed
}
print(greeting(for: "Dave"))

//: ### Argument Labels and Parameter Names
//: Each parameter has both an argument label and a parameter name
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))

//: Omitting argument labels with underscore
func someFunction(_ firstParameter: Int, secondParameter: Int) {
    print("\(firstParameter) \(secondParameter)")
}
someFunction(1, secondParameter: 2)

//: Default parameter values
func greetWithDefault(person: String, greeting: String = "Hello") -> String {
    return "\(greeting), \(person)!"
}
print(greetWithDefault(person: "Taylor"))                    // "Hello, Taylor!"
print(greetWithDefault(person: "Taylor", greeting: "Hi"))    // "Hi, Taylor!"

//: ### Variadic Parameters
//: A variadic parameter accepts zero or more values of a specified type
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
print(arithmeticMean(1, 2, 3, 4, 5))        // 3.0
print(arithmeticMean(3, 8.25, 18.75))       // 10.0

//: ### In-Out Parameters
//: In-out parameters allow a function to modify a parameter's value
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, anotherInt is now 3"

//: ### Function Types
//: Every function has a specific function type
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
// Both functions have the type: (Int, Int) -> Int

//: Using function types
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")  // 5
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")  // 6

//: Function types as parameter types
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)  // "Result: 8"

//: Function types as return types
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

//: ### Nested Functions
//: Functions can be defined inside other functions
func chooseStepFunctionNested(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

//: ## Closures

//: ### Closure Expression Syntax
//: Closures are self-contained blocks of functionality that can be passed around
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

//: Full closure syntax
let reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reversedNames) // ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

//: ### Inferring Type from Context
//: Swift can infer parameter types and return type
let inferredReversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })

//: ### Implicit Returns from Single-Expression Closures
let implicitReversedNames = names.sorted(by: { s1, s2 in s1 > s2 })

//: ### Shorthand Argument Names
//: Swift provides shorthand argument names: $0, $1, $2, etc.
let shorthandReversedNames = names.sorted(by: { $0 > $1 })

//: ### Operator Methods
//: Swift's String type defines string-specific implementation of >
let operatorReversedNames = names.sorted(by: >)

//: ### Trailing Closures
//: If a closure is the last parameter, you can use trailing closure syntax
func someFunctionThatTakesAClosure(closure: () -> Void) {
    closure()
}

// Without trailing closure
someFunctionThatTakesAClosure(closure: {
    print("Inside closure")
})

// With trailing closure
someFunctionThatTakesAClosure() {
    print("Inside closure")
}

// If closure is the only argument, you can omit parentheses
someFunctionThatTakesAClosure {
    print("Inside closure")
}

//: Trailing closures are especially useful for long closures
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
print(strings) // ["OneSix", "FiveEight", "FiveOneZero"]

//: ### Capturing Values
//: A closure can capture constants and variables from its surrounding context
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount  // Captures runningTotal and amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
print(incrementByTen())  // 10
print(incrementByTen())  // 20
print(incrementByTen())  // 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven())  // 7
print(incrementBySeven())  // 14

//: The original incrementer still has its own captured values
print(incrementByTen())  // 40

//: ### Closures Are Reference Types
//: When you assign a closure to a constant or variable, you're setting a reference
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())  // 50 (shares the same captured runningTotal)

//: ### Escaping Closures
//: A closure is said to escape when it's stored for later execution
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()  // Closure is called before function returns
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)  // 200

completionHandlers.first?()
print(instance.x)  // 100

//: ### Autoclosures
//: An autoclosure automatically wraps an expression in a closure
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Chris!"
// The expression is automatically wrapped in a closure

//: Autoclosures that escape
var customerProviders: [() -> String] = []

func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}

//: ### Practical Closure Examples

//: Filter
let numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let evenNumbers = numbers2.filter { $0 % 2 == 0 }
print(evenNumbers)  // [2, 4, 6, 8, 10]

//: Map
let squared = numbers2.map { $0 * $0 }
print(squared)  // [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

//: Reduce
let sum = numbers2.reduce(0) { $0 + $1 }
print(sum)  // 55

//: Chaining
let result = numbers2
    .filter { $0 % 2 == 0 }
    .map { $0 * $0 }
    .reduce(0, +)
print(result)  // 220 (4 + 16 + 36 + 64 + 100)
