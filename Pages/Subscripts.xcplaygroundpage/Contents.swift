//: ## Subscripts

//: Subscripts provide shortcuts to access elements in a collection, list, or sequence
//: Use square brackets [] to access elements

//: ### Basic Subscript Syntax
//: Arrays already have subscripts built-in
let numbers = [1, 2, 3, 4, 5]
print(numbers[0])  // 1 - using subscript
print(numbers[2])  // 3

//: Dictionaries also have subscripts
let colors = ["red": "#FF0000", "green": "#00FF00"]
print(colors["red"]!)  // "#FF0000"

//: ### Custom Subscripts
//: Create your own subscripts for custom types

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print(threeTimesTable[0])   // 0
print(threeTimesTable[1])   // 3
print(threeTimesTable[5])   // 15
print(threeTimesTable[10])  // 30

//: ### Read-Write Subscripts
//: Subscripts can have both getter and setter

struct Matrix {
    var grid: [Int]
    let rows: Int
    let columns: Int
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: 0, count: rows * columns)
    }
    
    subscript(row: Int, column: Int) -> Int {
        get {
            return grid[(row * columns) + column]
        }
        set {
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 3, columns: 3)
matrix[0, 0] = 1
matrix[1, 1] = 5
matrix[2, 2] = 9
print(matrix[0, 0])  // 1
print(matrix[1, 1])  // 5
print(matrix[2, 2])  // 9

//: ### Multiple Parameters
//: Subscripts can take multiple parameters

struct ChessBoard {
    var board: [[String]] = Array(repeating: Array(repeating: "·", count: 8), count: 8)
    
    subscript(row: Int, col: Int) -> String {
        get { board[row][col] }
        set { board[row][col] = newValue }
    }
    
    subscript(position: String) -> String {
        get {
            let col = Int(position.first!.asciiValue! - 97)  // 'a' = 0, 'b' = 1, etc.
            let row = Int(String(position.last!))! - 1
            return board[row][col]
        }
        set {
            let col = Int(position.first!.asciiValue! - 97)
            let row = Int(String(position.last!))! - 1
            board[row][col] = newValue
        }
    }
}

var chess = ChessBoard()
chess[0, 0] = "♜"  // Rook at (0,0)
chess["e2"] = "♟"  // Pawn at e2
print(chess[0, 0])  // ♜
print(chess["e2"])  // ♟

//: ### Type Subscripts
//: Static/class subscripts belong to the type itself

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

let earth = Planet[3]
print(earth)  // earth

//: Real World Example: Phone Book
struct PhoneBook {
    private var contacts: [String: String] = [:]
    
    subscript(name: String) -> String? {
        get {
            return contacts[name]
        }
        set {
            contacts[name] = newValue
        }
    }
}

var phoneBook = PhoneBook()
phoneBook["Ali"] = "555-1234"
phoneBook["Ayşe"] = "555-5678"
print(phoneBook["Ali"] ?? "Not found")  // "555-1234"

//: Real World Example: Shopping Cart with quantity
struct ShoppingCart {
    private var items: [String: Int] = [:]  // [item: quantity]
    
    subscript(item: String) -> Int {
        get {
            return items[item] ?? 0
        }
        set {
            if newValue > 0 {
                items[item] = newValue
            } else {
                items.removeValue(forKey: item)
            }
        }
    }
    
    var total: Int {
        return items.values.reduce(0, +)
    }
}

var cart = ShoppingCart()
cart["Apple"] = 5
cart["Banana"] = 3
print("Apples: \(cart["Apple"])")  // 5
print("Oranges: \(cart["Orange"])") // 0 (not in cart)
print("Total items: \(cart.total)") // 8

cart["Apple"] = 0  // Remove apples
print("Total items: \(cart.total)") // 3

//: Real World Example: Grid/Game Board
struct TicTacToe {
    private var board = Array(repeating: Array(repeating: " ", count: 3), count: 3)
    
    subscript(row: Int, col: Int) -> String {
        get { board[row][col] }
        set { board[row][col] = newValue }
    }
    
    func display() {
        for row in board {
            print(row.joined(separator: "|"))
        }
    }
}

var game = TicTacToe()
game[0, 0] = "X"
game[1, 1] = "O"
game[0, 2] = "X"
game.display()
// X| |X
//  |O|
//  | |

//: Real World Example:  Temperature converter with units
struct TemperatureConverter {
    var celsius: Double
    
    subscript(unit: String) -> Double {
        get {
            switch unit.lowercased() {
            case "c", "celsius":
                return celsius
            case "f", "fahrenheit":
                return celsius * 9/5 + 32
            case "k", "kelvin":
                return celsius + 273.15
            default:
                return celsius
            }
        }
        set {
            switch unit.lowercased() {
            case "c", "celsius":
                celsius = newValue
            case "f", "fahrenheit":
                celsius = (newValue - 32) * 5/9
            case "k", "kelvin":
                celsius = newValue - 273.15
            default:
                celsius = newValue
            }
        }
    }
}

var temp = TemperatureConverter(celsius: 0)
print("\(temp["C"])°C = \(temp["F"])°F = \(temp["K"])K")
// 0.0°C = 32.0°F = 273.15K

temp["F"] = 98.6
print("Body temp: \(temp["C"])°C")  // 37.0°C

//: Real World Example: Days in month
struct Calendar {
    static subscript(month: String) -> Int {
        switch month.lowercased() {
        case "january", "march", "may", "july", "august", "october", "december":
            return 31
        case "april", "june", "september", "november":
            return 30
        case "february":
            return 28
        default:
            return 0
        }
    }
}

print("Days in January: \(Calendar["January"])")   // 31
print("Days in February: \(Calendar["February"])") // 28
print("Days in April: \(Calendar["April"])")       // 30
