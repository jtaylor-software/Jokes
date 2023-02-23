//
//  Joke.swift
//  Jokes
//
//  Created by Jeremy Taylor on 2/23/23.
//

import Foundation

struct Joke: Decodable {
    let type: String
    let setup: String
    let punchline: String
    
     enum JokeType: String, CaseIterable {
         case general, programming
         case knockKnock = "knock-knock"
        
    }
}
