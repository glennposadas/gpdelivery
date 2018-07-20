//
//  DeliveriesViewController+SetupViews.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import SnapKit
import UIKit

extension DeliveriesViewController {
    internal func setupViews() {
        self.title = "My Deliveries"
        
        self.tableView.addSubview(self.refreshControl)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
