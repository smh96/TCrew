//
//  NetworkManager.swift
//  TCrew
//
//  Created by Sander Haug on 04/06/2023.
//

import Foundation
import SwiftSoup

/*
    1. Create a GET request to the CRP link
    2. Convert the data to a Document for SwiftSoup
    3. Parse through the document to filter the ViewState and ViewStateGenerator
    4. Extract those variables
 
 */

final class NetworkingManager {
    
    static let shared = NetworkingManager()
  
    init() {}
    
    func requestTokens(_ absoluteURL: String,
                 completion: @escaping (Result<String, Error>) -> Void) {
        
        
        let url = URL(string: "https://cwp.transavia.com/CWP_WA/CWPLogin.aspx")
        let request = URLRequest(url: url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let tempHTML = String(data: data, encoding: .utf8)
            
                completion(.success(tempHTML!))
                
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
           
        }
        dataTask.resume()
    }
}

extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
