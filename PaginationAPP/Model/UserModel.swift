//
//  UserModel.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//

import Foundation
class UserModel {
    
    var page : Int?
    var per_page : Int?
    var total_pages : Int?
    var dataArray : [MainDataArray]?
    
    init(dictionary : Dictionary<String, Any>){
        page = dictionary.getIntValueForKey("page")
        per_page = dictionary.getIntValueForKey("per_page")
        total_pages = dictionary.getIntValueForKey("total_pages")
        
        if let dict = dictionary["data"] as? Array<Dictionary<String,Any>> {
            self.dataArray = dict.map{MainDataArray(dictionary: $0)}
        }
    }
}

class MainDataArray{
    
    var id : String?
    var email : String?
    var first_name : String?
    var last_name : String?
    var avatar : String?
    
    init(dictionary : Dictionary<String,Any>) {
        self.id = dictionary.getStringValueForKey("id")
        self.email = dictionary.getStringValueForKey("email")
        self.first_name = dictionary.getStringValueForKey("first_name")
        self.last_name = dictionary.getStringValueForKey("last_name")
        self.avatar = dictionary.getStringValueForKey("avatar")
    }
}




