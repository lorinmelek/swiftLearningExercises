import Foundation

func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

func extract(_ a: Double, _ b: Double) -> Double {
    return a - b
}

func multiply(_ a: Double, _ b: Double) -> Double {
    return a * b
}

func divide(_ a: Double, _ b: Double) -> Double {
    guard b != 0 else {
        print("Error: Division by zero")
        return Double.nan
    }
    return a / b
}

print("add: \(add(10, 5))")
print("extract: \(extract(10, 5))")
print("multiply: \(multiply(10, 5))")
print("divide: \(divide(10, 5))")
