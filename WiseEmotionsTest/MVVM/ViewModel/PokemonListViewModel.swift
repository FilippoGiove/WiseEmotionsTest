//
//  PokemonListViewModel.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit


class PokemonListViewModel {
    var pokemons = Box([PokemonModel]())
    var index = 0
    var nextPage:String?=nil

    // MARK: - Initialization
    init() {
        if(Reachability.isConnectedToNetwork()){
            fetchNextPage()
        }
        else{
            let pokemonFromDB = DataManager.instance().getAllPokemons()
            var fetched:[PokemonModel] = []
            for p in pokemonFromDB{
                let pokemon = PokemonModel(name: p.name ?? "", url: p.url ?? "")
                fetched.append(pokemon)
            }
            self.pokemons.value = fetched
        }
    }

    public func fetchNextPage() {
        fetchPokemon(completion: {
            pokemons,error in
            if let _ = error{
                self.pokemons.value = []
            }
            else{
                self.pokemons.value.append(contentsOf: pokemons)
            }
        })
    }

}

extension PokemonListViewModel {
    public func fetchPokemon(completion: @escaping ([PokemonModel], Error?) -> Void) {
        let url = nextPage == nil ? URL(string: POKEMON_LIST_API)! : URL(string: nextPage!)!
        let session = URLSession.shared
        var newPokemons:[PokemonModel] = []
        let task = session.dataTask(with: url, completionHandler: {
                        data, response, error in

                if(error != nil){
                    completion([],error)
                }
                else{
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            if let nextPage = jsonResult["next"] as? String{
                                self.nextPage = nextPage
                            }
                            if let results = jsonResult["results"] {
                                let resultsArray = results as! NSArray
                                for i in 0 ..< (resultsArray.count) {
                                    let pokemonDictionary = resultsArray[i] as! NSDictionary
                                    let name = pokemonDictionary["name"] as? String ?? ""
                                    let url = (pokemonDictionary["url"] as? String) ?? ""

                                    let p = PokemonModel(name: name, url: url)
                                    let _ = DataManager.instance().insertOrUpdatePokemon(name: name, url: url, idPokemon: "", weight: nil, images: nil, typologies: nil, abilities: nil)
                                    newPokemons.append(p)
                                }
                                completion(newPokemons,nil)
                            }

                        }
                    } catch {
                        print ("Something Went Wrong")
                    }
            }

                    })
                    task.resume()



    }
}
