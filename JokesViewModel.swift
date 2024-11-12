//
//  JokesViewModel.swift
//  JokesAppSwiftUI
//
//  Created by Hamza Batuhan Kasar on 6.11.2024.
//

import Foundation
import Alamofire

class JokesViewModel: ObservableObject {
    
    @Published var jokes = [Value]()
    
    init() {
        getJokes(count: 6)
    }
    
    func getJokes(count: Int = 1) {
        AF.request("https://raw.githubusercontent.com/atilsamancioglu/JokesAppJsonData/main/chuck.json", method: .get).responseDecodable(of: Welcome.self) { response in
            switch response.result {
            case .success(let data):
                // Gelen şakalardan henüz olmayan rastgele bir şaka seç
                let uniqueJokes = data.value.filter { joke in
                    !self.jokes.contains(where: { $0.id == joke.id })
                }
                
                // Eğer henüz eklenmemiş şakalar varsa rastgele bir tanesini ekle
                if let randomJoke = uniqueJokes.randomElement() {
                    self.jokes.append(randomJoke)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
