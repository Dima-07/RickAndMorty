//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Дима Кондратенко on 18.01.2026.
//

import Foundation
import UIKit

final class CharacterDetailViewModel {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String { return character.name }
    var status: String { return character.status }
    var speciesAndGender: String { return "Species: \(character.species) • Gender: \(character.gender)" }
    var location: String { return "Last known location: \n\(character.location.name)" }
    
    func fetchImage() async -> UIImage? {
        return await NetworkManager.shared.fetchImage(from: character.image)
    }
}
