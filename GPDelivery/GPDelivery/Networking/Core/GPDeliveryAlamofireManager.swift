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
    
    /**
     * Ref: https://nshipster.com/nsurlcache/
     * Moya does not respect requestCachePolicy.
     * We'll implement this instead: https://stackoverflow.com/a/50728333/3231194
     */
    static let shared: GPDeliveryAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        // configuration.requestCachePolicy = .returnCacheDataElseLoad
        return GPDeliveryAlamofireManager(configuration: configuration)
    }()
}
