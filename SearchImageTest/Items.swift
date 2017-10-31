//
//  Items
//  SearchImageTest
//
//  Created by Sergio Veliz on 10/27/17.
//  Copyright © 2017 Sergio Veliz. All rights reserved.
//

import Foundation
import ObjectMapper

class Items: Mappable {
    
    var title: String = ""
    var link: String = ""
    var image: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title    <- map["title"]
        link    <- map["link"]
        image     <- map["image.thumbnailLink"]
    }
    
    func getLinkImage() -> URL {
        return URL(string: link)!
    }

    func getThumbnailUrl() -> URL {
        return URL(string: image)!
    }
}
