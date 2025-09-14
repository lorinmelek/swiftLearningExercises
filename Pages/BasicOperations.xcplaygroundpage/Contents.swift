//: ## Assignment Operator
let b = 10
var a = 5
a = b

//: ## Arithmetic Operators
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0

"hello, " + "world"  // equals "hello, world"

//: ## Remainder Operator
9 % 4    // equals 1

//: ## Compound Assignment Operators
//: var a = 1 a += 2 // a is now equal to 3

//: ## Comparison Operators
/*
 1 == 1   // true because 1 is equal to 1
 2 != 1   // true because 2 isn't equal to 1
 2 > 1    // true because 2 is greater than 1
 1 < 2    // true because 1 is less than 2
 1 >= 1   // true because 1 is greater than or equal to 1
 2 <= 1   // false because 2 isn't less than or equal to 1
 */

//: ## Ternary Conditional Operator
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90

//: ## Nil-Coalescing Operator
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"

//: ## Logical Operators
// NOT Operator
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"

// AND Operator
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"

// OR Operator
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"


