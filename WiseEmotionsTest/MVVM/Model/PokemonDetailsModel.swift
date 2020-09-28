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
    let url: String
    let images: [String]
    let abilities:[String]
    let stats:[PokemonStat]
    //    id weight and height are all INTs
    init(name: String, id: String, weight: String, url: String, images: [String], types:[String], abilities:[String],stats:[PokemonStat]){
        self.name = name
        self.types = types
        self.id = id
        self.weight = weight
        self.url = url
        self.images = images
        self.abilities = abilities
        self.stats = stats

    }

    func detailsNotLoaded()->Bool{
        return self.weight.isEmpty && self.url.isEmpty && self.images.count == 0 && self.abilities.count == 0 && self.stats.count == 0
    }

    func getImagesConcatStr()->String{
        var result = ""
        for s in images{
            if(result.isEmpty){
                result = s
            }
            else{
                result = "\(result),\(s)"
            }
        }
        return result
    }

    func getTypologiesConcatStr()->String{
        var result = ""
        for s in types{
            if(result.isEmpty){
                result = s
            }
            else{
                result = "\(result),\(s)"
            }
        }
        return result
    }

    func getAbilitiesConcatStr()->String{
            var result = ""
            for s in abilities{
                if(result.isEmpty){
                    result = s
                }
                else{
                    result = "\(result),\(s)"
                }
            }
            return result
    }

    static func fromDBModel(pokemon:Pokemon)->PokemonDetailsModel{
        let images = pokemon.images?.components(separatedBy: ",") ?? []
        let typologies = pokemon.typologies?.components(separatedBy: ",") ?? []
        let abilities = pokemon.abilities?.components(separatedBy: ",") ?? []
        let stats = DataManager.instance().getAllStatsOf(withName: pokemon.name)
        return PokemonDetailsModel(name: pokemon.name ?? "", id: pokemon.idPokemon ?? "", weight: pokemon.weight ?? "", url: pokemon.url ?? "", images: images, types: typologies, abilities: abilities, stats: stats)
    }

    
}



