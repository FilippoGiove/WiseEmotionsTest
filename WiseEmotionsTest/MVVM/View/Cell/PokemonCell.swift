//
//  PokemonCell.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit
import SDWebImage
class PokemonCell: UICollectionViewCell {

    public static let ReuseIndetifier = "PokemonCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initWithData(model:PokemonModel){
        self.nameLabel.text = model.name.uppercased()
        if let imageUrl = model.imageUrl{
            //self.imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
            Utils.loadImageFromUrl(url: imageUrl, view: self.imageView)        }

    }

}
