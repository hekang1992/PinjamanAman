//
//  ProvicesModelManager.swift
//  PinjamanAman
//
//  Created by hekang on 2026/2/11.
//

import BRPickerView

class AdcManager {
    static let shared = AdcManager()
    private init() {}
    var modelArray: [seeModel]?
}

struct AdcCitysManager {
    
    static func getAddressModelArray(dataSourceArr: [seeModel]) -> [BRTextModel] {
        return createModels(from: dataSourceArr)
    }
    
    private static func createModels(from items: [seeModel]?) -> [BRTextModel] {
        guard let items = items else { return [] }
        
        return items.enumerated().map { index, item in
            let model = BRTextModel()
            model.code = item.partner ?? ""
            model.text = item.blend
            model.index = index
            
            model.children = createModels(from: item.remind)
            
            return model
        }
    }
}
