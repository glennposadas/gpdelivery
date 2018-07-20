//
//  BaseViewController.swift
//  GPDelivery
//
//  Created by Glenn Von C. Posadas on 19/07/2018.
//  Copyright © 2018 Glenn Von C. Posadas. All rights reserved.
//

import EFInternetIndicator
import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    
    public typealias GPDeliveryAlertCallBack = (_ userDidTapOk: Bool) -> Void
    
    public var internetConnectionIndicator: InternetViewIndicator?
    
    // MARK: - Functions
    
    func showAlert(
        title: String,
        message: String? = nil,
        okayButtonTitle: String,
        cancelButtonTitle: String? = nil,
        withBlock completion: GPDeliveryAlertCallBack?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okayButtonTitle, style: .default) { _ in
            completion?(true)
        }
        alertController.addAction(okAction)
        
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default) { _ in
                completion?(false)
            }
            alertController.addAction(cancelAction)
        }
        
        alertController.view.tintColor = .black
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add some more common configurations here...
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .darkBlue
        self.navigationController?.navigationBar.backItem?.title = ""
        
        // For reachability
        // Change the remoteHostName if necessary...
        // Suppose the mock api is on a real server...
        
        self.startMonitoringInternet(
            backgroundColor: .darkBlue,
            style: .statusLine,
            textColor: .white,
            message: "Oops! Please check your internet connection! 🤦‍♂️",
            remoteHostName: "google.com"
        )
    }
}

// MARK: - InternetStatusIndicable

extension BaseViewController: InternetStatusIndicable {
    
}





