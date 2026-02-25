//
//  BaseModel.swift
//  PinjamanAman
//
//  Created by Michael Brown on 2026/2/9.
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
    var found: foundModel?
    var analysisability: analysisabilityModel?
}

class analysisabilityModel: Codable {
    var walkety: String?
    var shortster: String?
    var cur: String?
    var middleee: String?
}

class foundModel: Codable {
    var see: [evolveModel]?
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

class confideModel: Codable {
    var strain: String?
    var gaining: String?
    var eyes: String?
}

class seeModel: Codable {
    var acceptance: String?
    var forgiveness: [forgivenessModel]?
    var gives: [layModel]?
    var ahead: String?
    var beliefs: String?
    var blend: String?
    var forValue: String?
    var remain: String?
    var ahistories: String?
    var dhistories: String?
    var chistories: String?
    var fhistories: String?
    var views: viewsModel?
    var conflicts: String?
    var soften: String?
    var resolve: String?
    var materials: String?
    var economy: String?
    var chaos: String?
    var partner: String?
    var remind: [seeModel]?
    
    enum CodingKeys: String, CodingKey {
        case acceptance
        case forgiveness
        case gives
        case ahead
        case beliefs
        case blend
        case forValue = "for"
        case remain
        case ahistories
        case dhistories
        case chistories
        case fhistories
        case views
        case conflicts
        case soften
        case resolve
        case economy
        case materials
        case chaos
        case partner
        case remind
    }
}

class viewsModel: Codable {
    var boyose: String?
    var showWord: String?
    var provimories: String?
    var rejuvenation: String?
    var tip: String?
    var fhaeprov: String?
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
    var divide: String?
    var tested: String?
    var reason: String?
    var vigor: String?
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

class evolveModel: Codable {
    var strain: String?
    var cultivated: String?
    var partner: String?
    var social: String?
    var worlds: String?
    var acceptance: String?
    var bonds: String?
    var lay: [layModel]?
    
    var forgiveness: [forgivenessModel]?
    var gives: [layModel]?
    var ahead: String?
    var beliefs: String?
    var blend: String?
    var forValue: String?
    var remain: String?
    var ahistories: String?
    var dhistories: String?
    var chistories: String?
    var fhistories: String?
    
    enum CodingKeys: String, CodingKey {
        case strain
        case cultivated
        case partner
        case social
        case worlds
        case acceptance
        case bonds
        case lay
        case forgiveness
        case gives
        case ahead
        case beliefs
        case blend
        case forValue = "for"
        case remain
        case ahistories
        case dhistories
        case chistories
        case fhistories
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let strainValue = try? container.decodeIfPresent(String.self, forKey: .strain) {
            strain = strainValue
        } else if let strainInt = try? container.decodeIfPresent(Int.self, forKey: .strain) {
            strain = String(strainInt)
        }
        
        if let cultivatedValue = try? container.decodeIfPresent(String.self, forKey: .cultivated) {
            cultivated = cultivatedValue
        } else if let cultivatedInt = try? container.decodeIfPresent(Int.self, forKey: .cultivated) {
            cultivated = String(cultivatedInt)
        }
        
        if let partnerValue = try? container.decodeIfPresent(String.self, forKey: .partner) {
            partner = partnerValue
        } else if let partnerInt = try? container.decodeIfPresent(Int.self, forKey: .partner) {
            partner = String(partnerInt)
        }
        
        if let socialValue = try? container.decodeIfPresent(String.self, forKey: .social) {
            social = socialValue
        } else if let socialInt = try? container.decodeIfPresent(Int.self, forKey: .social) {
            social = String(socialInt)
        }
        
        if let worldsValue = try? container.decodeIfPresent(String.self, forKey: .worlds) {
            worlds = worldsValue
        } else if let worldsInt = try? container.decodeIfPresent(Int.self, forKey: .worlds) {
            worlds = String(worldsInt)
        }
        
        if let acceptanceValue = try? container.decodeIfPresent(String.self, forKey: .acceptance) {
            acceptance = acceptanceValue
        } else if let acceptanceInt = try? container.decodeIfPresent(Int.self, forKey: .acceptance) {
            acceptance = String(acceptanceInt)
        }
        
        if let bondsValue = try? container.decodeIfPresent(String.self, forKey: .bonds) {
            bonds = bondsValue
        } else if let bondsInt = try? container.decodeIfPresent(Int.self, forKey: .bonds) {
            bonds = String(bondsInt)
        }
        
        if let aheadValue = try? container.decodeIfPresent(String.self, forKey: .ahead) {
            ahead = aheadValue
        } else if let aheadInt = try? container.decodeIfPresent(Int.self, forKey: .ahead) {
            ahead = String(aheadInt)
        }
        
        if let beliefsValue = try? container.decodeIfPresent(String.self, forKey: .beliefs) {
            beliefs = beliefsValue
        } else if let beliefsInt = try? container.decodeIfPresent(Int.self, forKey: .beliefs) {
            beliefs = String(beliefsInt)
        }
        
        if let blendValue = try? container.decodeIfPresent(String.self, forKey: .blend) {
            blend = blendValue
        } else if let blendInt = try? container.decodeIfPresent(Int.self, forKey: .blend) {
            blend = String(blendInt)
        }
        
        if let forValue = try? container.decodeIfPresent(String.self, forKey: .forValue) {
            self.forValue = forValue
        } else if let forInt = try? container.decodeIfPresent(Int.self, forKey: .forValue) {
            self.forValue = String(forInt)
        }
        
        if let remainValue = try? container.decodeIfPresent(String.self, forKey: .remain) {
            remain = remainValue
        } else if let remainInt = try? container.decodeIfPresent(Int.self, forKey: .remain) {
            remain = String(remainInt)
        }
        
        if let ahistoriesValue = try? container.decodeIfPresent(String.self, forKey: .ahistories) {
            ahistories = ahistoriesValue
        } else if let ahistoriesInt = try? container.decodeIfPresent(Int.self, forKey: .ahistories) {
            ahistories = String(ahistoriesInt)
        }
        
        if let dhistoriesValue = try? container.decodeIfPresent(String.self, forKey: .dhistories) {
            dhistories = dhistoriesValue
        } else if let dhistoriesInt = try? container.decodeIfPresent(Int.self, forKey: .dhistories) {
            dhistories = String(dhistoriesInt)
        }
        
        if let chistoriesValue = try? container.decodeIfPresent(String.self, forKey: .chistories) {
            chistories = chistoriesValue
        } else if let chistoriesInt = try? container.decodeIfPresent(Int.self, forKey: .chistories) {
            chistories = String(chistoriesInt)
        }
        
        if let fhistoriesValue = try? container.decodeIfPresent(String.self, forKey: .fhistories) {
            fhistories = fhistoriesValue
        } else if let fhistoriesInt = try? container.decodeIfPresent(Int.self, forKey: .fhistories) {
            fhistories = String(fhistoriesInt)
        }
        
        lay = try container.decodeIfPresent([layModel].self, forKey: .lay)
        forgiveness = try container.decodeIfPresent([forgivenessModel].self, forKey: .forgiveness)
        gives = try container.decodeIfPresent([layModel].self, forKey: .gives)
    }
}

class smallerModel: Codable {
    var resolve: String?
    var soften: String?
    var conflicts: String?
    var mindset: String?
    var positivity: String?
    var opening: String?
    var good: String?
    var midst: String?
    var practice: String?
    
    private enum CodingKeys: String, CodingKey {
        case resolve, soften, conflicts, mindset, positivity, opening, good, midst, practice
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        resolve = (try? container.decode(Int.self, forKey: .resolve)).map { String($0) } ?? (try? container.decode(String.self, forKey: .resolve))
        soften = (try? container.decode(Int.self, forKey: .soften)).map { String($0) } ?? (try? container.decode(String.self, forKey: .soften))
        conflicts = (try? container.decode(Int.self, forKey: .conflicts)).map { String($0) } ?? (try? container.decode(String.self, forKey: .conflicts))
        mindset = (try? container.decode(Int.self, forKey: .mindset)).map { String($0) } ?? (try? container.decode(String.self, forKey: .mindset))
        positivity = (try? container.decode(Int.self, forKey: .positivity)).map { String($0) } ?? (try? container.decode(String.self, forKey: .positivity))
        opening = (try? container.decode(Int.self, forKey: .opening)).map { String($0) } ?? (try? container.decode(String.self, forKey: .opening))
        good = (try? container.decode(Int.self, forKey: .good)).map { String($0) } ?? (try? container.decode(String.self, forKey: .good))
        midst = (try? container.decode(Int.self, forKey: .midst)).map { String($0) } ?? (try? container.decode(String.self, forKey: .midst))
        practice = (try? container.decode(Int.self, forKey: .practice)).map { String($0) } ?? (try? container.decode(String.self, forKey: .practice))
    }
}
