import Foundation

// Enums

enum PaymentMethod: String, CaseIterable {
    case cash = "Cash"
    case creditCard = "Credit Card"
    case applePay = "Apple Pay"
}

enum NetworkResult {
    case success(data: String)
    case failure(error: String)
}

// Lazy
class ImageLoader {
// Lazy properties are initialized only when they are accessed for the first time
    lazy var imageData: String = {
        print("Loading image from server...")
        return "Image Data"
    }()
}

// Access Modifiers
public class Car {
    private var engineNumber: String = "ENG-12345" //it can only be accessed within this class
    fileprivate var color: String = "Red" //it can be accessed within the same file
    var model: String = "Tesla" //it can be accessed from anywhere
    
    func carInfo() -> String {
        return "Model: \(model), Engine: \(engineNumber)"
    }
}

// Static vs Class Functions
class MathHelper {
    static func square(_ x: Int) -> Int {
        return x * x
    }
    
    class func description() -> String {
        return "MathHelper class for calculations"
    }
}
// Static functions are associated with the class itself, while class functions can be overridden by subclasses
class AdvancedMathHelper: MathHelper {
    override class func description() -> String {
        return "AdvancedMathHelper for advanced calculations"
    }
}

// Delegate vs Closure

// Delegate Protocol
// A delegate protocol allows one object to communicate back to another object, typically used for callbacks.
protocol DownloaderDelegate: AnyObject {
    func didFinishDownloading(data: String)
}

class Downloader {
    weak var delegate: DownloaderDelegate?
    
    func startDownload() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let data = "Downloaded Data"
            DispatchQueue.main.async {
                self.delegate?.didFinishDownloading(data: data)
            }
        }
    }
}

// Closure Version
// A closure is a self-contained block of functionality that can be passed around and used in your code.
class ClosureDownloader {
    func startDownload(completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let data = "Downloaded Data via Closure"
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

// Protocol vs Abstract Class

protocol Animal {
    var name: String { get }
    func speak()
}

extension Animal {
    func info() {
        print("This is an animal named \(name).")
    }
}

struct Dog: Animal {
    var name: String
    func speak() {
        print("Woof!")
    }
}

struct Cat: Animal {
    var name: String
    func speak() {
        print("Meow!")
    }
}

// Playground Execution

print("=== ENUMS ===")
for method in PaymentMethod.allCases {
    print("Payment option: \(method.rawValue)")
}

let result: NetworkResult = .success(data: "User logged in")
switch result {
case .success(let data):
    print("Success with: \(data)")
case .failure(let error):
    print("Failure: \(error)")
}

print("\n=== LAZY ===")
let loader = ImageLoader()
print("Before accessing imageData")
print(loader.imageData)  // sadece burada yüklenir

print("\n=== ACCESS MODIFIERS ===")
let myCar = Car()
print(myCar.carInfo())

print("\n=== STATIC vs CLASS ===")
print("Square of 4: \(MathHelper.square(4))")
print(MathHelper.description())
print(AdvancedMathHelper.description())

print("\n=== DELEGATE vs CLOSURE ===")
class MyViewController: DownloaderDelegate {
    func didFinishDownloading(data: String) {
        print("Delegate received: \(data)")
    }
}
let vc = MyViewController()
let downloader = Downloader()
downloader.delegate = vc
downloader.startDownload()

let closureDownloader = ClosureDownloader()
closureDownloader.startDownload { data in
    print("Closure received: \(data)")
}

print("\n=== ABSTRACT yerine PROTOCOL ===")
let dog = Dog(name: "Buddy")
let cat = Cat(name: "Mia")
dog.speak()
cat.speak()
dog.info()
cat.info()
