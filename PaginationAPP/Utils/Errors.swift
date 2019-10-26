//
//  Errors.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//


import Foundation

enum SerializationError : Error{
    
    case missing(String)
    case invalid(String, Any)
    
    
    func associatedValue() -> String {
        
        switch self {
        case let .missing(parameter):
            return self.missingParam(parameter)
        default:
            
            break
        }
        return self.missingParam(self.localizedDescription)
    }
    
    private func missingParam(_ param : String)-> String{
        return param + "is missing"
    }
}


enum ApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
    case networkNotAvailable
    case loginFailure
}
