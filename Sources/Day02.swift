//
//  Day01.swift
//
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import Foundation

// Challenge: https://adventofcode.com/2023/day/2

struct Day02: AdventDay {

    var data: String
    
    // 2810 answer was correct
    func part1() -> Any {
         part1Solution1()
    }
        
    // 69110 answer was correct
    func part2() -> Any {
        part2Solution1()
    }
}


private enum CubeKind: String {
    case red, green, blue
}

private struct GameResources {
    
    private var available: [CubeKind : Int]
    
    var power: Int {
        available.reduce(into: 1) { $0 *= $1.value }
    }
    
    init(empty: Bool = false) {
        available = [
            .red    : empty ? 0 : 12,
            .green  : empty ? 0 : 13,
            .blue   : empty ? 0 : 14
        ]
    }
    
    mutating func pullOut(_ kind: CubeKind, count: Int) -> Bool {
        let left = (available[kind] ?? 0) - count
        self.available[kind] = left
        return left >= 0
    }
    
    mutating func scoop(_ kind: CubeKind, count: Int) {
        self.available[kind] = min((available[kind] ?? 0), -count)
    }
    
}

extension Day02 {
    
    private func part1Solution1() -> Int {
        var sum: Int = 0
                
        enumeratingGames { gameId, subsets in
            if validateGame(subsets: subsets) {
                sum += gameId
            }
        }
        
        return sum
    }
    
    private func part2Solution1() -> Int {
        var sum: Int = 0
        
        enumeratingGames { _, subsets in
            var gameResources = GameResources()
            for subsetString in subsets {
                for groupString in subsetString.components(separatedBy: ",") {
                    let (count, kind) = groupInfo(from: groupString)
                    gameResources.scoop(kind, count: count)
                }
            }
            sum += gameResources.power
        }
        
        return abs(sum)
    }
    
    // MARK: - Helpers
    
    private func enumeratingGames(_ processGame: @escaping (Int, [String]) -> Void) {
        data.enumerateLines { line, _ in
            let components = line.components(separatedBy: ":")
            
            let titleComponents = components.first?.components(separatedBy: .whitespaces)
            
            guard
                let idString = titleComponents?.last,
                let gameId = Int(idString) else {
                fatalError("Cannot find game id in: \(titleComponents?.last ?? "nil")")
            }
            
            guard
                let subsetStrings = components.last?.components(separatedBy: ";"),
                subsetStrings.isEmpty == false else {
                fatalError("Cannot find subsets in: \(components.last ?? "nil")")
            }
            
            processGame(gameId, subsetStrings)
        }
    }
    
    private func groupInfo(from groupString: String) -> (Int, CubeKind) {
        let groupComponents = groupString
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: " ")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        guard
            let countString = groupComponents.first,
            let count = Int(countString),
            let kindString = groupComponents.last,
            let kind = CubeKind(rawValue: kindString) else {
            fatalError("Cannot extract number of cubes or cubes count from: \(groupString)")
        }
        
        return (count, kind)
    }
    
    private func validateGame(subsets: [String]) -> Bool {
        let gameResources = GameResources()
        for subsetString in subsets {

            var resources = gameResources
            for groupString in subsetString.components(separatedBy: ",") {
                let (count, kind) = groupInfo(from: groupString)
                
                if resources.pullOut(kind, count: count) == false {
                    return false
                }
            }
        }
        
        return true
    }
    
}
