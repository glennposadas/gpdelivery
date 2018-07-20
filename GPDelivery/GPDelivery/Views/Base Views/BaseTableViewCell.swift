//
//  BaseTableViewCell.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var identifier: String! {
        get {
            return "\(self.typeName(self))"
        }
    }
    
    // MARK: - Functions
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 50.0, bottom: 0, right: 0)
        self.backgroundColor = .white
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

