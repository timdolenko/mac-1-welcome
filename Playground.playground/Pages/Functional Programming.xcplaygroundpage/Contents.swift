
// Functions are first-class citizens
// Treat them like objects

// Assign to a variable

func convertIntToString(_ number: Int) -> String {
    return String(number)
}

let convertFunction = convertIntToString//Type is (Int) -> String

convertFunction(2)//2

struct Converter {
    var convert: (Int) -> String
}

let converter1 = Converter(convert: convertFunction)
let converter2 = Converter(convert: String.init)

converter1.convert(4)//4
converter2.convert(5)//5

// Pass as a parameter

func identification(id: Int, conversion: (Int) -> String) -> String {
    return conversion(id)
}

identification(id: 9901, conversion: convertFunction)//9901

identification(id: 9904, conversion: String.init)

identification(id: 9905, conversion: {
    return "\($0)"
})

identification(id: 9905) {
    return "\($0)"
}

// Return from a function

func createIncrementer() -> () -> Int {
    var x = 0

    let incrementer: () -> Int = {
        x += 1
        return x
    }

    return incrementer
}

let incrementer = createIncrementer()//() -> Int
incrementer()//1
incrementer()//2
incrementer()//3




// Pure functions

var sharedState: Int = 2

func impureFunction(_ input: Int) -> Int {
    return input * sharedState
}

// input = 10, output = 20
impureFunction(10)//20

sharedState = 5

// same input, different output = unpredictible
impureFunction(10)

var sharedState2: Int = 0

func sideEffectFunction(_ input: Int) -> Int {
    sharedState2 += input
    return input + 1
}

sideEffectFunction(2)//3, sharedState2 = 2
sideEffectFunction(2)//3, sharedState2 = 4
sideEffectFunction(2)//3, sharedState2 = 6

// Pure
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
countA("aba")//2, same result as before, doesn't change outside world




// Immutability
func countAFunctional(_ str: String) -> Int {
    return str
        .filter { $0 == "a" }
        .count
}

countAFunctional("aba")//2
countAFunctional("ccc")//0
countAFunctional("a")//1


// Partial Function

func filter(for firstLetter: Character) -> ([String]) -> [String] {
    return { words in
        words.filter { $0.first == firstLetter }
    }
}

let firstLetterCFilter = filter(for: "c")
let words = ["coconut", "camera", "light"]
print("words that start with c:\n\(firstLetterCFilter(words))")
