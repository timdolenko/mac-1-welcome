import Foundation

// Assigning it to a variable
func convertIntToString(_ number: Int) -> String {
    return String(number)
}

let convertFunction: (Int) -> String = convertIntToString

convertFunction(2)//"2"

struct Converter {
    var convert: ((Int) -> String)?
}

let converterA = Converter(convert: convertFunction)
let converterB = Converter(convert: String.init)

// Pass as parameter
func identification(id: Int, conversion: (Int) -> String) -> String {
    return conversion(id)
}

identification(id: 9901, conversion: convertFunction)//"9901"
identification(id: 9904, conversion: String.init)

identification(id: 9905) { number in
    return String(number)
}

// Return from a function

func createIncrementer() -> () -> Int {
    var x = 0

    func increment() -> Int {
        x += 1
        return x
    }

    return increment
}

let incrementer = createIncrementer()

incrementer()//1
incrementer()//2

// Impure function

var sharedState: Int = 2

func impureFunction(_ input: Int) -> Int {
    return input * sharedState
}

impureFunction(10)

sharedState = 5

impureFunction(10)

sharedState = 0

func sideEffectFunction(_ input: Int) -> Int {
    sharedState += input
    return input + 1
}

sideEffectFunction(2)
print(sharedState)
sideEffectFunction(2)
print(sharedState)
sideEffectFunction(2)
print(sharedState)


func countA(_ str: String) -> Int {
    var count = 0
    for character in str {
        if character == "a" { count += 1 }
    }
    return count
}

countA("aba")//2
countA("ccc")//0
countA("a")//1
countA("aba")//2

let number = 0

func countAFunction(_ str: String) -> Int {
    str.filter { $0 == "a" }.count
}

countAFunction("aba")//2
countAFunction("ccc")//0
countAFunction("a")//1
countAFunction("aba")//2
