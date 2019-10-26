
//  JSONDownloader.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//



import Foundation
import UIKit

struct JSONDownloader {
    
    //1 creating the session
    let session: URLSession
    //let loadingOverlay = LoadingOverlay.shared

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (Result<Any>) -> ()
    
    func jsonTask(withLoading : Bool , request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        if withLoading{
           // self.loadingOverlay.showOverlay(view: (UIApplication.shared.keyWindow!))
        }
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
              //  AlertView.showErrorTost((error?.localizedDescription)!)
              //  self.loadingOverlay.hideOverlayView()
                completion(.Error(.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                
                //self.loadingOverlay.hideOverlayView()
                if let data = data {
                    do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                            DispatchQueue.main.async {
                                
                                if let jsonDic = json as? Dictionary<String,Any>{
                                    if let msg = jsonDic["msg"] as? String{
                                    }
                                     completion(.Success(json))
                                }
                              
                            }
                    } catch {
                        
                        print(String(data: data, encoding: .utf8))
                        //AlertView.showErrorTost("Unable to connect to the server")
                    }
                } else {
                    completion(.Error(.invalidData))
                }
            } else {
               // self.loadingOverlay.hideOverlayView()
                completion(.Error(.responseUnsuccessful))
                print("\(httpResponse)")
                completion(.Error(.invalidData))
            }
        }
        return task
    }
func convertToDictionary(from text: String) throws -> [String: String] {
        guard let data = text.data(using: .utf8) else { return [:] }
        let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: String] ?? [:]
    }
}

enum Result <T>{
    case Success(T)
    case Error(ApiError)
}


