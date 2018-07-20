//
//  DeliveriesViewController.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import SwiftyJSON
import UIKit

class DeliveriesViewController: BaseViewController {

    // MARK: - Properties
    
    private lazy var deliveryCell: DeliveryTableViewCell = {
        return DeliveryTableViewCell(
            style: .default,
            reuseIdentifier: DeliveryTableViewCell().identifier
        )
    }()
    
    internal lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Data Properties
    
    private var deliveryViewModels = [DeliveryViewModel]()
    
    // MARK: - Functions
    // MARK: Navigations
    
    private func showDeliveryDetails(_ deliveryViewModel: DeliveryViewModel) {
        
    }
    
    // MARK: Network Calls
    
    private func getDeliveries() {
        deliveryServiceProvider.request(.getDeliveries()) { (result) in
            switch result {
            case let .success(moyaResponse):
                let jsonObj = JSON(moyaResponse.data)
                if let jsonObjArray = jsonObj.array {
                    self.deliveryViewModels = jsonObjArray.map { DeliveryViewModel(Delivery(json: $0)) }
                    self.tableView.reloadData()
                }
                
            case let .failure(error):
                // Show error, or custom error...
                self.showAlert(title: "GPDelivery", message: "Error: \(error.localizedDescription)", okayButtonTitle: "OK", withBlock: nil)
            }
        }
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.getDeliveries()
    }
}

// MARK: - UITableViewDelegate

extension DeliveriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension DeliveriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deliveryViewModel = self.deliveryViewModels[indexPath.row]
        self.deliveryCell = tableView.dequeueReusableCell(withIdentifier: self.deliveryCell.identifier) as! DeliveryTableViewCell
        self.deliveryCell.setupCell(deliveryViewModel)
        return self.deliveryCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveryViewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
