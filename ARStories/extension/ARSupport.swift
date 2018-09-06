//
//  ARSupport.swift
//  ARStories
//
//  Created by ANTONY RAPHEL on 04/09/18.
//

import Foundation
import UIKit

class ImageLoader: UIImageView {
    public func loadImageWith(from urlString: String, completion: @escaping (Bool, UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, UIImage())
                return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data) {
                    completion(true, imageToCache)
                } else {
                    completion(false, UIImage())
                }
            }
            }.resume()
    }
}

extension UIImageView {
    func imageFromServerURL(_ URLString: String) {
        self.image = nil
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
