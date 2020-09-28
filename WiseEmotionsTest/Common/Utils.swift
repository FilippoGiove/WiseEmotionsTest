//
//  Utils.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit
import SDWebImage


class Utils{
    static func loadImageFromUrl(url: String, view: UIImageView){

        if let url = NSURL(string: url){
            view.sd_setImage(with: url as URL, completed: nil)
        }

        //NO PODS
        /*
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                DispatchQueue.main.async {
                    view.image = UIImage(data: data)
                }
            }
        }
        task.resume()*/



    }


    
}
