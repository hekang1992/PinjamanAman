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
    var involves: involvesModel?
    var go: involvesModel?
    var old: String?
    var thinking: String?
    var blend: String?
    var evolve: [evolveModel]?
}

class involvesModel: Codable {
    var laugh: Int?
    var possibilities: possibilitiesModel?
}

class possibilitiesModel: Codable {
    var blend: String?
    var thinking: String?
    var old: String?
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
    var conflicts: String?
    var mindset: String?
    var positivity: String?
    var opening: String?
    var good: String?
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

class evolveModel: Codable {
    var strain: String?
    var cultivated: String?
    var partner: String?
    var social: String?
    var worlds: String?
    var acceptance: String?
    var bonds: String?
    var lay: [layModel]?
}

/// enum
class layModel: Codable {
    var blend: String?
    var acceptance: String?
    
    enum CodingKeys: String, CodingKey {
        case blend, acceptance
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .acceptance) {
            acceptance = String(intValue)
        } else {
            acceptance = try? container.decode(String.self, forKey: .acceptance)
        }
        
        blend = try? container.decode(String.self, forKey: .blend)
    }
}
