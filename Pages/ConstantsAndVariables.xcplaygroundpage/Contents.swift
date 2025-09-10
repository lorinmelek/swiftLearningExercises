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

var red, green, blue: Double // Multiple variables with type annotation


//: ## Semicolons
//: You do not need to write a semicolon at the end of a line, unless you want to write multiple statements on a single line
let cat = "🐱"; print(cat)

//: ## Integers
//: Swift has several integer types, with different sizes and signedness
let minValue = UInt8.min  // Minimum value for an 8-bit unsigned integer
let maxValue = UInt8.max  // Maximum value for an 8-bit unsigned integer
