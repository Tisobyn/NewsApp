//
//  Extension.swift
//  NewsApp
//
//  Created by Yermek Sabyrzhan on 26.03.2022.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    @discardableResult
    func loadImageFromURL(urlString: String,
                          placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil
        let key = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: key) {
            self.image = cachedImage
            return nil
        }
        guard let url = URL(string: urlString) else { return nil }
        if let placeholder = placeholder {
            self.image = placeholder
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data){
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        return task
    }
}
