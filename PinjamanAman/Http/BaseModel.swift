//
//  BaseModel.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/9.
//

class BaseModel: Codable {
    var suc: String?
    var mes: String?
    var data: [dataModel]?
}

class dataModel: Codable {
    var list: [String]?
}


