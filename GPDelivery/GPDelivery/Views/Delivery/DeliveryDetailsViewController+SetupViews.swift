//
//  DeliveryDetailsViewController+SetupViews.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 20/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import SnapKit
import UIKit

extension DeliveryDetailsViewController {
    internal func setupViews() {
        self.title = "Delivery Details"
        
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(self.toolbar_DetailsContainer)
        self.toolbar_DetailsContainer.snp.makeConstraints { (make) in
            make.height.equalTo(80.0)
            make.leading.trailing.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                make.bottom.equalToSuperview()
            }
        }
        
        // Subviews of details container...
        
        self.toolbar_DetailsContainer.addSubview(self.imageView_DeliveryImage)
        self.imageView_DeliveryImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(50.0)
            if #available(iOS 11.0, *) {
                make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leadingMargin).offset(15.0)
            } else {
                make.leading.equalToSuperview().inset(15.0)
            }
            make.centerY.equalToSuperview()
        }
        
        self.toolbar_DetailsContainer.addSubview(self.label_DeliveryTitle)
        self.label_DeliveryTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView_DeliveryImage)
            make.leading.equalTo(self.imageView_DeliveryImage.snp.trailing).offset(15.0)
            make.trailing.equalToSuperview().inset(15.0)
        }
        
        self.toolbar_DetailsContainer.addSubview(self.label_DeliveryAddress)
        self.label_DeliveryAddress.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.label_DeliveryTitle)
            make.top.equalTo(self.label_DeliveryTitle.snp.bottom).offset(5.0)
        }
    }
}
