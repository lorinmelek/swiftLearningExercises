//: ##Tuples
//: Tuples group multiple values into a single compound value

let http404Error = (404, "Not Found")  // Tuple of (Int, String)
//: You can decompose a tuple into separate constants or variables
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")       // "The status code is 404"
print("The status message is \(statusMessage)") // "The status message is Not Found"
//: You can ignore parts of a tuple by using an underscore (`_`)
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)") // "The status code is 404"
