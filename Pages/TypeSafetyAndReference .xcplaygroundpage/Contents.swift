//: ## Type Safety and Type Inference
//: Swift is a type safe language, which means that the type of a variable cannot be changed after it is declared


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
