//
//  PlayingCard.swift
//  playingCard
//
//  Created by 이지원 on 2020/09/11.
//  Copyright © 2020 JiWon Lee. All rights reserved.
//

import Foundation

struct PlayingCard {
    var suit: Suit
    var rank: Rank
    
    enum Suit: String {
        case spades = "♠️"
        case hearts = "❤️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        static var all: [Suit] = [.spades, .hearts, .diamonds, .clubs]
    }
    
    enum Rank {
        case ace
        case faces(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .faces(let kind) where kind == "J": return 11
            case .faces(let kind) where kind == "Q": return 12
            case .faces(let kind) where kind == "K": return 13
            default:
                return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks: [Rank] = [.ace]
            
            for pips in 2...10 {
                allRanks.append(numeric(pips))
            }
            
            allRanks += [.faces("J"), .faces("Q"), .faces("K")]
            return allRanks
        }
    }
}
