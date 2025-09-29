//: ## Opaque Types

//: Opaque types hide the specific type, revealing only the protocol conformance
//: Use 'some' keyword before protocol name

//: ### Problem: Exposing Implementation Details

protocol Shape {
    func area() -> Double
}

struct Circle: Shape {
    var radius: Double
    func area() -> Double { 3.14 * radius * radius }
}

struct Square: Shape {
    var side: Double
    func area() -> Double { side * side }
}

// without opaque type - exposes concrete type
func makeCircle() -> Circle {
    return Circle(radius: 5)
}
// Problem: Can't change to Square without breaking code!

//: ### Solution: Opaque Types

// WITH opaque type - hides concrete type
func makeShape() -> some Shape {
    return Circle(radius: 5)  // Can change to Square anytime!
}

let shape = makeShape()
print(shape.area())  // 78.5
// We know it's 'some Shape', but not which specific type

//: ### Opaque vs Protocol Type

// Protocol type - can return different types
func makeAnyShape(isCircle: Bool) -> Shape {
    if isCircle {
        return Circle(radius: 5)
    } else {
        return Square(side: 5)
    }
}
// Flexible but loses type identity

// Opaque type - always returns same type
func makeOpaqueShape() -> some Shape {
    return Circle(radius: 5)  // Always same type (Circle)
    // Can't return Square here - must be consistent!
}
// Type identity preserved, implementation hidden

//: ### Real World Example: SwiftUI

protocol View {
    func render() -> String
}

struct Text: View {
    let content: String
    func render() -> String { content }
}

struct Button: View {
    let label: String
    func render() -> String { "[\(label)]" }
}

// SwiftUI pattern - body returns 'some View'
struct MyView {
    var body: some View {
        Text("Hello")  // Can change to Button later
    }
}

let view = MyView()
print(view.body.render())  // "Hello"

//: ### Returning Different Types with Generics

protocol Container {
    associatedtype Item
    var count: Int { get }
}

struct IntContainer: Container {
    typealias Item = Int
    var count: Int { 5 }
}

struct StringContainer: Container {
    typealias Item = String
    var count: Int { 3 }
}

// Opaque type with associated types
func makeContainer() -> some Container {
    return IntContainer()  // Type is hidden but consistent
}

let container = makeContainer()
print(container.count)  // 5

//: ### Simple Comparison

// Regular return type
func getCircle() -> Circle {
    Circle(radius: 10)
}
// Exposes implementation - can't change easily

// Protocol return type
func getShape() -> Shape {
    Circle(radius: 10)
}
// Flexible but loses type info

// Opaque return type
func getSomeShape() -> some Shape {
    Circle(radius: 10)
}
// Best of both - hides implementation, preserves type identity

//: ### Practical Example: API Response

protocol APIResponse {
    func data() -> String
}

struct SuccessResponse: APIResponse {
    let message: String
    func data() -> String { "Success: \(message)" }
}

struct ErrorResponse: APIResponse {
    let error: String
    func data() -> String { "Error: \(error)" }
}

// Hide which response type you're returning
func fetchData() -> some APIResponse {
    return SuccessResponse(message: "Data loaded")
    // Can change implementation without affecting caller
}

let response = fetchData()
print(response.data())  // "Success: Data loaded"

//: Real World Example
/*
 Imagine you run a coffee shop with a loyalty app,
 Without opaque types: You tell customers "I'm giving you a PhysicalStampCard for rewards." Now if you want to switch to a digital QR code system, you break everyone's expectations.
 With opaque types: You say "I'm giving you some RewardCard" - customers know they can collect points and redeem rewards, but they don't know (or care) if it's physical, digital, or blockchain-based. You can change the implementation anytime without affecting users.
 */
