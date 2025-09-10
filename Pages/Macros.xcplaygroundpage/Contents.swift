//: Swift macros let you write compile-time code generation, automating boilerplate and enabling custom compile-time checking or code synthesis. Macros are like shortcuts that expand into detailed instructions at compile time — saving you from repeating the same steps over and over.

//: ## Freestanding Macros
func myFunction() {
    print("Currently running \(#function)")
    #warning("Something's wrong")
}
// Currently running myFunction()
// for debugging
// when you use warning you can know where will you make adjustment


//: ## Attached Macros
// you just write cases and compiler will complete remain part.

@OptionSet<Int>
struct SundaeToppings {
    private enum Options: Int {
        case nuts
        case cherry
        case fudge
    }
}
//: Normally, when you working with a struct, you’d need to manually write things like the initializer (init), Equatable, and Hashable implementations. But by adding a macro like @Observable or @Equatable, the compiler generates that code for you automatically.
