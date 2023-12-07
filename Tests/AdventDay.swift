import XCTest

@testable import AdventOfCode

// One off test to validate that basic data load testing works
final class AdventDayTests: XCTestCase {
    func testInitData() throws {
        XCTAssertTrue(Day01().data.starts(with: "mxmkjvg"))
        XCTAssertTrue(Day02().data.starts(with: "Game 1: 1 blue; 4 green, 5 blue; 11 red, 3 blue, 11 green; 1 red, 10 green, 4 blue; 17 red, 12 green, 7 blue; 3 blue, 19 green, 15 red"))
        XCTAssertTrue(Day03().data.starts(with: "...........441.................367................296........................................567..47.....45.................947............."))
        XCTAssertTrue(Day04().data.starts(with: "Card   1: 69 61 27 58 89 52 81 94 40 51 | 43 40 52 90 37 97 89 80 69 42 51 70 94 58 10 73 21 29 61 63 57 79 81 27 35"))
    }
}
