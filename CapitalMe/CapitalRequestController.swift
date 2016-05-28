//
//  CapitalRequestController.swift
//  CapitalMe
//
//  Created by Olarn U. on 5/22/2559 BE.
//  Copyright © 2559 Olarn U. All rights reserved.
//

import Foundation
import SwiftyJSON

class CapitalRequestController {
    
    private var client: RestClient!
    
    init(client: RestClient) {
        self.client = client
    }
    
    func request(
        capitalName: String,
        onFail:(error: NSError) -> Void,
        onSuccess:(info: CapitalInfo?) -> Void)
    {
        client.request(
            "https://server/capital/\(capitalName)",
            onFail: { (error) in
                onFail(error: error)
            }) { (data) in
                if data == nil {
                    onSuccess(info: nil)
                } else {
                    let json = JSON(data: data!)
                    let info = CapitalInfo()
                    info.countryCode = json[0]["alpha2Code"].stringValue
                    info.countryName = json[0]["name"].stringValue
                    info.population = json[0]["population"].stringValue
                    let lat = json[0]["latlng"][0].stringValue
                    let lon = json[0]["latlng"][1].stringValue
                    info.latLong = "\(lat), \(lon)"
                    onSuccess(info: info)
                }
        }
    }
}