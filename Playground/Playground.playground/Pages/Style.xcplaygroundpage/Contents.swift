//: [Previous](@previous)

import Foundation

func example(_ name: String, _ example: () -> ()) { example() }

struct User {
    var isAuthenticated: Bool
    var score: Int
}


/// Swift-specific guidelines

/// camelCase not snake_case
let snake_case = "" // ❌
let camelCase = "" // ✅


/// Curly braces

func modify() {
    // ✅
}

func edit()
{
    // ❌
}

/// Google's Swift Style Guideline
/// https://google.github.io/swift/

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

// MARK: - Functions

/// Keep them Small
/// They should be like signs on the way
/// They will tell a stranger where to go and where to look for things

/// **4 Lines Rule**
/// Keep them under 4 lines
///
/// How to:
/// 1. Apply Single Responsibility Principle
/// 2. if-statement is already 1 thing

example("if-statement") {

    func setNavigationMenu(_ isEnabled: Bool) {  // ❌
        if isEnabled {
            // set
            // navigation
            // menu
            // enabled
        } else {
            // set
            // navigation
            // menu
            // disabled
        }
    }
}

example("if-statement") {

    func setNavigationMenu(_ isEnabled: Bool) { // ✅
        if isEnabled {
            setNavigationMenuEnabled()
        } else {
            setNavigationMenuDisabled()
        }
    }

    func setNavigationMenuEnabled() {
        // set
        // navigation
        // menu
        // enabled
    }

    func setNavigationMenuDisabled() {
        // set
        // navigation
        // menu
        // disabled
    }
}

/// 3. if-let is already 1 thing

example("if-let") {

    func setNavigationMenu(_ icon: String?) { // ❌
        if let icon {
            // set icon
            // do something
        } else {
            // remove icon
            // do something
        }
    }
}

example("if-let") {

    func setNavigationMenu(_ icon: String?) { // ✅
        if let icon {
            setNavigationMenu(icon)
        } else {
            removeNavigationMenuIcon()
        }
    }

    func setNavigationMenuIcon(_ icon: String) {
        // set
        // do something
    }

    func removeNavigationMenuIcon() {
        // remove
        // do something
    }
}

/// 4. try-catch is already 1 thing

class RegionRepository {
    func request() throws -> Region { throw NSError() }
}

example("try-catch") {

    let repository = RegionRepository()

    func fetch() { // ❌
        do {
            let region = try repository.request()
            // do something with the region
            // do something
        } catch {
            // do something with the error
        }
    }
}

example("try-catch") {

    let repository = RegionRepository()

    func fetch() {  // ✅
        do {
            let region = try repository.request()
            didFetch(region)
        } catch {
            didFailFetchingRegion(with: error)
        }
    }

    func didFetch(_ region: Region) {
        // do something with the region
        // do something
    }

    func didFailFetchingRegion(with error: Error) {
        // do something with the error
    }
}


/// 5. Classes hide in long functions

example("long function") {

    class LayoutCalculator {

        //

        func sectionLayout() { // ❌
            let sectionHeight: CGFloat = 10
            let verticalMargin: CGFloat = 10
            let bottomPadding: CGFloat = 10
            // perform layout calculation
        }
    }
}


class LayoutCalculator {

    //

    let sectionCalculator = SectionLayoutCalculator()

    func sectionLayout() { // ✅
        sectionCalculator.layout()
    }
}

class SectionLayoutCalculator {

    let sectionHeight: CGFloat = 10
    let verticalMargin: CGFloat = 10
    let bottomPadding: CGFloat = 10

    func layout() {
        helperFunction()
    }

    private func helperFunction() {
        anotherHelperFunction()
    }

    private func anotherHelperFunction() {}
}


/// 6. Exctract till you drop

func doLotsOfThings() { // ❌

    // do A
    // do A
    // do A

    // do B
    // do B
        // do D
        // do D
    // do B

    // do C
    // do C
    // do C
}

func doLotsOfThingsExtracted() { // ✅
    doA()
    doB()
    doC()
}

func doA() {
    // do A
    // do A
    // do A
}

func doB() {
    // do B
    // do B
    doD()
    // do B
}

func doD() {
    // do D
    // do D
}

func doC() {
    // do C
    // do C
    // do C
}



// MARK: - Function Structure

/// 1. Keep arguments under  3

func doSomething(dependencyA: String, dependencyB: String, parameterZ: String, parameterX: String, argumentA: String) {}// ❌

/// 2. Sort Functions according ot the step down principle


example("reversed / chaotic") { // ❌
    func doA() {}

    func doZ() {}

    func doX() {
        doA()
    }

    func process() {
        doX()
        doZ()
    }
}

example("step down") {  // ✅
    func process() {
        doX()
        doZ()
    }

    func doX() {
        doA()
    }

    func doA() {}

    func doZ() {}
}

// MARK: - Form

/// 1. Every time you write a comment - you fail. Keep them rare.
/// 2. Commented out code should be removed immediately. Git will save the deleted data anyway.
/// 3. Lines should always fit on the screen. Keep lines small

// ❌
func doSomethingVeryComplicated<T>(parameterA: String, parameterB: Int, dependencyA: String) throws -> Result<T, Error> where T: CustomStringConvertible {
    fatalError()
}

// ✅
func doSomethingVeryComplicatedAgain<T>(
    parameterA: String,
    parameterB: Int,
    dependencyA: String
) throws -> Result<T, Error> where T: CustomStringConvertible {
    fatalError()
}

/// 4. Keep your files small. The average file should be less then 100 lines. Never exceed 500.
/// One class/structure/protocol per file
/// Class extensions can be extracted into separate classes

/// 5. Classes vs Data Structures. Classes provide functionality, data structures don't have any functionality and have public fields. Don't put business rules into data structures.

example("data structure vs class") {
    struct Region {
        let id: String
        let name: String
    }

    class RegionService {
        private var selectedRegion: Region?

        func executeBusinessLogic() {
            // do something
        }
    }
}

/// 6. Domain objects != Database tables. Separate your domain objects from your database putting a layer between them.

/// Data Transfer Object (DTO)
/// Represents backend responses
public struct Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
    }

    public let login: String
    public let id: Int
    public let avatarUrl: String
}

/// Domain object. Is operated upon in business logic
public struct User {
    public init(name: String, profileImageUrl: URL) {
        self.name = name
        self.profileImageUrl = profileImageUrl
    }

    public let name: String
    public let profileImageUrl: URL
}

protocol Network {
    func request<T>(with path: String) -> T
}

class Repository {

    var network: Network!

    func requestUsers() -> [User] {
        let items: [Item] = network.request(with: "/users")
        return items.compactMap { $0.toDomain }
    }
}

/// Mapping layer
extension Item {
    var toDomain: User? {
        guard let url = URL(string: avatarUrl) else { return nil }
        return User(name: login, profileImageUrl: url)
    }
}


/// 7. DRY: Don't Repeat Yourself
/// Unless for the sake of simplicity / readability
/// Sometimes DRY = overengenering
/// Example: trying to reuse view code for 2 different views
/// Solution: Just copy and paste view code and make them 2 different views

/// 8. Readability over over-engineering / slight performance increase
/// It's much better to have clear, readable code than code that uses 20% less CPU power

//: [Next](@next)
