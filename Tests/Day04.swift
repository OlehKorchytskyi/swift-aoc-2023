//
//  Day01.swift
//  
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import XCTest

@testable import AdventOfCode


final class Day04Tests: XCTestCase {
    
    func testPart1() {
        XCTAssertEqual(Day04().part1() as? Int, 26914)
    }
    
    func testPart2() {
        XCTAssertEqual(Day04().part2() as? Int, 13080971)
    }

}
