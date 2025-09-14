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

//: ## Common String Functions in Swift

let text = "   Swift is amazing! 🚀   "

// Checking and Searching
print(text.hasPrefix("   Sw"))       // true
print(text.hasSuffix("   "))       // true
print(text.contains("amazing"))      // true

// Range search
if let range = text.range(of: "Swift") {
    print("Found at:", range)        // prints the Range inside the string
}

// Trimming and Casing
print(text.trimmingCharacters(in: .whitespaces))
// "Swift is amazing "  (removes spaces)

print(text.lowercased())   // "   swift is amazing!   "
print(text.uppercased())   // "   SWIFT IS AMAZING!   "
print(text.capitalized)    // "   Swift Is Amazing!   "

// Splitting and Joining
let csv = "apple,banana,cherry"
let fruits = csv.split(separator: ",")      // ["apple", "banana", "cherry"]
print(fruits)

let joined = fruits.joined(separator: " | ")
print(joined)   // "apple | banana | cherry"

// Replacing
let replaced = text.replacingOccurrences(of: "amazing", with: "powerful")
print(replaced)   // "   Swift is powerful!    "

//  Count and isEmpty
print("Character count:", text.count)  // counts grapheme clusters, including emojis
print("Is empty?", text.isEmpty)       // false

// Index and Substring
let greeting = "Hello, World!"
let start = greeting.index(greeting.startIndex, offsetBy: 7)
let end = greeting.index(greeting.startIndex, offsetBy: 11)
let substring = greeting[start...end]
print("Substring:", substring)   // "World"

// Iterating characters
for c in "Swift" {
    print(c)
}

// Converting
let numString = "123"
if let number = Int(numString) {
    print("Converted to Int:", number) // 123
}

// Random access (safe with indices)
let firstChar = text[text.startIndex]
print("First char:", firstChar)

// Mutating examples
var mutable = "Swift"
mutable.append("UI")
print(mutable)  // "SwiftUI"
mutable.remove(at: mutable.startIndex)
print(mutable)  // "wiftUI"
