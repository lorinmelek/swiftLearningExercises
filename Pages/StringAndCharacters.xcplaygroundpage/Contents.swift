var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax

// you can add strings together
var variableString = "Horse"
variableString += " and carriage"
// variableString is now "Horse and carriage"

for character in "Dog!" {
    print(character)
}
// D
// o
// g
// !

//: ## Concatenating Strings and Characters
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome now equals "hello there"

//: ## String Interpolation
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"

let unusualMenagerie = "Koala, Snail, Penguin, Dromedary"
print("unusualMenagerie has \(unusualMenagerie.count) characters")

// you can access any index of string
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G

// you can insert character into a string or string into string
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"

//: ## Substrings
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"

//: ## String an Character Equality
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"

