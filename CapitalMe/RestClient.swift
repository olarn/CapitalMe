//
//  RestClient.swift
//  CapitalMe
//
//  Created by Olarn U. on 5/28/2559 BE.
//  Copyright © 2559 Olarn U. All rights reserved.
//

import Foundation
import Alamofire

class RestClient {
    
    func request(
        url: String,
        onFail:(error: NSError) -> Void,
        onSuccess:(data: NSData?) -> Void)
    {
        Alamofire
            .request(.GET, url)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        onSuccess(data: value)
                    } else {
                        onSuccess(data: nil)
                    }
                case .Failure(let error):
                    onFail(error: error)
                }
        }
    }
}