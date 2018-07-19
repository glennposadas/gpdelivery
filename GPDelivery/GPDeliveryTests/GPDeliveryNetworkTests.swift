//
//  GPDeliveryNetworkTests.swift
//  GPDeliveryTests
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import SwiftyJSON
import XCTest
@testable import GPDelivery

class GPDeliveryNetworkTests: XCTestCase {
    
    func testGetDeliveries() {
        let exp = expectation(description: "SomeService does stuff and runs the callback closure")
        
        deliveryServiceProvider.request(.getDeliveries()) { (result) in
            switch result {
            case let .success(moyaResponse):
                let jsonArray = JSON(moyaResponse.data).arrayValue
                _ = jsonArray.map { Delivery(json: $0) }
                
                XCTAssertNotNil(jsonArray)
                
            case let .failure(error):
                XCTAssertNil(error)
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
