//
//  Day01.swift
//  
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import XCTest

@testable import AdventOfCode


final class Day03Tests: XCTestCase {
    
    func testPart1() {
        XCTAssertEqual(Day03().part1() as? Int, 512794)
    }
    
    func testPart2() {
        XCTAssertEqual(Day03().part2() as? Int, 67779080)
    }

}
