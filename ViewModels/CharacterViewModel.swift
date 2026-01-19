//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Дима Кондратенко on 06.01.2026.
//

import Foundation

enum ViewState {
    case loading
    case success
    case error(String)
}

final class CharacterViewModel {
    
    var characters: [Character] = []
    var onStateChanged: ((ViewState) -> Void)?
    
    func fetchCharacters() {
        onStateChanged?(.loading)
        
        Task {
            do {
                let response: CharacterResponse = try await NetworkManager.shared.fetch(from: "https://rickandmortyapi.com/api/character")
                
                self.characters = response.results
                
                await MainActor.run {
                    self.onStateChanged?(.success)
                }
            } catch {
                print("DEBUG: Ошибка загрузки: \(error.localizedDescription)")
                
                await MainActor.run {
                    self.onStateChanged?(.error("Не удалось загрузить данные. Проверьте соединение."))
                }
            }
        }
    }
}
