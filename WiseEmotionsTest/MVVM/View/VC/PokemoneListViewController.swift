//
//  PokemoneListViewController.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

class PokemoneListViewController: UIViewController {

    var viewModel = PokemonListViewModel()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        self.collectionView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")
        viewModel.pokemons.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
           }

    }


}

extension PokemoneListViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item

        let model = self.viewModel.pokemons.value[index]
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PokemonCell.ReuseIndetifier, for: indexPath) as! PokemonCell
        cell.initWithData(model: model)
        return cell

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == viewModel.pokemons.value.count - 1 ) {
            viewModel.fetchNextPage()
         }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let model = self.viewModel.pokemons.value[index]

        let vcDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokemonDetailsViewController") as! PokemonDetailsViewController
        vcDetails.viewModel = PokemonDetailViewModel(of: model)
        self.present(vcDetails, animated: true, completion: nil)
    }
}
