//
//  Countries.swift
//  TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

// MARK: - Countries
struct Country: Codable {
    let name: String
    let capital: String?
    let subregion: String
    let region: String
    let population: Int
    let latlng: [Double]?
}
