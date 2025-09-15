//: Automatic Reference Counting
//: Thiz automatically tracks strong references to class instances at compile time and runtime, deallocating them when the reference count drops to zero helping manage memory safely and efficiently.

class Person {
    let name: String
    init(name: String) { self.name = name; print("\(name) initialized") }
    deinit { print("\(name) deinitialized") }
}

var person1: Person? = Person(name: "Alex")
var person2 = person1 // Strong reference

person1 = nil  // person2 ia a strong referans. object do not deleted
person2 = nil  // there is no reference anymore. `deinit` called

// strong reference cycle (memory leak) and fix with `weak`

class Tenant {
    let name: String
    // If this were `strong`, `Tenant` <-> `ApartmentCycle` would leak.
    // We'll first show the leak with strong, then fix it.
    var apartment: ApartmentCycle?
    init(name: String) { self.name = name; print(" Tenant \(name) init") }
    deinit { print(" Tenant \(name) deinit") }
}

class ApartmentCycle {
    let unit: String
    // strong by default; this creates a cycle if `Tenant` also strongly
    // references `ApartmentCycle`.
    var tenant: Tenant?
    init(unit: String) { self.unit = unit; print(" Apt \(unit) init") }
    deinit { print(" Apt \(unit) deinit") }
}

do {
    let t: Tenant? = Tenant(name: "Mina")
    let a: ApartmentCycle? = ApartmentCycle(unit: "4B")
    t?.apartment = a        // Tenant → ApartmentCycle (strong)
    a?.tenant = t           // ApartmentCycle → Tenant (strong)   Cycle!

    // Exiting scope here should deinit both, but it won't due to the cycle.
    // => memory leak (they stay alive)
}
print("Exited leaking scope (no deinit printed)")

// Fix the cycle with `weak` on one side.
// In real-world, the container (Apartment) usually weakly references its owner (Tenant) or vice versa,
// depending on the ownership semantics.

class Apartment {
    let unit: String
    // weak → does NOT increase strong count; ARC can break the cycle.
    weak var tenant: Person?    // weak var must be Optional and var
    init(unit: String) { self.unit = unit; print(" Apt \(unit) init") }
    deinit { print(" Apt \(unit) deinit") }
}

do {
    var alex: Person? = Person(name: "Alex")
    var apt: Apartment? = Apartment(unit: "9A")
    apt?.tenant = alex          // Apartment --weak--> Person

    alex = nil                  // Person goes away → `deinit` prints
    apt = nil                   // Apartment goes away → `deinit` prints
}
print("Exited non-leaking scope (both deinit printed) ")


// ARC manages only class instances (reference types).
// Structs & enums are VALUE types → copied, not reference-counted.

struct Point {
    var x: Int
    var y: Int
}

var p1 = Point(x: 1, y: 2)
var p2 = p1                 // copy
p2.x = 99
print("Structs copy: p1.x=\(p1.x), p2.x=\(p2.x)") // p1.x stays 1, p2.x is 99


// Memory leak via closures and capture lists
// A common leak: a class storing a closure that captures `self` strongly.

class TimerLike {
    var tick: (() -> Void)?
    func start() { tick?() }
}

class ControllerLeaky {
    let timer = TimerLike()
    init() {
        // Strong capture of `self` → `ControllerLeaky` → `timer` → `tick` → (captures) `self`
        timer.tick = {
            print("Leaky tick by \(self)") // strong capture causes a cycle
        }
        print(" ControllerLeaky init")
    }
    deinit { print(" ControllerLeaky deinit") }
}

do {
    var c: ControllerLeaky? = ControllerLeaky()
    c?.timer.start()
    c = nil // deinit not called due to strong capture cycle
}
print("Leak scope exited (no deinit)")

// Fix with a capture list: [weak self] or [unowned self] (see below).

class ControllerFixed {
    let timer = TimerLike()
    init() {
        print(" ControllerFixed init")
        timer.tick = { [weak self] in
            guard let self else { return }
            print("Fixed tick by \(self)") // self is weak → no cycle
        }
    }
    deinit { print("ControllerFixed deinit") }
}

do {
    var c: ControllerFixed? = ControllerFixed()
    c?.timer.start()
    c = nil // deinit called
}
print("Fixed scope exited (deinit printed) ")


// `unowned` vs `weak`
// - `weak`  Optional, becomes nil automatically when target deallocates (safe).
// - `unowned`  Non-optional; use when the captured object is guaranteed to outlive the captor.
//   If it doesn't, dereferencing an `unowned` reference will crash.

class CardHolder { var card: CreditCard?; deinit { print(" Holder deinit") } }
class CreditCard {
    unowned let owner: CardHolder
    init(owner: CardHolder) { self.owner = owner; print(" Card init") }
    deinit { print(" Card deinit") }
}

do {
    var holder: CardHolder? = CardHolder()
    holder!.card = CreditCard(owner: holder!)
    // owner must outlive card; when holder goes away, card should go too.
    holder = nil // deallocates both in order; safe for `unowned` here
}
print("unowned example done ")
