//
//  NetworkManager.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

import Alamofire

let h5_url = "http://8.215.85.157:10903"
let base_url = "\(h5_url)/ptk"

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
}

extension NetworkManager {
    
    static let getSession: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Session(configuration: config)
    }()
    
    static let postSession: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return Session(configuration: config)
    }()
}

extension NetworkManager {
    
    static func get<T: Codable>(
        url: String,
        params: [String: Any]?,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        
        getSession.upload(
            multipartFormData: { formData in
                params?.forEach { key, value in
                    let data = "\(value)".data(using: .utf8) ?? Data()
                    formData.append(data, withName: key)
                }
            },
            to: url,
            method: .get
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}

extension NetworkManager {
    
    static func post<T: Codable>(
        url: String,
        params: [String: Any],
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        
        postSession.upload(
            multipartFormData: { formData in
                params.forEach { key, value in
                    let data = "\(value)".data(using: .utf8) ?? Data()
                    formData.append(data, withName: key)
                }
            },
            to: url,
            method: .post
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}

extension NetworkManager {
    
    static func post<T: Codable>(
        url: String,
        params: [String: Any],
        imageData: Data,
        imageKey: String = "image",
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        
        postSession.upload(
            multipartFormData: { formData in
                
                params.forEach { key, value in
                    let data = "\(value)".data(using: .utf8) ?? Data()
                    formData.append(data, withName: key)
                }
                
                formData.append(
                    imageData,
                    withName: imageKey,
                    fileName: "image.jpg",
                    mimeType: "image/jpeg"
                )
            },
            to: url,
            method: .post
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
