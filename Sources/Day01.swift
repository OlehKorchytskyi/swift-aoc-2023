//
//  Day01.swift
//
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import Foundation

// Challenge: https://adventofcode.com/2023/day/1

struct Day01: AdventDay {

    var data: String
    
    // 55621 answer was correct
    func part1() -> Any {
         part1Solution1()
    }
    
    // 53592 answer was correct
    func part2() -> Any {
        part2Solution1()
    }
}

extension Day01 {
    
    private func part1Solution1() -> Int {
        var sum: Int = 0
        data.enumerateLines { line, _ in
            if let first = line.first(where: { $0.isWholeNumber }),
               let last = line.last(where: { $0.isWholeNumber }) {
                sum += (first.wholeNumberValue! * 10) + last.wholeNumberValue!
            }
        }
        
        return sum
    }
    
    private func part2Solution1() -> Int {
        var sum: Int = 0
                
        struct SpelledNumber {
            let rawValue: String
            
            let wholeNumberValue: Int
            let reversed: String
        }
        
        let spelledNumbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
            .enumerated()
            .map { SpelledNumber(rawValue: $1, wholeNumberValue: $0 + 1, reversed: String($1.reversed())) }
        
        data.enumerateLines { line, _ in

            func searchFirstNumber(in line: String, backwards: Bool = false) -> Int {
                
                let reversedLine: ReversedCollection<String>? = backwards ? line.reversed() : nil
                
                var accumulated = ""

                for offset in 0..<line.count {
                    
                    let character: Character
                    if backwards, let reversedLine {
                        character = reversedLine[reversedLine.index(reversedLine.startIndex, offsetBy: offset)]
                    } else {
                        character = line[line.index(line.startIndex, offsetBy: offset)]
                    }
                    
                    if character.isWholeNumber {
                        return character.wholeNumberValue!
                    }
                    
                    accumulated.append(character)
                    
                    if accumulated.count >= 3 {
                        if let spelledNumber = spelledNumbers.first(where: { accumulated.hasSuffix(backwards ? $0.reversed : $0.rawValue) }) {
                            return spelledNumber.wholeNumberValue
                        }
                    }
                }
                
                fatalError("Did not found first number as digit or the spelled number in: \(line)")
            }
            
            sum += (searchFirstNumber(in: line) * 10) + searchFirstNumber(in: line, backwards: true)
        }
        
        return sum
    }
    
}
