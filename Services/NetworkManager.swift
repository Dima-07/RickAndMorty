//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Дима Кондратенко on 06.01.2026.
//

import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    enum NetworkError: Error {
        case invalidURL
        case decodingError
        case encodingError
    }
    
    // --- 1. FETCH (GET) ---
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // --- 2. POST REQUEST ---
    func postRequest<T: Codable, U: Codable>(to urlString: String, body: U) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw NetworkError.encodingError
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // --- 3. ЗАГРУЗКА КАРТИНКИ ---
    func fetchImage(from urlString: String) async -> UIImage? {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as NSString)
                return image
            }
            return nil
        } catch {
            return nil
        }
    }
}
