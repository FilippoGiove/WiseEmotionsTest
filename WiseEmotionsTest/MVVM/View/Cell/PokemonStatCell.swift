//
//  PokemonStatCell.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 28/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

class PokemonStatCell: UICollectionViewCell {
    public static let ReuseIndetifier = "PokemonStatCell"


    @IBOutlet weak var valueLabel: UILabel!


    func initWithData(value:String){
        self.valueLabel.text = value
    }
}
