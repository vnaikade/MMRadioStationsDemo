//
//  BaseViewController.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import UIKit

enum AlertButtonTitles: String {
    case ok = "Okay"
    case cancel = "Cancel"
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
    }

    func showAlert(title: String = "Error", message: String, cancelButtonTitle: String, cancelButtonAction:(() -> Void)?, otherButtonTitle: String, otherButtonAction:(() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if !otherButtonTitle.isEmpty {
            let otherButtonAlertAction = UIAlertAction(title: otherButtonTitle, style: UIAlertAction.Style.default) { (alertAction) in
                if let action = otherButtonAction {
                    action()
                }
            }
            alertController.addAction(otherButtonAlertAction)
        }
        if !cancelButtonTitle.isEmpty {
            let cancelButtonAlertAction = UIAlertAction(title: cancelButtonTitle, style: UIAlertAction.Style.default) { (alertAction) in
                if let action = cancelButtonAction {
                    action()
                }
            }
            alertController.addAction(cancelButtonAlertAction)
        }
        present(alertController, animated: false, completion: nil)
    }
}

