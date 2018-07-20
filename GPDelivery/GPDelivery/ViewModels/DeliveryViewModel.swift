//
//  DeliveryViewModel.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import CoreLocation
import Kingfisher

struct DeliveryViewModel {
    
    // MARK: - Properties
    
    var deliveryTitle: String
    var deliveryAddress: String
    var coordinates: CLLocationCoordinate2D?
    var imageResource: ImageResource?
    
    // MARK: - Functions
    
    init(_ delivery: Delivery) {
        self.deliveryTitle = delivery.descriptionValue ?? ""
        self.deliveryAddress = delivery.location?.address ?? ""
        
        if let latitude = delivery.location?.lat,
            let longitude = delivery.location?.lng {
            self.coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        }
        
        if let urlString = delivery.imageUrl,
            let url = URL(string: urlString) {
            self.imageResource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        }
    }
}
