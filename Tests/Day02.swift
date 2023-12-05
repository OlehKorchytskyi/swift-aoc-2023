//
//  Day01.swift
//  
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import XCTest

@testable import AdventOfCode


final class Day02Tests: XCTestCase {
    
    func testPart1() {
        let challenge = Day02()
        XCTAssertEqual(challenge.part1() as? Int, 2810)
    }
    
    func testPart2() {
        let challenge = Day02()
        XCTAssertEqual(challenge.part2() as? Int, 69110)
    }

}
