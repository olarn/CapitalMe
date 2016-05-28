//
//  CapitalRequestController.swift
//  CapitalMe
//
//  Created by Olarn U. on 5/22/2559 BE.
//  Copyright © 2559 Olarn U. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CapitalRequestController {
    
    func request(
        capitalName: String,
        onFail:(error: NSError) -> Void,
        onSuccess:(info: CapitalInfo?) -> Void)
    {
        Alamofire.request(.GET, "https://server/capital/\(capitalName)")
            .validate()
            .responseJSON { (response) in
                print(response.result.value)
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let info = CapitalInfo()
                        info.countryCode = json[0]["alpha2Code"].stringValue
                        info.countryName = json[0]["name"].stringValue
                        info.population = json[0]["population"].stringValue
                        info.latLong = "\(json[0]["latlng"][0].stringValue),\(json[0]["latlng"][1].stringValue)"
                        onSuccess(info: info)
                    } else {
                        onSuccess(info: nil)
                    }
                case .Failure(let error):
                    onFail(error: error)
                }
        }
    }
}