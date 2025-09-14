//: ## Generics

//: ## A generic function lets you write one function that works with any type, instead of duplicating code for each type.
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes: 4)

//: ## A generic enum stores values of any type, letting you wrap or represent optional or stateful data flexibly.
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)


//: ## A where clause adds constraints to generic parameters, requiring them to conform to protocols or match each other.

func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
   return false
}
anyCommonElements([1, 2, 3], [3])

//: ## Generics in Classes

// A generic class can work with *any type*, just like generic functions.
// Example: A generic Box that can wrap values of any type.
class Box<T> {
    var value: T
    init(_ value: T) {
        self.value = value
    }
    func describe() {
        print("Box contains:", value)
    }
}

// Use with Int
let intBox = Box(42)
intBox.describe()  // Box contains: 42

// Use with String
let stringBox = Box("Hello Generics")
stringBox.describe()  // Box contains: Hello Generics


// Constraints with where / protocol
// You can restrict the generic parameter with a protocol.
// Example: A generic Stack that requires Equatable elements.

class Stack<Element: Equatable> {
    private var items: [Element] = []
    
    func push(_ item: Element) {
        items.append(item)
    }
    
    func pop() -> Element? {
        return items.popLast()
    }
    
    func contains(_ item: Element) -> Bool {
        return items.contains(item)
    }
}

// Using the Stack with Ints (Int conforms to Equatable)
let intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)
print("Stack contains 20?", intStack.contains(20)) // true
print("Popped:", intStack.pop() ?? "nil")          // 20


// Multiple generic parameters
// Example: A Pair class that can hold two values of possibly different types.
class Pair<A, B> {
    var first: A
    var second: B
    init(first: A, second: B) {
        self.first = first
        self.second = second
    }
    func describe() {
        print("Pair:", first, "and", second)
    }
}

let pair = Pair(first: "Swift", second: 5.9)
pair.describe()  // Pair: Swift and 5.9
