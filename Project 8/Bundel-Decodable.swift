//
//  Bundel-Decodable.swift
//  Project 8
//
//  Created by Юрий Филатов on 24.10.2021.
//

import Foundation

extension Bundle {
    func decode<T: Codable> (_ file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Faild to local \(file) in bundel")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Faild to load \(file) from bundel")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Faild to decode \(file) from bundel")
        }
        
        return loaded
    }
}
