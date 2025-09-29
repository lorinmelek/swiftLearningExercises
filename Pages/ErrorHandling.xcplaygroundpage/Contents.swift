//: ## Error Handling

//: ### Defining and Throwing Errors
//: Errors are represented by types that conform to the Error protocool
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

//: Functions that can throw errors are marked with `throws`
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

//: ### Handling Errors with do-catch
//: Use do-catch to handle errors
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
// Prints "Job sent"

//: You can catch specific error types
do {
    let response = try send(job: 1440, toPrinter: "Never Has Toner")
    print(response)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch PrinterError.noToner {
    print("Please add toner and try again.")
} catch PrinterError.outOfPaper {
    print("Please load more paper.")
} catch {
    print("Unknown error: \(error)")
}
// Prints "Please add toner and try again."

//: You can use pattern matching in catch blocks
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

func buySnack(selection: String) throws {
    throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
}

do {
    try buySnack(selection: "Candy Bar")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 5 coins."

//: ### Converting Errors to Optional Values
//: try? attempts a throwing function and returns its result as an optional — nil if an error is thrown.
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
print("Success: \(String(describing: printerSuccess))")  // Optional("Job sent")
print("Failure: \(String(describing: printerFailure))")  // nil

//: try? is useful when you want to handle all errors the same way
func fetchData() -> String? {
    return try? send(job: 100, toPrinter: "Office Printer")
}

//: ### Disabling Error Propagation
//: try! disables error propagation and asserts the call won't throw
//: If an error is actually thrown, you'll get a runtime error
// let guaranteedSuccess = try! send(job: 2000, toPrinter: "Bi Sheng")
//: Use try! only when you're certain the function won't throw

//: ### Specifying Cleanup Actions with defer
//: defer ensures cleanup code is executed at the end of the scope, no matter how the function exits.
//: Multiple defer statements execute in reverse order (LIFO - Last In, First Out)

var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
        print("Closing the fridge")
    }
    
    let result = fridgeContent.contains(food)
    return result
}

print("Before checking: \(fridgeIsOpen)")  // false
if fridgeContains("banana") {
    print("Found a banana")
}
print("After checking: \(fridgeIsOpen)")  // false
// Prints: "Closing the fridge"

//: defer is executed even if an error is thrown
func processFile(_ filename: String) throws {
    print("Opening file: \(filename)")
    defer {
        print("Closing file: \(filename)")
    }
    
    // Simulate file operations
    if filename == "corrupted.txt" {
        throw PrinterError.onFire  // Using existing error for demo
    }
    
    print("Processing file: \(filename)")
}

do {
    try processFile("data.txt")
} catch {
    print("Error: \(error)")
}

//: Multiple defer statements execute in reverse order
func demonstrateDefer() {
    defer { print("First defer - executes LAST") }
    defer { print("Second defer - executes SECOND") }
    defer { print("Third defer - executes FIRST") }
    print("Function body")
}
demonstrateDefer()
// Prints:
// Function body
// Third defer - executes FIRST
// Second defer - executes SECOND
// First defer - executes LAST

//: ### Rethrowing Functions
//: Functions can rethrow errors thrown by their function parameters
func processData(_ operation: () throws -> String) rethrows -> String {
    defer {
        print("Cleanup after operation")
    }
    return try operation()
}

let result1 = try? processData {
    return "Success!"
}

let result2 = try? processData {
    throw PrinterError.outOfPaper
}

print("Result 1: \(String(describing: result1))")  // Optional("Success!")
print("Result 2: \(String(describing: result2))")  // nil

//: Create a custom error type for a file system and handle different error cases
enum FileSystemError: Error {
    case fileNotFound(filename: String)
    case permissionDenied
    case diskFull(bytesNeeded: Int)
}

func saveFile(_ filename: String, size: Int) throws {
    if size > 1000 {
        throw FileSystemError.diskFull(bytesNeeded: size - 1000)
    }
    print("File \(filename) saved successfully")
}

do {
    try saveFile("photo.jpg", size: 1500)
} catch FileSystemError.fileNotFound(let name) {
    print("File not found: \(name)")
} catch FileSystemError.permissionDenied {
    print("You don't have permission to save this file")
} catch FileSystemError.diskFull(let bytes) {
    print("Disk is full. Need \(bytes) more bytes")
} catch {
    print("Unknown error: \(error)")
}
// Prints "Disk is full. Need 500 more bytes"
