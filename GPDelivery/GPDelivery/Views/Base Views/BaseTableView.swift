//
//  BaseTableView.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    // MARK: - Properties
    
    var _backgroundColor: UIColor?
    
    override var backgroundColor: UIColor? {
        didSet {
            _backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Functions
    // MARK: Overrides
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        // Add some more configurations here...
        
        self.estimatedRowHeight = 50.0
        self.rowHeight = UITableViewAutomaticDimension
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        
        // Register custom cells.
        
        backgroundColor = _backgroundColor
        
        // Register cells.
        
        self.register(BaseTableViewCell.self, forCellReuseIdentifier: BaseTableViewCell().identifier)
        self.register(DeliveryTableViewCell.self, forCellReuseIdentifier: DeliveryTableViewCell().identifier)
        
        // Set the footer and header to remove extra blank lines
        
        let transluscentView = UIView()
        transluscentView.backgroundColor = .clear
        
        self.tableHeaderView = transluscentView
        self.tableFooterView = transluscentView
        
        // Few more setups
        self.keyboardDismissMode = .interactive
        
        super.didMoveToWindow()
    }
}


