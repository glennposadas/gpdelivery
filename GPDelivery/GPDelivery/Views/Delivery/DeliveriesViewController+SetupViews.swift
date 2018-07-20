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
        
        self.addLoadingView()
        self.addBrokenRobot()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func addLoadingView() {
        let label_Message = UILabel()
        label_Message.text = "Please wait..."
        label_Message.textColor = .graySubtitle
        label_Message.font = UIFont.systemFont(ofSize: 14.0)
        label_Message.textAlignment = .center
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .darkBlue
        activityIndicator.startAnimating()
        
        self.view.addSubview(self.view_LoadingContainer)
        self.view_LoadingContainer.snp.makeConstraints { (make) in
            make.height.equalTo(50.0)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        // Subviews of the container
        
        self.view_LoadingContainer.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.view_LoadingContainer.addSubview(label_Message)
        label_Message.snp.makeConstraints { (make) in
            make.top.equalTo(activityIndicator.snp.bottom).offset(15.0)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func addBrokenRobot() {
        let imageView_BrokenRobot = UIImageView(image: .brokenRobot)
        imageView_BrokenRobot.contentMode = .scaleAspectFit
        
        let button_Refresh = UIButton(type: .custom)
        button_Refresh.setTitle("Let's try again!", for: .normal)
        button_Refresh.setTitleColor(.darkBlue, for: .normal)
        button_Refresh.setTitleColor(.graySubtitle, for: .highlighted)
        button_Refresh.addTarget(self, action: #selector(self.getDeliveries), for: .touchUpInside)
        
        let label_Message = UILabel()
        label_Message.text = "Oh no! Looks like there has been an error. It's not you, it's us."
        label_Message.textColor = .graySubtitle
        label_Message.font = UIFont.systemFont(ofSize: 14.0)
        label_Message.numberOfLines = 0
        label_Message.textAlignment = .center
        
        self.view.addSubview(self.view_RobotContainer)
        self.view_RobotContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10.0)
            make.centerY.equalToSuperview()
        }
        
        // Adding now the subviews of the container.
        
        self.view_RobotContainer.addSubview(imageView_BrokenRobot)
        imageView_BrokenRobot.snp.makeConstraints { (make) in
            make.width.equalTo(280.0)
            make.height.equalTo(330.0)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.view_RobotContainer.addSubview(label_Message)
        label_Message.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15.0)
            make.top.equalTo(imageView_BrokenRobot.snp.bottom).offset(15.0)
        }
        
        self.view_RobotContainer.addSubview(button_Refresh)
        button_Refresh.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(50.0)
            make.top.equalTo(label_Message.snp.bottom).offset(15.0)
            make.bottom.equalToSuperview().inset(30.0)
        }
    }
}




