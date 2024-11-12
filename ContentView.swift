//
//  ContentView.swift
//  JokesAppSwiftUI
//
//  Created by Hamza Batuhan Kasar on 6.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var jokesVM = JokesViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(jokesVM.jokes) { element in
                    Text(element.joke)
                }
                .onDelete(perform: deleteJoke)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: resetJokes) {
                        Text("Reset")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addJoke) {
                        Text("Get New Joke")
                    }
                }
            }
            .navigationTitle("Jokes App")
        }
    }
    
    func addJoke() {
        jokesVM.getJokes(count: 1)
    }
    
    func resetJokes() {
        jokesVM.jokes.removeAll()
    }
    func deleteJoke(at offsets: IndexSet) {
        jokesVM.jokes.remove(atOffsets: offsets)
        
    }
}

#Preview {
    ContentView()
}
