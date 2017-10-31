//
//  SearchResponse.swift
//  SearchImageTest
//
//  Created by Sergio Veliz on 10/27/17.
//  Copyright © 2017 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResponse: Mappable {
    
    var items: [Items] = [Items]()
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        items    <- map["items"]
    }
}
