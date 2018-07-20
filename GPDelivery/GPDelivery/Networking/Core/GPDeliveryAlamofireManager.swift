//
//  GPDeliveryAlamofireManager.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Alamofire
import Foundation

class GPDeliveryAlamofireManager: Alamofire.SessionManager {
    
    static let shared: GPDeliveryAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return GPDeliveryAlamofireManager(configuration: configuration)
    }()
}
