//
//  Drinks.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 16.07.2021.
//

import Foundation

struct CocktailResults: Codable {
    let drinkName: String
    let imageString: String
    let idCoctail: String

 
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
        case imageString = "strDrinkThumb"
        case idCoctail = "idDrink"
    }
}

struct DrinksResults: Codable {
    let drinks: [CocktailResults]
}

