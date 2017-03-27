//
//  Model.swift
//  RxSwiftAlamofire
//
//  Created by Arash on 3/27/17.
//  Copyright © 2017 Arash Z. Jahangiri. All rights reserved.
//

import ObjectMapper

class Model: Mappable {
    var status:                 Int!
    var dateStr:                String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        dateStr <- map["date"]
    }
}
