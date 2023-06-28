//: [Previous](@previous)

import Foundation

/// Clean Code Guidelines

// MARK: - Names

/// 1. Chose names thoughtfully, they are a way to communicate with others and your future self.
/// Communicate your intent

class RegionProvider {} // ✅ It provides a region!

/// 2. No Comments
/// If you need a comment to clarify your name - it's a bad name.

/// Service that provides current user region ❌
class MyService {} // ❌ What does it do?

/// 3. No Typos!

class RegionProvder {} // ❌❌❌ Provider ?

/// 4. Avoid disinformation
/// Don't lie with names. The name should reflect the actual responsibility of the object
/// If you have to read the code to understand the name - it's a bad name

func saveUserData() {
    // modifies the data
    // but doesn't actually save it
}

let user = User()

func score() -> Int {
    if user.isAuthenticated {
        return user.score
    }

    return 0
}


/// 5. Pronounceable Names

let fNmLbl = "label" // ❌ How do I pronounce it?
let firstNameLbl = "label" // ✅ I can read it!

/// 6. Choose fitting parts of speech.
/// Classes, variables = nouns
/// Functions = verbs
/// Booleans = predicates

struct Region {} // noun
var documentPath: String = "" // noun

func provideRegion() {} // verb

var isRegionSelected: Bool = false // predicate

/// 7. The Scope Rule
/// Variables should be short when they have small scope, but long otherwise
/// Function and class names should be short if they have big scope, and should be long and descriptive if they have a short scope.

/// Big Scope

/// Long Variable Names
public class RegionService {
    /// Has big scope
    public var isUserRegionFetched: Bool = false
}

/// Can be accessible everywhere, therefore it's long
RegionService().isUserRegionFetched

/// Short Class, Protocol and Function names
class Authentication {
    func refreshToken() {}
}

/// We will be calling it from many parts of the code
/// Therefore, we want to keep `Authentication` name and `refreshToken` as short as possible
Authentication().refreshToken()

/// Smal Scope

/// Long Class, Protocol and Function names
class FeedVC {

    /// Long function since it has short scope - only this class
    /// Should be descriptive to understand what happens inside the class or function
    private func presentAvailableUpdateDialogIfNeeded() {}
}

/// This protocol is used by one class only, so the name can be descriptive
public protocol MessagesMapToDomainUseCaseEnvironment {}


/// The variable can be very short here
/// Many teams ban names shorter than 3 characters
for i in 0...15 {
    print(i)
}

func process(x: Int) -> Int {
    var r = 100 * x /// `res`, `result` also appropriate, `calculationResult` is not
    r -= 21
    return r
}

//: [Next](@next)
