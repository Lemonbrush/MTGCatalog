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
}

protocol ImageDownloaderManagerDelegate: AnyObject {
    func didReceiveImage(_ image: UIImage)
    func didReceiveError(_ error: ImageDownloaderManagerError)
}

class ImageDownloaderManager {
    
    // MARK: - Properties
    
    weak var delegate: ImageDownloaderManagerDelegate?
    
    // MARK: - Functions
    
    func getImageByURL(_ urlString: String) {
        DispatchQueue.global().async { [weak self] in
            guard let strongURL = URL(string: urlString),
                  let data = try? Data(contentsOf: strongURL) else {
                self?.delegate?.didReceiveError(.urlError)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let image = UIImage(data: data) else {
                    self?.delegate?.didReceiveError(.failedToConvertImageData)
                    return
                }
                self?.delegate?.didReceiveImage(image)
            }
        }
        
        delegate?.didReceiveError(.didNotReceiveData)
    }
}
