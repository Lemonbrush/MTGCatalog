//
//  NetworkParams.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class NetworkParams {
    var urlSession: URLSession?
    
    var task: URLSessionTask?
    
    // request, for which the connection is made
    var request: URLRequest?
    
    // server response block
    var completionBlock: NetworkService.NetworkCompletionBlock?
    
    // responseData is binary data, when status is SUCCESS/200
    var responseData: NSMutableData?
}
