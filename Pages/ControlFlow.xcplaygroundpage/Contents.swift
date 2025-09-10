//: ## Control Flow - For Loops and If Statements

//: You can use a `for` loop to iterate over the elements of an array or dictionary
shoppingList = []  // Empty array of Strings
occupations = [:]  // Empty dictionary with String keys and String values
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
 //: ## Optional
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
