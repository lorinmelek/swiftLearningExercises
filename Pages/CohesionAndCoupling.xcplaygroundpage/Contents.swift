/*
 ## Cohesion

High cohesion = everything inside the class serves one clear purpose (great).
 
Low cohesion = the class does a bit of everything (bad).
*/
/*
 ## Coupling: how tightly classes depend on each other:

 Low (loose) coupling = classes are easy to separate/replace (good).

 High (tight) coupling = changing one breaks the other (bad).
 */
struct Validator {
    func isValidEmail(_ email: String) -> Bool { email.contains("@") }
}

final class AuthService {
    func login(user: String, pass: String) -> Bool { user == "a" && pass == "123" }
}//high cohesion

protocol AuthServicing { func login(user: String, pass: String) -> Bool }

final class AuthService: AuthServicing {
    func login(user: String, pass: String) -> Bool { true }
}

final class Controller {
    let service: AuthServicing
    init(service: AuthServicing) { self.service = service }
}//loosly coupling 

