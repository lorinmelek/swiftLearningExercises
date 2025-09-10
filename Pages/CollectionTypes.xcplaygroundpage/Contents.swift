//: ## Arrays and Dictionaries
//: You can create an array using square brackets

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

//: You can create a dictionary using square brackets and colons
var occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic"]
occupations["Jayne"] = "Public Relations"
//: You can create empty arrays and dictionaries using the initializer syntax
let emptyArray = [String]()  // Empty array of Strings
let emptyDictionary = [String: Float]()  // Empty dictionary with String keys and Float values
//: You can also create empty arrays and dictionaries using shorthand syntax
shoppingList = []  // Empty array of Strings
occupations = [:]  // Empty dictionary with String keys and String values


