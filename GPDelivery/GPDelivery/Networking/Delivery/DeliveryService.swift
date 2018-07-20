//
//  DeliveryService.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Alamofire
import Moya
import SwiftyJSON

let deliveryServiceProvider = MoyaProvider<DeliveryService>(manager: GPDeliveryAlamofireManager.shared)

enum DeliveryService {
    case getDeliveries()
}

// MARK: - TargetType Protocol Implementationm

extension DeliveryService: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .getDeliveries: return "/deliveries"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDeliveries: return .get
        }
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "")!
    }
    
    var task: Task {
        switch self {
        case .getDeliveries: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
}





