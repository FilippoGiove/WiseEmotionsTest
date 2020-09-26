//
//  PokemonDetailModel.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation
public class PokemonDetailsModel {
    let name: String
    let types: [String]
    let id: String
    let weight: String
    let height: String
    let images: [String]
    //    id weight and height are all INTs
    init(name: String, id: String, weight: String, height: String, images: [String], types:[String]){
        self.name = name
        self.types = types
        self.id = id
        self.weight = weight
        self.height = height
        self.images = images
    }
}



