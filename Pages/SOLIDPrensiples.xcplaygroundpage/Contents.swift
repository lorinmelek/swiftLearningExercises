//: ## 1. Single Responsibility Principle (SRP)

//A class should have only one reason to change.

// one class handles both data and saving
class Report {
    var text = "Report content"
    func saveToFile() { print("Saved to file") }
}

// we should separate responsibilities
class Report {
    var text = "Report content"
}
class ReportSaver {
    func save(report: Report) { print("Saved to file") }
}

// example: A waiter both takes orders and cooks. The waiter takes orders, the chef cooks each has one job.

//: ## 2. Open Closed Principle

//entities should be open for extension, but closed for modification.
protocol Shape {
    func area() -> Double
}

class Circle: Shape {
    var r: Double
    init(r: Double) { self.r = r }
    func area() -> Double { .pi * r * r }
}

class Square: Shape {
    var side: Double
    init(side: Double) { self.side = side }
    func area() -> Double { side * side }
}

// A power socket: you can plug in new devices (phone, laptop) without rewiring the socket.

//: ## 3. Liskov Substitution

class Bird {
    func fly() { print("Flying") }
}

class Sparrow: Bird {} // Works like a Bird

// If “all cars can be driven,” a bus also fits. But replacing a car with an airplane doesn’t make sense.

//: ## 4. Interface Segregation Principle (ISP)

protocol Printer {
    func printDocument()
}

protocol Scanner {
    func scanDocument()
}

class SimplePrinter: Printer {
    func printDocument() { print("Printing...") }
}
// you cannot expect from waitress to cook in a restaurant

//: ## 5. Dependency Inversion Principle (DIP)

protocol Database {
    func save(data: String)
}

class MySQL: Database {
    func save(data: String) { print("Saved in MySQL") }
}

class App {
    let db: Database
    init(db: Database) { self.db = db }
    func run() { db.save(data: "Hello") }
}

let app = App(db: MySQL())
app.run()
//: we should not combine to one specific protocol or sth. we should be flexible. For exapmle you have a light but it fit more than one brand, you should not implement it for just one brand. it works with all proper lights.
