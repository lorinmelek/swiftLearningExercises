//: Swift access control levels (private, fileprivate, internal, public, open) are like different levels of access to a drawer in your home—ranging from only you having access, to allowing everyone to open or even modify it.
// open > public > internal (default) > fileprivate > private
// Think: “Who can see/use/extend this thing?”

open class OpenBase {
    // open members can be overridden in other modules
    open func greet() -> String { "Hello from OpenBase" }
}

public class PublicBase {
    // public members are visible in other modules,
    // but CANNOT be overridden outside your module.
    public func greet() -> String { "Hello from PublicBase" }
}

// In the SAME module, both are subclassable and overridable:
class LocalOpenChild: OpenBase {               // same module, allowed
    override func greet() -> String { "LocalOpenChild override" }
}
class LocalPublicChild: PublicBase {           // same module, allowed to subclass
    override func greet() -> String { "LocalPublicChild override" } // same module, allowed to override
}

// Pretend the code below is in another module importing your module. you cvan override both in same class.

class OpenChild: OpenBase {                  // allowed (open enables subclassing outside the module)
    override func greet() -> String {        // allowed (member is open)
        "OpenChild override"
    }
}
//
// class PublicChild: PublicBase {              // ERROR: 'PublicBase' is public and cannot be subclassed outside its module
//     override func greet() -> String {        // ERROR: cannot override a public member outside its defining module
//         "Try to override"
//     }
// }


//  final and final methods

final class NeverSubclassMe {
    func work() { print("Working…") }
}

// class TryToInherit: NeverSubclassMe {}      //cannot inherit from final class

class BaseWithFinal {
    final func locked() { print("You cannot override me") }
    func openForOverride() { print("Base behavior") }
}

class SubClassAttempt: BaseWithFinal {
    // override func locked() {}               // cannot override a 'final' method
    override func openForOverride() { print("Custom behavior") }
}

// internal (default): visible inside the module

class InternalExample {               // implicitly 'internal'
    var value = 42                    // implicitly 'internal'
    func show() { print(value) }      // implicitly 'internal'
}

// fileprivate vs private (same file vs same scope/type)
// private → Only inside the and same-type extensions in the same file.
// fileprivate → Anywhere within the same file.

class PrivacyDemo {
    private var secret = "private"          // only this type and its extensions in this file
    fileprivate var fileWide = "fileprivate" // anywhere in this file

    func seeOwnStuff() {
        print(secret, fileWide)                // both accessible here
    }
}

// Same type extension (in the same file) can access `private` due to Swift's rule.
extension PrivacyDemo {
    func extensionCanSeePrivate() {
        print(secret)      // allowed (same type, same file)
        print(fileWide)    // allowed
    }
}

// Different type in the same file:
class SomeoneElseInSameFile {
    func test() {
        let demo = PrivacyDemo()
        // print(demo.secret)                  // ERROR: 'secret' is private to PrivacyDemo
        print(demo.fileWide)                   // allowed: fileprivate visible in this file
    }
}

// fileprivate types/members

fileprivate class FilePrivateType {
    func onlyInThisFile() { print("Visible only in this file") }
}

class UsesFilePrivate {
    func go() {
        let x = FilePrivateType()  //allowed (same file)
        x.onlyInThisFile()
    }
}

// public (visible to others; override rules above)

public class PublicThing {
    public var count = 0          // visible to other modules
    var internalNote = "hi"       // internal by default (module-only)
    public init() {}
    public func bump() { count += 1 }
    fileprivate func onlyHere() { print("same file") }
    private func onlyInside() { print("inside class") }
}

// Example code demo()

func demo() {
    print("open vs public (same module)")
    print(OpenBase().greet())
    print(PublicBase().greet())
    print(LocalOpenChild().greet())    // shows override
    print(LocalPublicChild().greet())  // shows override

    print("\n final ")
    let f = NeverSubclassMe()
    f.work()

    print("\n fileprivate vs private ")
    let demo = PrivacyDemo()
    demo.seeOwnStuff()
    let someone = SomeoneElseInSameFile()
    someone.test()

    print("\n public/internal examples ")
    let pub = PublicThing()
    pub.bump()
    print("PublicThing.count =", pub.count)
}

demo()
