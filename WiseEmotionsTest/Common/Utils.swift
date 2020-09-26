//
//  Utils.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 26/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit


class Utils{
    static func loadImageFromUrl(url: String, view: UIImageView){

        // Create Url from string
        let url = NSURL(string: url)!

        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                // execute in UI thread
                DispatchQueue.main.async {
                    view.image = UIImage(data: data)
                }
            }
        }

        // Run task
        task.resume()
    }
}
