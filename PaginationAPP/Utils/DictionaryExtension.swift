//
//  DictionaryExtension.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//


import Foundation
import SystemConfiguration
import UIKit
extension Dictionary where Key == String{
    
    func getIntValueForKey(_ key : String)->Int{
        var value = 0
        
        if self[key] is String{
            if let val = self[key] as? String{
                value = Int(val) ?? 0
                return value
            }
        }
        
        if let val = self[key] as? Int{
            value = val
        }
        return value
    }
    func getStringValueForKey(_ key : String)-> String{
        var value = ""
        if let val = self[key] as? String{
            value = val
        }else{
            if let val = self[key] as? Int{
                return String(val)
            }else{
                if let val = self[key] as? Double{
                    return String(val)
                }
            }
        }
        return value
    }

    
}
