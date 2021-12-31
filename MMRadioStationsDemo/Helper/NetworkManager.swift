//
//  NetworkManager.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation
import UIKit

class NetworkManager {
    
    let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = 60.0
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        return session
    }()
    
    static let shared = NetworkManager()
    
    func downloadImage(from imageUrl: String, completion: ((_ imageData: Data?) -> Void)?) {
        guard let url = URL(string: imageUrl) else {
            completion?(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else {
                    completion?(nil)
                    return
                }
            completion?(data)
        }.resume()
    }
    
    func getStations(urlString: String, completion: ((_ data: Data?) -> Void)?) {
        guard let url = URL(string: urlString) else {
            return
        }
        urlSession.downloadTask(with: URLRequest(url: url)) { (localUrl, urlResponse, error) in
            guard let localUrl = localUrl, error == nil else {
                completion?(nil)
                return
            }
            if let data = try? Data(contentsOf: localUrl) {
                completion?(data)
            } else {
                completion?(nil)
            }
        }.resume()
    }
}
