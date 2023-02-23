//
//  ContentView.swift
//  Jokes
//
//  Created by Jeremy Taylor on 2/23/23.
//

import SwiftUI

struct JokeView: View {
    @StateObject var dataService = DataService()
    @AppStorage("selectedCategory") private var selectedCategory = Joke.JokeType.general
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(dataService.jokes.first?.setup ?? "")
                    .font(.largeTitle)
                Text(dataService.jokes.first?.punchline ?? "")
                    .font(.title)
                Spacer()
                
                Button("New Joke") {
                    Task {
                        await dataService.fetchJoke(type: selectedCategory)
                    }
                }
                .buttonStyle(.borderedProminent)
                
                
                
            }
            .navigationTitle("Jokes")
            .toolbar {
                ToolbarItem {
                    HStack(alignment:.firstTextBaseline ,spacing: -1) {
                        Text("Joke Type:")
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(Joke.JokeType.allCases, id: \.self) {category in
                                Text(category.rawValue.capitalized)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await dataService.fetchJoke(type: selectedCategory)
                }
            }
            .onChange(of: selectedCategory, perform: { _ in
                Task {
                    await dataService.fetchJoke(type: selectedCategory)
                }
            })
            .padding()
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}


