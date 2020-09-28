//
//  PokemonStat.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 28/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation
public class PokemonStat {
    let name: String
    let baseStat: String
    init(name: String, baseStat: String){
        self.name = name
        self.baseStat = baseStat
    }

    func toString()->String{
        return "\(name.uppercased()): \(baseStat)"
    }


    static func fromDBModel(stat:Statistic)->PokemonStat{

        return PokemonStat(name: stat.nameStat ?? "", baseStat: stat.baseStat ?? "")
    }



}
