//
//  PokemonDetailsViewController.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    public var viewModel: PokemonDetailViewModel!

    @IBOutlet weak var nameLabel: Bold20Label!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchDetail()
        viewModel.details.bind { [weak self] info in
            DispatchQueue.main.async {
                self?.nameLabel.text = info.name.uppercased()
                self?.imagesCollectionView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonDetailsViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.details.value.images.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let index = indexPath.item

        let imageUrl = viewModel.details.value.images[index]
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PokemonImageCell.ReuseIndetifier, for: indexPath) as! PokemonImageCell
        cell.initWithData(urlString: imageUrl)
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
        return CGSize(width: 100, height: 100)
    }
}
