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
    @IBOutlet weak var statsCollectionView: UICollectionView!

    @IBOutlet weak var statsLabel: Bold20Label!

    @IBOutlet weak var abilitiesLabel: Medium16Label!
    @IBOutlet weak var weightLabel: Medium16Label!

    
    @IBOutlet weak var tipologiesLabel: Medium16Label!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchDetail()
        viewModel.noDetails.bind { [weak self] value in
            if(value){
                self?.showNoDetailsError()
            }
        }
        viewModel.details.bind { [weak self] info in
            DispatchQueue.main.async {
                self?.statsLabel.text = "STATISTICS"
                self?.statsLabel.textColor = UIColor.white

                self?.nameLabel.text = info.name.uppercased()
                self?.weightLabel.text = "WEIGHT: \(info.weight)"
                let types = info.getTypologiesConcatStr()
                if(types.isEmpty){
                    self?.tipologiesLabel.text = "TYPOLOGY: ND"
                }
                else{
                    self?.tipologiesLabel.text = "TYPOLOGY: \(types)"

                }

                let abilities = info.getAbilitiesConcatStr()
                if(abilities.isEmpty){
                    self?.abilitiesLabel.text = "ABILITIES: ND"
                }
                else{
                    self?.abilitiesLabel.text = "ABILITIES: \(abilities)"

                }
                if(info.images.count > 0){
                    self?.imagesCollectionView.flashScrollIndicators()
                }
                self?.imagesCollectionView.reloadData()
                self?.statsCollectionView.reloadData()

            }
        }
        // Do any additional setup after loading the view.
    }

    func showNoDetailsError(){
        let alert = UIAlertController(title: "Attention", message: "No pokemon details available. Please check your internet connection ans retry.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }


    @IBAction func tapOnClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        if(collectionView == statsCollectionView){
            return viewModel.details.value.stats.count
        }
        else if(collectionView == imagesCollectionView){
            return viewModel.details.value.images.count
        }
        else{
            return 0
        }

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        if(collectionView == statsCollectionView){
            let statModel = viewModel.details.value.stats[index]
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: PokemonStatCell.ReuseIndetifier, for: indexPath) as! PokemonStatCell
            cell.initWithData(value: statModel.toString())
            return cell
        }
        else if(collectionView == imagesCollectionView){
            let imageUrl = viewModel.details.value.images[index]
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: PokemonImageCell.ReuseIndetifier, for: indexPath) as! PokemonImageCell
            cell.initWithData(urlString: imageUrl)
            return cell
        }
        else{
            return UICollectionViewCell()
        }

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
        if(collectionView == statsCollectionView){
            return CGSize(width: collectionView.frame.width, height: 30)
        }
        else if(collectionView == imagesCollectionView){
            return CGSize(width: 100, height: 100)
        }
        else{
            return CGSize(width: 0, height: 0)
        }
    }
}
