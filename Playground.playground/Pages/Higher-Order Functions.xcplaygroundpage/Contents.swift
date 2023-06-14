
// Higher-Order functions

let array = ["Apple", "Banana", "Avocado", "Orange", "Lemon"]

// Filter
let notA = array.filter {
    $0.first != "A"
}
print(notA)//["Banana", "Orange", "Lemon"]

let longWords = array.filter { $0.count > 5 }
print(longWords)//["Banana", "Avocado", "Orange"]


// Map

// [String] -> [Int]
let counted = array.map {
    $0.count
}
print(counted)//[5, 6, 7, 6, 5]


// Reduce
let salad = array.reduce(into: "") { result, element in
    result += element
}
print(salad)//AppleBananaAvocadoOrangeLemon

let sumLetters = array.reduce(into: 0) { result, element in
    result += element.count
}
print(sumLetters)//29

// Flat map
// [ [Int] ]
let numbersFlattenned = [[1, 2] + [3, 4], [5, 6]].flatMap { $0 }
// [1, 2, 3, 4, 5, 6]

let numbers = [1, 2, 3, 4]
let mapped = numbers.map { Array(repeating: $0, count: $0) }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]


// Compact Map
let optionalNumbers = [1, nil, 3, 4, nil, 6] // [Int?]
let nonOptionalNumbers = optionalNumbers.compactMap { $0 }// [Int]
print(nonOptionalNumbers)
//[1, 3, 4, 6]

