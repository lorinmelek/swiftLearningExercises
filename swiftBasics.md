# Swift Summary Notes

## 1. Info.plist
The application’s configuration file including permissions and settings.  
Stores metadata such as app name, version, permissions (camera, microphone)…

---

## 2. Enum
Represents a fixed set of values.  
Easy to control with `switch`.  
Can have **Raw Values** for constant values or **Associated Values** for extra data.  
Also, with `CaseIterable`, all cases can be listed.

---

## 3. Lazy
The variable’s value is computed **only when accessed for the first time**.  
Improves performance and memory usage.  
Can only be used with `var`, not `let`.

---

## 4. Access Modifiers
- **open** → Accessible from anywhere, can be overridden.  
- **public** → Accessible from anywhere, **cannot** be overridden.  
- **internal** (default) → Accessible within the same module.  
- **fileprivate** → Accessible within the same file.  
- **private** → Accessible only within the defining scope.

---

## 5. Static Functions & Class Functions
- **static** → Cannot be overridden, used when you need something strict.  
- **class** → Can be overridden, used when you need flexibility.

---

## 6. Delegate vs Closure
- **Delegate** → Passes responsibility using a protocol. More structured, can have multiple methods.  
- **Closure** → An anonymous function for small or one-off tasks.  
- **Delegates** are for **long-lived communication**, **closures** for **short-lived callbacks**.

---

## 7. Why Swift Does Not Use Abstract Classes
- Swift doesn’t have abstract classes because it prefers **Protocol-Oriented Programming**.  
- Instead, use **protocol + extension**, **generics**, or **composition**.  
- You can simulate it with `fatalError` in initializers, but it’s not recommended.

