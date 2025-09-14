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

//: ## Higher-Order Functions in Swift

let numbers = [1, 2, 3, 4, 5, 6, 7]

// 1) map
let squares = numbers.map { $0 * $0 }
print("Squares:", squares) // [1, 4, 9, 16, 25, 36, 49]

// 2) filter
let evens = numbers.filter { $0 % 2 == 0 }
print("Evens:", evens) // [2, 4, 6]

// 3) reduce
let sum = numbers.reduce(0, +)
print("Sum:", sum) // 28

// 4) compactMap
// remove Nil values, unwrap.
let possibleNumbers = ["1", "2", "three", "4", "five"]
let validInts = possibleNumbers.compactMap { Int($0) }
print("Valid integers:", validInts) // [1, 2, 4]

// 5) flatMap
// convert nested arrays to one dimensional
let nested = [[1, 2], [3, 4], [5]]
let flattened = nested.flatMap { $0 }
print("Flattened:", flattened) // [1, 2, 3, 4, 5]

// 6) forEach
// it is a lopp but reutns nothing
numbers.forEach { print("Number:", $0) }

// 7) contains
let hasFour = numbers.contains(4)
print("Contains 4?", hasFour) // true

// 8) allSatisfy
let allPositive = numbers.allSatisfy { $0 > 0 }
print("All > 0?", allPositive) // true

// 9) sorted
let sortedDesc = numbers.sorted(by: >)
print("Sorted descending:", sortedDesc)

// 10) prefix / drop
let firstThree = numbers.prefix(3)
print("First three:", firstThree) // [1, 2, 3]
let dropped = numbers.dropFirst(3)
print("Drop first three:", dropped) // [4, 5, 6, 7]

// 11) first(where:)
if let firstEven = numbers.first(where: { $0 % 2 == 0 }) {
    print("First even:", firstEven) // 2
}

// 12) removeAll(where:)
var mutableNumbers = numbers
mutableNumbers.removeAll(where: { $0 > 4 })
print("After removing >4:", mutableNumbers) // [1, 2, 3, 4]

// 13) zip
let letters = ["A", "B", "C", "D"]
let zipped = Array(zip(numbers, letters))
print("Zipped:", zipped) // [(1, "A"), (2, "B"), (3, "C"), (4, "D")]

// 14) mapValues (dictionary için)
let occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic"]
let loud = occupations.mapValues { $0.uppercased() }
print("Loud occupations:", loud)

// 15) Dictionary(grouping:by:)
let names = ["Liam", "Lora", "Alex", "Anna", "Bob"]
let grouped = Dictionary(grouping: names) { $0.first! }
print("Grouped by first letter:", grouped)
