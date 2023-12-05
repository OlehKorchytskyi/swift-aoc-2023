//
//  Day01.swift
//
//
//  Created by Oleh Korchytskyi on 01.12.2023.
//

import Foundation

// Challenge: https://adventofcode.com/2023/day/3

struct Day03: AdventDay {

    var data: String
    
    private let engineSchematic: EngineSchematic
    
    init(data: String) {
        self.data = data
        engineSchematic = EngineSchematic(data: data)
    }

    // 512794 answer was correct
    func part1() -> Any {
         part1Solution1()
    }
        
    // 67779080 answer was correct
    func part2() -> Any {
        part2Solution1()
    }
}


private struct EngineSchematic {
    
    var scheme: [[Character]]
    
    let width: Int
    let height: Int
    
    init(data: String) {
        let scheme = data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { [Character]($0) }
        
        self.scheme = scheme
        
        width = scheme[0].count
        height = scheme.count
    }
    
    subscript(characterAt x: Int, _ y: Int) -> Character {
        get {
            scheme[y][x]
        }
        
        set {
            scheme[y][x] = newValue
        }
    }
    
    func hasSymbol(at x: Int, _ y: Int) -> Bool {
        let character = self[characterAt: x, y]
        return !character.isWholeNumber && character != "."
    }
}


private struct Position: Hashable {
    let x, y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
}

private struct Frame: Hashable {
    
    let position: Position
    var length: Int
    
    init(position: Position) {
        self.position = position
        self.length = 1
    }
    
    var end: Position { Position(position.x + length - 1, position.y) }
}

private struct View: Hashable {
    
    private(set) var frame: Frame
    private(set) var characters: [Character]
    
    var number: Int {
        var number = 0
        
        for i in 0..<characters.count {
            var multiplier = 1
            for _ in 1..<(characters.count - i) {
                multiplier *= 10
            }
            
            number += characters[i].wholeNumberValue! * multiplier
        }
        
        return number
//        Int(String(characters))!
    }
    
    init(position: Position, character: Character) {
        self.frame = Frame(position: position)
        self.characters = [character]
        characters.reserveCapacity(3)
    }
    
    mutating func append(_ character: Character) {
        characters.append(character)
        frame.length += 1
    }
    
    var allPositions: [Position] {
        (frame.position.x..<(frame.position.x + frame.length)).map { Position($0, frame.position.y) }
    }
    
}


extension View {
    
    func possibleDirections(in schematic: EngineSchematic) -> [Position] {
        let start = frame.position
        let end = frame.end
        
        var moves: [Position] = []
        moves.reserveCapacity(frame.length * 2 + 6)
        
        let canGoLeft = 0 < start.x
        let canGoUp = 0 < start.y
        let canGoRight = end.x + 1 < schematic.width
        let canGoDown = start.y + 1 < schematic.height

        if canGoLeft {
            moves.append(Position(-1, 0))
            if canGoUp {
                moves.append(Position(-1, -1))
            }
            if canGoDown {
                moves.append(Position(-1, 1))
            }
        }
        
        if canGoRight {
            moves.append(Position(frame.length, 0))
            if canGoUp {
                moves.append(Position(frame.length, -1))
            }
            if canGoDown {
                moves.append(Position(frame.length, 1))
            }
        }
        
        for xOffset in 0..<frame.length {
            if canGoUp {
                moves.append(Position(xOffset, -1))
            }
            
            if canGoDown {
                moves.append(Position(xOffset, 1))
            }
        }
        
        return moves
    }
    
    func hasAdjacentSymbols(in schematic: EngineSchematic) -> Bool {
        
        for move in possibleDirections(in: schematic) {
            let position = Position(frame.position.x + move.x, frame.position.y + move.y)
            if schematic.hasSymbol(at: position.x, position.y) {
                return true
            }
        }
        
        return false
        
    }
    
    
}


extension Day03 {
    
    private func part1Solution1() -> Int {
        var sum: Int = 0
        
//        var numberViews: [View] = []
//        var schematic = engineSchematic

        for y in 0..<engineSchematic.height {
            
            var numberView: View?
            
            for x in 0..<engineSchematic.width {
                let position = Position(x, y)
                let character = engineSchematic[characterAt: x, y]
                
                if character.isWholeNumber {
                    if numberView == nil {
                        numberView = View(position: position, character: character)
                    } else {
                        numberView!.append(character)
                    }
                }
                
                if let view = numberView, (!character.isWholeNumber || x == (engineSchematic.width - 1)) {
                    numberView = nil
                    
                    if view.hasAdjacentSymbols(in: engineSchematic) {
                        sum += view.number
                    }
                    
//                    numberViews.append(view)
                }
            }
            
        }
        
//        for view in numberViews where view.hasAdjacentSymbols(in: engineSchematic) {
//            for position in view.allPositions {
//                schematic[characterAt: position.x, position.y] = " "
//            }
//        }
        
//        for row in schematic.scheme {
//            print(String(row))
//        }
        
        return sum
    }
    
    private func part2Solution1() -> Int {
        var sum: Int = 0
        
        var numberViews: [View] = []

        for y in 0..<engineSchematic.height {
            
            var numberView: View?
            
            for x in 0..<engineSchematic.width {
                let position = Position(x, y)
                let character = engineSchematic[characterAt: x, y]
                
                if character.isWholeNumber {
                    if numberView == nil {
                        numberView = View(position: position, character: character)
                    } else {
                        numberView!.append(character)
                    }
                }
                
                if let view = numberView, (!character.isWholeNumber || x == (engineSchematic.width - 1)) {
                    numberView = nil
                    
                    numberViews.append(view)
                }
            }
            
        }
        
        var gears: [Position : [View]] = [:]
        
        for view in numberViews {
            for move in view.possibleDirections(in: engineSchematic) {
                let position = Position(view.frame.position.x + move.x, view.frame.position.y + move.y)
                if engineSchematic[characterAt: position.x, position.y] == "*" {
                    var views = gears[position] ?? []
                    views.append(view)
                    gears[position] = views
                    continue
                }
            }
        }
        
        sum = gears.reduce(into: 0) { result, element in
            guard element.value.count == 2 else { return }
            
            result += element.value.reduce(into: 1, { $0 *= $1.number })
        }
        
        return sum
    }
    
    
    
}
