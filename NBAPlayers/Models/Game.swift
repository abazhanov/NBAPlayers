//
//  Game.swift
//  NBAPlayers
//
//  Created by Artem Bazhanov on 10.11.2020.
//

import Foundation

struct Game: Decodable {
    let vScore: Int
    
    let homeTeam: HomeTeam
    
    enum CodingKeys: String, CodingKey {
        case vScore = "visitor_team_score"
        case homeTeam = "home_team"
        
    }
    
    
   
    
}

struct GamesPesponse: Decodable{
    let data: [Game]
    
}
