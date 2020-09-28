//
//  DataManager.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation
import CoreData
import UIKit


//MARK: DB ENTITY
let POKEMON_ENTITY_NAME = "Pokemon"
let STATISTICS_ENTITY_NAME = "Statistic"



class DataManager: NSObject {

    var appDelegate:AppDelegate!

    var coreDataPersistentManagedContenxt:NSManagedObjectContext!

    var lastSynchHasBeenSuccessfullyCompleted = true
    var lastSynchErrorMessage = ""


    private static var singleton: DataManager!
    static func instance() -> DataManager {
        if singleton == nil{
            singleton = DataManager.init()

        }
        return singleton
    }

   
    //MARK: CORE DATA - INIT
    public func initPersistentContainerContent(){
        if(appDelegate == nil){
            appDelegate = UIApplication.shared.delegate as? AppDelegate
        }
        if(coreDataPersistentManagedContenxt == nil){
            coreDataPersistentManagedContenxt = appDelegate.persistentContainer.viewContext

        }

    }
    //MARK: PERFORM SAVE CONTEXT
    func saveCoreDataChanges()->Bool{
        do {
            try coreDataPersistentManagedContenxt.save()
            return true
        } catch{
            return false
        }
    }
    //MARK: CLEAR ENTITY



    func clearAllDB(){
        clearLocalDBDataOf(entityName: POKEMON_ENTITY_NAME, commit: false)
        let _ = saveCoreDataChanges()

    }
    func clearLocalDBDataOf(entityName:String, commit:Bool){
        initPersistentContainerContent()

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)

        do {
            let objects = try coreDataPersistentManagedContenxt.fetch(fetchRequest)
            for object in objects {
                coreDataPersistentManagedContenxt.delete(object as! NSManagedObject)
            }
            if(commit){
               try coreDataPersistentManagedContenxt.save()
            }

        } catch _ {
            // error handling

        }

    }


    func getPokemon(withName name:String?)->Pokemon?{
        initPersistentContainerContent()
        guard let name = name else {return nil}
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: POKEMON_ENTITY_NAME)
        let resultPredicate = NSPredicate(format: "name = %@", name)
        request.predicate = resultPredicate
        do{
            let results = try coreDataPersistentManagedContenxt.fetch(request)
            if(results.count > 0){
                return results.first as? Pokemon
            }
        }
        catch{
        }
        return nil
    }

    func getAllPokemons()->[Pokemon]{
        initPersistentContainerContent()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: POKEMON_ENTITY_NAME)
        do{
            let results = try coreDataPersistentManagedContenxt.fetch(request)
            if(results.count > 0){
                return results as! [Pokemon]
            }
        }
        catch{
        }
        return []
    }


    func insertOrUpdatePokemon(name:String, url:String,idPokemon:String?, weight:String?, images:String?, typologies:String?,abilities:String?)->Bool{
        initPersistentContainerContent()
        if let saved = DataManager.instance().getPokemon(withName: name){
            saved.name = name
            saved.url = url
            if let idPokemon = idPokemon{
                saved.idPokemon = idPokemon
            }
            if let weight = weight{
                saved.weight = weight
            }
            if let images = images{
                saved.images = images
            }
            if let typologies = typologies{
                saved.typologies = typologies
            }
            if let abilities = abilities{
                saved.abilities = abilities
            }
       }
       else{
            let entity = NSEntityDescription.entity(forEntityName: POKEMON_ENTITY_NAME, in: coreDataPersistentManagedContenxt)
            let coreDataModel = NSManagedObject(entity: entity!, insertInto: coreDataPersistentManagedContenxt)
            coreDataModel.setValue(name, forKey: "name")
            coreDataModel.setValue(idPokemon, forKey: "idPokemon")

            coreDataModel.setValue(url, forKey: "url")
            coreDataModel.setValue(weight ?? "", forKey: "weight")
            coreDataModel.setValue(images ?? "", forKey: "images")
            coreDataModel.setValue(typologies ?? "", forKey: "typologies")
            coreDataModel.setValue(abilities ?? "", forKey: "abilities")

       }
       return saveCoreDataChanges()

    }

    func insertStat(pokemonName:String,stat:PokemonStat){
        guard let pokemon = getPokemon(withName: pokemonName) else {return}
        initPersistentContainerContent()
        let entity = NSEntityDescription.entity(forEntityName: STATISTICS_ENTITY_NAME, in: coreDataPersistentManagedContenxt)
        let coreDataModel = NSManagedObject(entity: entity!, insertInto: coreDataPersistentManagedContenxt)
        coreDataModel.setValue(stat.name, forKey: "nameStat")
        coreDataModel.setValue(stat.baseStat, forKey: "baseStat")
        coreDataModel.setValue(pokemon, forKey: "pokemon")
        let _ = saveCoreDataChanges()


    }

    func getAllStatsOf(pokemonName:String)->[Statistic]{
        let resultPredicate = NSPredicate(format: "pokemon.name = %@", pokemonName)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: STATISTICS_ENTITY_NAME)
        request.predicate = resultPredicate
        request.includesSubentities = true;
        do{
           let results = try coreDataPersistentManagedContenxt.fetch(request)
           return results as! [Statistic]
        }
        catch{
        }
        return []
    }

    func deleteAllStatsOf(pokemonName:String)->Bool{
        initPersistentContainerContent()

        let stats = DataManager.instance().getAllStatsOf(pokemonName: pokemonName)

        for stat in stats{
            do {
                coreDataPersistentManagedContenxt.delete(stat)
                try coreDataPersistentManagedContenxt.save()
            } catch _ {
                return false
            }
        }


        return true



    }


    func getAllStatsOf(withName name:String?)->[PokemonStat]{
        initPersistentContainerContent()
        guard let name = name else {return []}
        var stats:[PokemonStat] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: STATISTICS_ENTITY_NAME)
        let resultPredicate = NSPredicate(format: "pokemon.name = %@", name)
        request.predicate = resultPredicate
        do{
            var results = try coreDataPersistentManagedContenxt.fetch(request)
            if(results.count > 0){
                for s in results{
                    if let result = s as? Statistic{
                        stats.append(PokemonStat.fromDBModel(stat: result))
                    }
                }
            }
        }
        catch{
        }
        return stats
    }
}

