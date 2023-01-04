//
//  ImageDownloaderManager.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 21.12.2022.
//

import UIKit

enum ImageDownloaderManagerError: Error {
    case urlError
    case didNotReceiveData
    case failedToConvertImageData
    case didReceiveError(Error)
}

class ImageDownloaderManager {
    
    // MARK: - Functions
    
    func getImageByURL(_ urlString: String, completion: @escaping ((UIImage?, ImageDownloaderManagerError?) -> Void)) {
        DispatchQueue.global().async {
            guard let strongURL = URL(string: urlString) else {
                completion(nil, .urlError)
                return
            }
            
            do {
                let data = try Data(contentsOf: strongURL)
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else {
                        completion(nil, .failedToConvertImageData)
                        return
                    }
                    completion(image, nil)
                }
                return
            } catch {
                completion(nil, .didReceiveError(error))
                return
            }
        }
    }
}
