//
//  DataService.swift
//  Jokes
//
//  Created by Jeremy Taylor on 2/23/23.
//

import Foundation

@MainActor
class DataService: ObservableObject {
    @Published var jokes: [Joke] = []
    
    let baseURL = "https://official-joke-api.appspot.com/jokes/"
    var components = URLComponents()
    
    
    
    func fetchJoke(type: Joke.JokeType) async {
        components.scheme = "https"
        components.path = "official-joke-api.appspot.com/jokes/\(type.rawValue)/random"
        
        let url = components.url
        guard let url else {
            fatalError("Invalid URL")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            jokes = try JSONDecoder().decode([Joke].self, from: data)
        } catch {
            fatalError("Could not get data")
        }
    }
}
