//
//  Day01.swift
//  
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import XCTest

@testable import AdventOfCode


final class Day01Tests: XCTestCase {
    
    func testPart1() {
        let challenge = Day01()
        XCTAssertEqual(challenge.part1() as? Int, 55621)
    }
    
    func testPart2() {
        let challenge = Day01()
        XCTAssertEqual(challenge.part2() as? Int, 53592)
    }

}
