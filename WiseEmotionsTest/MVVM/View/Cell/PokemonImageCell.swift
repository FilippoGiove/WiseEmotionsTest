//
//  PokemonImageCell.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

class PokemonImageCell: UICollectionViewCell {
    public static let ReuseIndetifier = "PokemonImageCell"


    @IBOutlet weak var imageView: UIImageView!


    func initWithData(urlString:String){
        if let _ = URL(string: urlString){
            Utils.loadImageFromUrl(url: urlString, view: imageView)

        }
    }

}
