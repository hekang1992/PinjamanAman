//
//  BaseModel.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

class BaseModel: Codable {
    var partner: String?
    var reason: String?
    var logic: logicModel?
}

class logicModel: Codable {
    var realm: String?
}


