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
    
    static let postSession: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return Session(configuration: config)
    }()
}

extension NetworkManager {
    
    static func get<T: Codable>(
        url: String,
        params: [String: Any]? = nil,
        timeout: TimeInterval = 30,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        let apiUrl = (base_url + url).appendingQueryParams(DeviceInfoManager.getDeviceInfoDictionary())
        
        AF.request(
            apiUrl,
            method: .get,
            parameters: params,
            encoding: URLEncoding.default,
            requestModifier: { $0.timeoutInterval = timeout }
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
        params: [String: Any]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        let apiUrl = (base_url + url).appendingQueryParams(DeviceInfoManager.getDeviceInfoDictionary())
        
        postSession.upload(
            multipartFormData: { formData in
                params?.forEach { key, value in
                    let data = "\(value)".data(using: .utf8) ?? Data()
                    formData.append(data, withName: key)
                }
            },
            to: apiUrl,
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
        params: [String: Any]? = nil,
        imageData: Data,
        imageKey: String = "image",
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        
        let apiUrl = (base_url + url).appendingQueryParams(DeviceInfoManager.getDeviceInfoDictionary())
        
        postSession.upload(
            multipartFormData: { formData in
                
                params?.forEach { key, value in
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
            to: apiUrl,
            method: .post
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}

extension String {
    func appendingQueryParams(_ parameters: [String: String]) -> String {
        guard var components = URLComponents(string: self) else { return self }
        var queryItems = components.queryItems ?? []
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        return components.url?.absoluteString ?? self
    }
}
