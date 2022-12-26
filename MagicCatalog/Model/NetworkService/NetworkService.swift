//
//  NetworkService.swift
//  MagicCatalog
//
//  Created by Alexander Rubtsov on 24.12.2022.
//

import Foundation

class NetworkService: NSObject {
    
    typealias NetworkCompletionBlock = (_ result: Result<Data, NetworkServiceError>) -> (Void)
    
    // MARK: - Private properties
    
    private var networkParams: Array<NetworkParams> = []
    
    // MARK: - Functions
    
    func get(_ postData: Data?, _ request: URLRequest, completion: @escaping NetworkCompletionBlock) {
        var request = request
        request.httpMethod = "GET"
        
        if let strongPostData = postData {
            request.httpBody = strongPostData
        }
        
        networkCall(request, completion: completion)
    }
    
    func post(_ postData: Data, request: URLRequest, completion: @escaping NetworkCompletionBlock) {
        var request = request
        request.httpBody = postData as Data
        request.httpMethod = "POST"
        
        networkCall(request, completion: completion)
    }
    
    // MARK: - With timeout
    
    func get(_ postData: Data?, _ urlSring: String, timeout: TimeInterval, completion: @escaping NetworkCompletionBlock) {
        guard let url = URL(string: urlSring) else {
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        request.httpMethod = "GET"
        
        if let strongPostData = postData {
            request.httpBody = strongPostData
        }
        
        networkCall(request, completion: completion)
    }
    
    func post(_ urlSring: String, body: Data, timeout: TimeInterval, completion: @escaping NetworkCompletionBlock) {
        guard let url = URL(string: urlSring) else {
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        post(body, request: request, completion: completion)
    }
    
    // MARK: - With headers
    
    func get(_ postData: Data?, _ urlSring: String, headers: [String:String], timeout: TimeInterval, completion: @escaping NetworkCompletionBlock) {
        guard let url = URL(string: urlSring) else {
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        
        for key in headers.keys {
            request.setValue(headers[key], forHTTPHeaderField: key)
        }
        
        get(postData, request, completion: completion)
    }
    
    func post(_ urlSring: String, body: Data, headers: [String:String], timeout: TimeInterval, completion: @escaping NetworkCompletionBlock) {
        guard let url = URL(string: urlSring) else {
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        
        for key in headers.keys {
            request.setValue(headers[key], forHTTPHeaderField: key)
        }
        
        post(body, request: request, completion: completion)
    }
    
    // MARK: - Private functions
    
    private func networkCall(_ request: URLRequest, completion: @escaping NetworkCompletionBlock) {
        let configurationId = String(format: "Network%d", arc4random())
        let configuration = URLSessionConfiguration.background(withIdentifier: configurationId)
        configuration.timeoutIntervalForRequest = request.timeoutInterval
        configuration.timeoutIntervalForResource = request.timeoutInterval
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *) {
            configuration.waitsForConnectivity = true
        }
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.current)
        let task = session.dataTask(with: request)
        
        task.resume()
        
        let param = NetworkParams()
        param.urlSession = session
        param.completion = completion
        param.request = request
        networkParams.append(param)
        
        let newtask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error, let self = self {
                let convertedError = self.convertError(error)
                completion(.failure(convertedError))
                return
            }
            
            guard let receivedData = data else {
                completion(.failure(.failedToRecognizeData))
                return
            }
            
            guard let strongResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard (200...299).contains(strongResponse.statusCode) else {
                completion(.failure(.filedWithStatusCode(strongResponse.statusCode)))
                return
            }
            
            completion(.success(receivedData))
        }
        newtask.resume()
    }
    
    private func convertError(_ error: Error?) -> NetworkServiceError {
        switch (error as? URLError)?.code {
        case .some(.timedOut):
            return .timeOut
        case .some(.notConnectedToInternet):
            return .notConnectedToInternet
        default:
            return .unknown(error)
        }
    }
    
    func getNetworkParams(_ session: URLSession) -> NetworkParams? {
        let params = networkParams.filter {
            $0.urlSession == session
        }
        
        guard params.count > 0, let param = params.last else {
            return nil
        }
        
        return param
    }
}

extension NetworkService: URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    //MARK: - Functions
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let param = getNetworkParams(session) else {
            return
        }
        param.completion?(Result.failure(.unknown(error)))
    }
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let param = getNetworkParams(session) else {
            return
        }
        
        if param.responseData == nil {
            param.responseData = NSMutableData(capacity: 0)
        }
        
        param.responseData?.append(data)
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        var disposition: URLSession.AuthChallengeDisposition = URLSession.AuthChallengeDisposition.performDefaultHandling
        var credential: URLCredential?
        
        
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
                let serviceTrust = challenge.protectionSpace.serverTrust else {
            disposition = URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge
            completionHandler(disposition, credential)
            return
        }
        
        credential = URLCredential(trust: serviceTrust)
        disposition = credential != nil ? .useCredential : .performDefaultHandling
        completionHandler(disposition, credential)
    }
}
