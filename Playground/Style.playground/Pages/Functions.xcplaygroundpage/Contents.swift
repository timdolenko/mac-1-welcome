//: [Previous](@previous)

import Foundation

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

struct Region {}

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


//: [Next](@next)
