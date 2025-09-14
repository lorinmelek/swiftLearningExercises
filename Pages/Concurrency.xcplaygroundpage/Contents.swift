//: ## Concurrency

//: ## With this structure, you can run multiple tasks simultaneously in Swift and collect their results as they complete. This provides both speed and organized concurrency.
//: ## Use async let to call an asynchronous function, letting it run in parallel with other asynchronous code. When you use the value it returns, write await.

func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}
func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), user ID \(userID)"
    print(greeting)
}

//: ## Use Task to call asynchronous functions from synchronous code, without waiting for them to return.
Task {
    await connectUser(to: "primary")
}
// Prints "Hello Guest, user ID 97"

//: ## Concurrency – Modern (async/await) + GCD (Dispatch Queues)
//: Goal: Run tasks in parallel, collect results, protect UI/main thread,
//: and see how the older GCD APIs still work.

// Actor & @MainActor: prevent race conditions, protect UI

actor SafeCounter {
    private var value = 0
    func increment() { value += 1 }
    func current() -> Int { value }
}

let counter = SafeCounter()
Task.detached {
    await counter.increment()
}
Task.detached {
    await counter.increment()
}
Task {
    try? await Task.sleep(nanoseconds: 100_000_000)
    print("Actor value:", await counter.current()) // should print 2
}

// UI code  must run on the main thread → use @MainActor
@MainActor
func updateUI(label: inout String, text: String) {
    // UI code is always safe on the main thread
    label = text
}
var titleText = "Loading…"
Task {
    await updateUI(label: &titleText, text: "Ready")
    print("UI text:", titleText)
}

// Task.cancel & priority

Task(priority: .high) {
    if Task.isCancelled { return }
    // do work…
}

// GCD (Grand Central Dispatch) – Dispatch Queues
// Modern Swift prefers async/await, but lots of code still uses GCD.
// Summary:
// - main: for UI
// - global: background (qos: userInitiated, utility, background…)
// - custom serial: tasks run one by one
// - custom concurrent: multiple tasks run in parallel
// - barrier: single “exclusive” write in a concurrent queue


import Dispatch

func log(_ msg: String) {
    print("[\(Thread.isMainThread ? "main" : "bg")] \(msg)")
}

// Main Queue – safe for UI updates
DispatchQueue.main.async {
    log("UI-safe code (main)")
}

// Global Queue – background work
DispatchQueue.global(qos: .userInitiated).async {
    log("Heavy work 1")
}
DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 0.1) {
    log("Heavy work 2 (delayed)")
}

// Custom Serial Queue – tasks run one after another
let serialQ = DispatchQueue(label: "com.demo.serial")
for i in 1...3 {
    serialQ.async {
        log("Serial job \(i)")
    }
}

// Custom Concurrent Queue – tasks run in parallel
let concurrentQ = DispatchQueue(label: "com.demo.concurrent", attributes: .concurrent)
for i in 1...3 {
    concurrentQ.async {
        log("Concurrent job \(i)")
    }
}

// Barrier – ensure exclusive write access in a concurrent queue
final class ThreadSafeArray<T> {
    private var storage: [T] = []
    private let q = DispatchQueue(label: "com.demo.tsarray", attributes: .concurrent)

    func append(_ element: T) {
        q.async(flags: .barrier) { self.storage.append(element) }
    }
    func getAll() -> [T] {
        var result: [T] = []
        q.sync { result = storage } // parallel read
        return result
    }
}
let ts = ThreadSafeArray<Int>()
for i in 1...5 { concurrentQ.async { ts.append(i) } }
concurrentQ.asyncAfter(deadline: .now() + 0.2) {
    log("ThreadSafeArray contents: \(ts.getAll())")
}

// GCD Group & Semaphore
// modern equivalent is Task Group + await.

let group = DispatchGroup()
for i in 1...3 {
    group.enter()
    DispatchQueue.global().async {
        log("Group job \(i)")
        group.leave()
    }
}
group.notify(queue: .main) {
    log("All group jobs done (notify on main)")
}
