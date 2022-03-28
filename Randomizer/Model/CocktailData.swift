//
//  CocktailData.swift
//  Randomizer
//
//  Created by Sabi on 21.03.2022.
//

import Foundation

struct CocktailData: Decodable {
    let strDrinkThumb: String
}

struct Returned: Decodable {
    var drinks: [CocktailData]
}
