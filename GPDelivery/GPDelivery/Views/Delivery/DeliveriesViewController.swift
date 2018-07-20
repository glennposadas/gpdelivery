//
//  DeliveriesViewController.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import Moya
import SnapKit
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
    
    internal lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self, action:
            #selector(self.getDeliveries),
            for: UIControlEvents.valueChanged
        )
        refreshControl.tintColor = .darkBlue
        return refreshControl
    }()
    
    internal lazy var view_RobotContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    internal lazy var view_LoadingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    // MARK: Data Properties
    
    private var deliveryViewModels = [DeliveryViewModel]()
    internal var constraint_ImageViewRobotHeight: Constraint?
    
    // MARK: - Functions
    // MARK: Navigations
    
    private func showDeliveryDetails(_ deliveryViewModel: DeliveryViewModel) {
        let deliveryDetailsController = DeliveryDetailsViewController()
        deliveryDetailsController.deliveryViewModel = deliveryViewModel
        self.navigationController?.pushViewController(deliveryDetailsController, animated: true)
    }
    
    // MARK: Network Calls
    
    @objc internal func getDeliveries() {
        /** Flow:
         *  500 (internal server error) - Show up the broken robot design.
         *  200 - Show the new data.
         *  1001, 504/Timeout/Other http code, perhaps - No server or timeout, load up the cached data.
         */
        
        // TODO: Improve toggling of views' visibility.
        
        self.view_LoadingContainer.isHidden = false
        self.tableView.isHidden = true
        self.view_RobotContainer.isHidden = true
        
        deliveryServiceProvider.request(.getDeliveries()) { (result) in
            switch result {
            case let .success(moyaResponse):
                if moyaResponse.statusCode == 200 {
                    let jsonObj = JSON(moyaResponse.data)
                    if let jsonObjArray = jsonObj.array {
                        self.deliveryViewModels = jsonObjArray.map { DeliveryViewModel(Delivery(json: $0)) }
                        self.refreshControl.endRefreshing()
                        self.tableView.reloadData()
                        
                        self.view_LoadingContainer.isHidden = true
                        self.tableView.isHidden = false
                        self.view_RobotContainer.isHidden = true
                    }
                } else if moyaResponse.statusCode == 500 {
                    self.showFailure()
                }
                
            case .failure: self.showFailure()
            }
        }
    }
    
    private func showFailure() {
        self.view_LoadingContainer.isHidden = true
        self.tableView.isHidden = true
        UIView.transition(with: self.view_RobotContainer, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view_RobotContainer.isHidden = false
        })
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.getDeliveries()
    }
    
    /** Handle orientation changes.
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        var newHeight: CGFloat = 0
        let isPad = UIDevice.current.model.hasPrefix("iPad")
        
        if UIDevice.current.orientation.isLandscape {
            newHeight = isPad ? 350.0 : 220.0
            newHeight = UIScreen.main.bounds.height == 568.0 ? 150.0 : newHeight
        } else {
            newHeight = isPad ? 550.0 : 330.0
        }
        
        self.constraint_ImageViewRobotHeight?.update(offset: newHeight)
        self.view.layoutIfNeeded()
    }

}

// MARK: - UITableViewDelegate

extension DeliveriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedViewModel = self.deliveryViewModels[indexPath.row]
        self.showDeliveryDetails(selectedViewModel)
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
