//: ## Functions

func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday") // Prints "Hello Bob, today is Tuesday."

// Multiple return values
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

//: ## Closures
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

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
