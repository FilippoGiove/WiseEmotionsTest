//
//  PokemonModel.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

// MARK: - Model
public class PokemonModel {


    public let name: String
    public let url: String

    public var imageUrl:String?

    public init(name: String,url:String) {
        self.name = name
        self.url = url

        var urlPokemon = url
        if(urlPokemon.last == "/"){
            urlPokemon.removeLast()
        }
        if let id = urlPokemon.components(separatedBy: "/").last {
            self.imageUrl = "\(POKEMON_PREFIX_URL_IMAGE)\(id).png"
        }
  }
}
