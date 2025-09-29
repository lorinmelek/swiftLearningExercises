//: ## Properties

//: ### Stored Properties
//: Store constant and variable values as part of an instance

struct FixedLengthRange {
    var firstValue: Int
    let length: Int  // Constant property
}

var range = FixedLengthRange(firstValue: 0, length: 3)
range.firstValue = 6  // OK
// range.length = 4   // Error! length is constant

//: Structs are VALUE TYPES - constant instances have constant properties
let constRange = FixedLengthRange(firstValue: 0, length: 4)
// constRange.firstValue = 6  // Error!

//: Classes are REFERENCE TYPES - properties can change even if instance is constant
class DataManager {
    var data: [String] = []
}
let manager = DataManager()
manager.data.append("item")  // OK!

//: ### Lazy Stored Properties
//: Initial value isn't calculated until first use - useful for expensive operations

class DataImporter {
    var filename = "data.txt"
    init() { print("DataImporter created") }
}

class LazyManager {
    lazy var importer = DataImporter()  // Must be 'var', not 'let'
}

let lazyManager = LazyManager()
print("Manager created")
// DataImporter NOT created yet
print(lazyManager.importer.filename)
// NOW created: "DataImporter created"

//: ### Computed Properties
//: Don't store a value - provide getter and optional setter

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Point()
    
    var center: Point {
        get {
            Point(x: origin.x + size.x / 2, y: origin.y + size.y / 2)
        }
        set {  // Default parameter name is 'newValue'
            origin.x = newValue.x - size.x / 2
            origin.y = newValue.y - size.y / 2
        }
    }
}

var square = Rect(origin: Point(x: 0, y: 0), size: Point(x: 10, y: 10))
print(square.center)  // Point(x: 5.0, y: 5.0)
square.center = Point(x: 15, y: 15)
print(square.origin)  // Point(x: 10.0, y: 10.0)

//: Read-only computed properties (no setter)
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        width * height * depth  // Implicit return
    }
}

let box = Cuboid(width: 4, height: 5, depth: 2)
print(box.volume)  // 40.0

//: ### Property Observers
//: Observe and respond to changes in property values

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {  // Called before value is stored (default param: newValue)
            print("About to set to \(newValue)")
        }
        didSet {  // Called after value is stored (default param: oldValue)
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let counter = StepCounter()
counter.totalSteps = 200
// About to set to 200
// Added 200 steps

//: ### Property Wrappers
//: Add reusable logic to property storage

@propertyWrapper
struct Clamped {
    private var value: Int
    private let range: ClosedRange<Int>
    
    var wrappedValue: Int {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
    
    init(wrappedValue: Int, _ range: ClosedRange<Int>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

struct Game {
    @Clamped(0...100) var health: Int = 100
}

var game = Game()
game.health = 150
print(game.health)  // 100 (capped)
game.health = -10
print(game.health)  // 0 (capped)

//: Projected values (using $)
@propertyWrapper
struct Tracked {
    private var value: Int
    private(set) var projectedValue: Bool = false  // Was value modified?
    
    var wrappedValue: Int {
        get { value }
        set {
            projectedValue = (newValue != value)
            value = newValue
        }
    }
    
    init(wrappedValue: Int) {
        self.value = wrappedValue
    }
}

struct Player {
    @Tracked var score: Int = 0
}

var player = Player()
player.score = 10
print(player.$score)  // true (was modified)

//: ### Type Properties
//: Belong to the type itself, not instances

struct AudioChannel {
    static let thresholdLevel = 10  // Type constant
    static var maxInputLevel = 0    // Type variable
    
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevel {
                AudioChannel.maxInputLevel = currentLevel
            }
        }
    }
}

var left = AudioChannel()
var right = AudioChannel()

left.currentLevel = 7
print(AudioChannel.maxInputLevel)  // 7

right.currentLevel = 11
print(right.currentLevel)  // 10 (capped)
print(AudioChannel.maxInputLevel)  // 10

//: Use 'static' for value types, 'class' for overrideable class properties
class SomeClass {
    static var typeProperty = "Static"
    class var overrideable: String { "Override me" }
}

//: EXPERIMENT: Temperature converter with computed properties
struct Temperature {
    var celsius: Double
    
    var fahrenheit: Double {
        get { celsius * 9/5 + 32 }
        set { celsius = (newValue - 32) * 5/9 }
    }
    
    var kelvin: Double {
        get { celsius + 273.15 }
        set { celsius = newValue - 273.15 }
    }
}

var temp = Temperature(celsius: 0)
print("\(temp.celsius)°C = \(temp.fahrenheit)°F")  // 0.0°C = 32.0°F
temp.fahrenheit = 98.6
print("\(temp.celsius)°C")  // 37.0°C
