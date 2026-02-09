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
    
    enum CodingKeys: String, CodingKey {
        case partner, reason, logic
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .partner) {
            partner = String(intValue)
        } else {
            partner = try? container.decode(String.self, forKey: .partner)
        }
        
        reason = try? container.decode(String.self, forKey: .reason)
        logic = try? container.decode(logicModel.self, forKey: .logic)
    }
}

class logicModel: Codable {
    var realm: String?
    var explained: String?
    var complements: String?
}


