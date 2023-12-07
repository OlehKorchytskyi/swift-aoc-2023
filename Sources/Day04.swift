//
//  Day01.swift
//
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import Foundation

// Challenge: https://adventofcode.com/2023/day/4

struct Day04: AdventDay {

    var data: String
    
    private let lines: [String]
    
    init(data: String) {
        self.lines = data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        self.data = data
    }
    
    // 26914 answer was correct
    func part1() -> Any {
         part1Solution1()
    }
        
    // 13080971 answer was correct
    func part2() -> Any {
        part2Solution1()
    }
}



extension Day04 {
    
    private func part1Solution1() -> Int {
        lines.reduce(into: 0) { sum, line in
            let matches = numberOfMatches(in: line)
            
            if matches > 0 {
                sum += (0..<matches).reduce(0) { result, _ in max(1, result * 2) }
            }
        }
    }
    
    private func numberOfMatches(in line: String) -> Int {
        let components = line.components(separatedBy: " | ")
        
        let cardComponents = components.first?.components(separatedBy: ": ")
        
        guard
            let winningNumbers = cardComponents?.last?
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: " ")
                .compactMap({ Int($0) }),
            winningNumbers.isEmpty == false else {
            fatalError("Failed to extract winning numbers from: \(line)")
        }
        
        guard
            let gameNumbers = components.last?
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: " ")
                .compactMap({ Int($0) }),
            gameNumbers.isEmpty == false else {
            fatalError("Failed to extract game numbers from: \(line)")
        }
        
        return gameNumbers.filter { winningNumbers.contains($0) }.count
    }
    
    private func part2Solution1() -> Int {
        var sum: Int = 0

        var store: [Int : Int] = [:]
        store.reserveCapacity(lines.count)
        
        for index in 0..<lines.count {
            sum += 1 + numberOfCopies(from: index, store: &store)
        }
        
        return sum
    }
    
    private func numberOfCopies(from index: Int, store: inout [Int : Int]) -> Int {
        
        if let copies = store[index] {
            return copies
        }
        
        let line = lines[index]
        
        let matches = numberOfMatches(in: line)

        var copies = 0
        if matches > 0 {
            copies = (1...matches).reduce(into: copies, { $0 += numberOfCopies(from: index + $1, store: &store) })
        }
        
        let cards = matches + copies
        store[index] = cards
        return cards
    }
    
}
