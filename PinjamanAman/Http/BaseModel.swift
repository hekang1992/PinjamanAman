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
    var vigor: String?
    var confide: [confideModel]?
    var see: [seeModel]?
    var smaller: smallerModel?
    var strike: [strikeModel]?
    var achievements: strikeModel?
}

class strikeModel: Codable {
    var strain: String?
    var cultivated: String?
    var spirit: String?
    var laugh: Int?
    var word: String?
}

class smallerModel: Codable {
    var resolve: String?
    var soften: String?
}

class confideModel: Codable {
    var strain: String?
    var gaining: String?
    var eyes: String?
}

class seeModel: Codable {
    var acceptance: String?
    var forgiveness: [forgivenessModel]?
}

class forgivenessModel: Codable {
    var opening: Int?
    var soften: String?
    var conflicts: String?
    var resolve: String?
    var effectively: String?
    var communicate: String?
    var opinion: String?
    var misunderstandings: String?
    var demands: String?
    var few: String?
}
