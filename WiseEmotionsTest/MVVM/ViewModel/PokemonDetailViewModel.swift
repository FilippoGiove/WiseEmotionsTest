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
    var details = Box(PokemonDetailsModel(name: "", id: "", weight: "", height: "", images: [], types: []))
    var index = 0
    var nextPage:String?=nil

    // MARK: - Initialization
    init(of pokemon:PokemonModel) {
        self.mainInfo = pokemon
        fetchDetail()
    }

    

    public func fetchDetail() {
        if let url = mainInfo?.url{
            NSLog("url--->%@",url)
            getDetails(from:url, completion: {
                details,error in
                if let _ = error{
                    self.details.value = PokemonDetailsModel(name: "", id: "", weight: "", height: "", images: [], types: [])
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
        if let url = URL(string: url){
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: {
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
                                var heightPokemon = ""
                                var urlImages:[String] = []
                                var typesPokemon:[String] = []
                                if let name = jsonResult["name"] as? String{
                                    namePokemon = name
                                }
                                if let id = jsonResult["id"] {
                                    idPokemon = "\(id)"
                                }
                                if let weight = jsonResult["weight"]{
                                    weightPokemon = "\(weight)"
                                }
                                if let height = jsonResult["height"] as? String{
                                    heightPokemon = "\(height)"
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
                                NSLog("NOME--->%@",namePokemon)
                                let details = PokemonDetailsModel(name: namePokemon, id: idPokemon, weight: weightPokemon, height: heightPokemon, images: urlImages, types: typesPokemon)
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
