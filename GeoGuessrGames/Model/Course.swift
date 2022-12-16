//
//  Course.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import Foundation

struct Course: Decodable {
    let imageUrl: String
    let id: Int
    let title, body: String
    let author, latitude1, longitude1, latitude2: String
    let longitude2, latitude3, longitude3, latitude4: String
    let longitude4, latitude5, longitude5, latitude6: String
    let longitude6, latitude7, longitude7, latitude8: String
    let longitude8: String
}
