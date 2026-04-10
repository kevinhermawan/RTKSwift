// Intentional compile error — use `swift build` (or `rtk swift build`) here to see a negative build.
public func willNotCompile() -> Int {
    let x: Int = "not an int"
    return x
}
