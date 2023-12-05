import XCTest

@testable import AdventOfCode

// One off test to validate that basic data load testing works
final class AdventDayTests: XCTestCase {
    func testInitData() throws {
        XCTAssertTrue(Day01().data.starts(with: "mxmkjvg"))
        XCTAssertTrue(Day02().data.starts(with: "Game 1: 1 blue; 4 green, 5 blue; 11 red, 3 blue, 11 green; 1 red, 10 green, 4 blue; 17 red, 12 green, 7 blue; 3 blue, 19 green, 15 red"))
        XCTAssertTrue(Day03().data.starts(with: "...........441.................367................296........................................567..47.....45.................947............."))
    }
}
