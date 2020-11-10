//
//  REST.swift
//  projeto-dont-waste
//
//  Created by Gabriel Marinho on 05/11/20.
//

import Foundation

enum userError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code:Int)
    case invalidJSON
}

class REST {
    
    private static let basePath = "http://localhost:3002/usuario"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadUsers(onComplete: @escaping ([register]) -> Void, onError: @escaping (userError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    do{
                    let info = try JSONDecoder().decode([register].self, from: data)
                        onComplete(info)
                    }catch{
                       debugPrint(error)
                        onError(.invalidJSON)
                    }
                }else {
                    print("Status Invalido!")
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
}
