//
//  Character.swift
//  RickAndMorty
//
//  Created by Дима Кондратенко on 06.01.2026.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: Location
    
    struct Location: Codable {
        let name: String
    }
}

