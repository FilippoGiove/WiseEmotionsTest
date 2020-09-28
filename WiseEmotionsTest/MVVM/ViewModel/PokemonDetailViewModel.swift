//
//  PokemonDetailViewModel.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation
import UIKit


class PokemonDetailViewModel {
    var mainInfo:PokemonModel!
    var details = Box(PokemonDetailsModel(name: "", id: "", weight: "", url: "", images: [], types: [], abilities: [], stats: []))
    var index = 0
    var nextPage:String?=nil

    var noDetails = Box(false)

    // MARK: - Initialization
    init(of pokemon:PokemonModel) {
        self.mainInfo = pokemon
        if(Reachability.isConnectedToNetwork()){
            fetchDetail()
        }
        else{
            if let saved = DataManager.instance().getPokemon(withName: pokemon.name){
                let value = PokemonDetailsModel.fromDBModel(pokemon: saved)
                if(value.detailsNotLoaded()){
                    self.noDetails.value = true
                }
                else{
                    self.details.value = value
                }
            }
            else{
                self.noDetails.value = true
            }
        }

    }

    

    public func fetchDetail() {
        if let url = mainInfo?.url{
            getDetails(from:url, completion: {
                details,error in
                if let _ = error{
                    if let saved = DataManager.instance().getPokemon(withName: self.mainInfo.name){
                        self.details.value = PokemonDetailsModel.fromDBModel(pokemon: saved)
                    }
                    else{
                        self.noDetails.value = true
                    }
                }
                else{
                    self.details.value = details!
                }
            })
        }

    }

}

extension PokemonDetailViewModel {
    private func getDetails(from url:String,completion: @escaping (PokemonDetailsModel?, Error?) -> Void) {
        if let _url = URL(string: url){
            let session = URLSession.shared
            let task = session.dataTask(with: _url, completionHandler: {
                            data, response, error in
                    if(error != nil){
                        completion(nil,error)
                    }
                    else{
                        do {
                            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary{

                                var namePokemon = ""
                                var idPokemon = ""
                                var weightPokemon = ""
                                var urlImages:[String] = []
                                var typesPokemon:[String] = []
                                var abilitiesPokemon:[String] = []
                                var statsPokemon:[PokemonStat] = []

                                if let name = jsonResult["name"] as? String{
                                    namePokemon = name
                                }
                                if let id = jsonResult["id"] {
                                    idPokemon = "\(id)"
                                }
                                if let weight = jsonResult["weight"]{
                                    weightPokemon = "\(weight)"
                                }


                                if let spritesDictionary = jsonResult["sprites"] as? NSDictionary{
                                    if let back_female = spritesDictionary["back_female"] as? String{
                                        urlImages.append(back_female)
                                    }
                                    if let back_shiny_female = spritesDictionary["back_shiny_female"] as? String{
                                        urlImages.append(back_shiny_female)
                                    }
                                    if let back_default = spritesDictionary["back_default"] as? String{
                                        urlImages.append(back_default)
                                    }
                                    if let front_female = spritesDictionary["front_female"] as? String{
                                        urlImages.append(front_female)
                                    }
                                    if let front_shiny_female = spritesDictionary["front_shiny_female"] as? String{
                                        urlImages.append(front_shiny_female)
                                    }
                                    if let back_shiny = spritesDictionary["back_shiny"] as? String{
                                        urlImages.append(back_shiny)
                                    }
                                    if let front_default = spritesDictionary["front_default"] as? String{
                                        urlImages.append(front_default)
                                    }
                                    if let front_shiny = spritesDictionary["front_shiny"] as? String{
                                        urlImages.append(front_shiny)
                                    }
                                }
                                if let types = jsonResult["types"] {
                                    for type in types as! [AnyObject]{
                                        if let typeDict = type["type"] as? NSDictionary{
                                            if let typeStr = typeDict["name"] as? String{
                                                typesPokemon.append(typeStr)
                                            }
                                        }
                                    }
                                }
                                if let abilities = jsonResult["abilities"] {
                                    for ability in abilities as! [AnyObject]{
                                        if let abilityDict = ability["ability"] as? NSDictionary{
                                            if let abilityStr = abilityDict["name"] as? String{
                                                abilitiesPokemon.append(abilityStr)
                                            }

                                        }
                                    }
                                }
                                if let stats = jsonResult["stats"] {
                                    for stat in stats as! [AnyObject]{
                                        var value = ""
                                        var name = ""
                                        if let baseStat = stat["base_stat"] as? Int{
                                            value = "\(baseStat)"
                                        }
                                        if let statDict = stat["stat"] as? NSDictionary{
                                            if let statStr = statDict["name"] as? String{
                                                name = statStr
                                            }
                                        }
                                        if(!value.isEmpty && !name.isEmpty){
                                            statsPokemon.append(PokemonStat(name: name, baseStat: value)
)
                                        }
                                    }
                                }
                                let details = PokemonDetailsModel(name: namePokemon, id: idPokemon, weight: weightPokemon, url: url, images: urlImages, types: typesPokemon, abilities: abilitiesPokemon, stats: statsPokemon)


                                let result = DataManager.instance().insertOrUpdatePokemon(name: namePokemon, url: url, idPokemon: idPokemon, weight: weightPokemon, images: details.getImagesConcatStr(), typologies: details.getTypologiesConcatStr(), abilities: details.getAbilitiesConcatStr())

                                if(result){
                                    let _ = DataManager.instance().deleteAllStatsOf(pokemonName: namePokemon)
                                    for stat in statsPokemon{
                                        DataManager.instance().insertStat(pokemonName: namePokemon, stat: stat)
                                    }
                                }

                                completion(details,nil)
                            }
                        } catch {
                        }
                }
                })
                task.resume()
        }
    }
}
