//
//  DeliveryTableViewCell.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

class DeliveryTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    
    private lazy var imageView_DeliveryImage: UIImageView = {
        let imageView = UIImageView(image: .placeholder)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var label_DeliveryTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    private lazy var label_DeliveryAddress: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    // MARK: - Functions
    
    public func setupCell(_ deliveryViewModel: DeliveryViewModel) {
        self.label_DeliveryTitle.text = deliveryViewModel.deliveryTitle
        self.label_DeliveryAddress.text = deliveryViewModel.deliveryAddress
    
        if let resource = deliveryViewModel.imageResource {
            self.imageView_DeliveryImage.kf.setImage(with: resource, placeholder: UIImage.placeholder, options: [.transition(.fade(0.2)), .cacheOriginalImage])
        }
    }
    
    // MARK: Overrides
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        
        self.addSubview(self.imageView_DeliveryImage)
        self.imageView_DeliveryImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(40.0)
            make.top.bottom.leading.equalToSuperview().inset(10.0)
        }
        
        self.addSubview(self.label_DeliveryTitle)
        self.label_DeliveryTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView_DeliveryImage).offset(5.0)
            make.leading.equalTo(self.imageView_DeliveryImage.snp.trailing).offset(10.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        self.addSubview(self.label_DeliveryAddress)
        self.label_DeliveryAddress.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.label_DeliveryTitle)
            make.top.equalTo(self.label_DeliveryTitle.snp.bottom).offset(5.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
