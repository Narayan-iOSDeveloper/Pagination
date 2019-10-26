//
//  Services.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//

import Foundation
import Foundation
class Services : Gettable {
    
    var page : Int?
    
    let downloader = JSONDownloader()
    typealias CurrentCompletionHandler = (Result<UserModel>) -> ()
    
    func getUserList(page : Int? ,completion : @escaping (_ result: UserModel?) -> Void){
        
        self.page = page
        
        get { (result) in
            switch result{
            case .Success(let appStores) :
                completion(appStores)
            case .Error(let error) :
                print(error)
                // AlertView.showWarningTost("Unable to get user accounts")
            }
        }
    }
    func get(completion: @escaping CurrentCompletionHandler) {
        
        let urlSting = "https://reqres.in/api/users?page=\(self.page ?? 0)"
        print(urlSting)
        guard let url = URL(string: urlSting) else {
            completion(.Error(.invalidURL))
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
        
        if Reachability.isConnectedToNetwork(){
            
            let task = downloader.jsonTask(withLoading: true , request: request) { (result) in
                
                DispatchQueue.main.async {
                    
                    switch result {
                    case .Error(let error):
                        completion(.Error(error))
                        return
                    case .Success(let json):
                        guard let resultJson = json as? Dictionary<String,Any> else{
                            completion(.Error(.jsonParsingFailure))
                            return
                        }
                        print(resultJson)

                        
                        if let cateList = resultJson as? Dictionary<String,Any>{
                            let cateListss  = UserModel(dictionary: cateList)
                            completion(.Success(cateListss))
                        }
               
                        
                        
                    }
                }
                
            }
            task.resume()
        }else{
            // Network is not Reachable
            //AlertView.showErrorTost("Network is not Reachable")
            completion(.Error(.networkNotAvailable))
        }
    }
}

protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}
