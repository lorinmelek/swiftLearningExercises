//: ## Enumerations and Structures

//: You can define an enumeration using the `enum` keyword
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue
print("Ace raw value: \(aceRawValue)")  // Ace raw value: 1

//: You can define an enumeration with associated values
enum ServerResponse {
    case result(String, String)
    case failure(String)
}
let success = ServerResponse.result("6:00 am", "8:09 pm")   // success is of type ServerResponse
let failure = ServerResponse.failure("Out of cheese.")        // failure is of type ServerResponse

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
}

//: You can define a structure using the `struct` keyword
// Structs are value types
struct Card {
    var rank: Rank
    var suit: String
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit)"
    }
}
let threeOfSpades = Card(rank: .three, suit: "spades")
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
print(threeOfSpadesDescription)  // "The 3 of spades"

