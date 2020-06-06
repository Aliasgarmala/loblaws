//
//  ImageContainer.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import UIKit

protocol ImageService: class {
   func fetchImage(url: URL, completion: @escaping (UIImage) -> Void)
}

extension ServiceLayerClient: ImageService {}

private let remoteImagePresenterCache: NSCache<NSURL, UIImage> = {
    let imageCache = NSCache<NSURL, UIImage>()
    return imageCache
}()

extension ImageService {
    func fetchImage(url: URL, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = remoteImagePresenterCache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    remoteImagePresenterCache.setObject(image, forKey: url as NSURL)
                    completion(image)
                }
            }
        }.resume()
    }
}
