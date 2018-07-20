//
//  DeliveryDetailsViewController.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Kingfisher
import MapKit
import Moya
import SwiftyJSON
import UIKit

class DeliveryDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    internal lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.showsUserLocation = false
        return map
    }()
    
    internal lazy var toolbar_DetailsContainer: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isTranslucent = true
        return toolbar
    }()

    internal lazy var imageView_DeliveryImage: UIImageView = {
        let imageView = UIImageView(image: .placeholder)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    internal lazy var label_DeliveryTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 2
        return label
    }()
    
    internal lazy var label_DeliveryAddress: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 2
        return label
    }()

    // MARK: Data Properties
    
    public var deliveryViewModel: DeliveryViewModel! {
        didSet {
            self.label_DeliveryTitle.text = deliveryViewModel.deliveryTitle
            self.label_DeliveryAddress.text = deliveryViewModel.deliveryAddress
            
            if let resource = deliveryViewModel.imageResource {
                self.imageView_DeliveryImage.kf.setImage(with: resource, placeholder: UIImage.placeholder, options: [.transition(.fade(0.2)), .cacheOriginalImage])
            }
            
            if let coordinate = deliveryViewModel.coordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                self.mapView.addAnnotation(annotation)
                
                let regionRadius: CLLocationDistance = 1000
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius, regionRadius)
                self.mapView.setRegion(coordinateRegion, animated: true)
            }
        }
    }
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
}

// MARK: - MKMapViewDelegate

extension DeliveryDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinIdentifier = "deliveryPin"
        var pin: MKPinAnnotationView
        
        if let dequeuedPin = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier) as? MKPinAnnotationView {
            dequeuedPin.annotation = annotation
            pin = dequeuedPin
        } else {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
        }
        
        return pin
    }
}
