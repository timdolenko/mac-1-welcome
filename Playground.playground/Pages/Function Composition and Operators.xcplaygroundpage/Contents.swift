import Foundation

func compose<A, B, C>(
    _ f: @escaping (A) -> B,
    _ x: @escaping (B) -> C
) -> (A) -> C {
    return { a in
        x(f(a))
    }
}

func removeEverySecondChar(_ str: String) -> String {
    str
        .enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
        .reduce(into: "", { $0 += String($1) })
}

removeEverySecondChar("domino")
// "dmn"

func hideI(_ str: String) -> String {
    str
        .map { $0 == "i" ? "*" : $0 }
        .reduce(into: "", { $0 += String($1) })
}

let process = compose(removeEverySecondChar, hideI)

process("application")

// Custom Operators

precedencegroup Pipe {
    associativity: left
}

// Elm's pipe or forward application operator
infix operator |>: Pipe

func |> <A, B>(_ a: A, _ f: (A) -> B) -> B {
    f(a)
}

precedencegroup Composition {
    higherThan: Pipe
    associativity: left
}

// Elm's Composition Operator / In Swift Bitwise shift operator
infix operator >>: Composition

func >> <A, B, C>(
    _ f: @escaping (A) -> B,
    _ x: @escaping (B) -> C
) -> (A) -> C {
    return { a in
        x(f(a))
    }
}

let newProcess = removeEverySecondChar >> hideI
newProcess("application")

func apply<A, B>(_ a: A, _ f: (A) -> B) -> B {
    f(a)
}

apply("application", hideI)
//"appl*cat*on"

"application" |> removeEverySecondChar >> hideI


// Pow
func pow(_ x: Int, power: Int) -> Int {
    Int(pow(Double(x), Double(power)))
}

infix operator ^^

func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

func toTenth(x: Int) -> Int {
    x ^^ 10
}

toTenth(x: 2)

func divideBy2(x: Int) -> Int {
    x / 2
}

2 |> toTenth >> divideBy2
4 |> toTenth >> divideBy2 >> String.init
