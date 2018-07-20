//
//  CachePolicyPlugin.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import EFInternetIndicator
import Moya

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            let reachability = Reachability()!
            print("Reachbility Connection: \(reachability.connection)")
            mutableRequest.cachePolicy = reachability.connection == .none ? .returnCacheDataElseLoad : cachePolicyGettable.cachePolicy
            
            mutableRequest.timeoutInterval = 10
            
            return mutableRequest
        }
        
        return request
    }
}
