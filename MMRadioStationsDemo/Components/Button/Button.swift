//
//  Button.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import UIKit

class Button: UIButton {
    
    // MARK: - Properties
    var buttonWidth: CGFloat = 200.0
    var buttonHeight: CGFloat = 44.0
    var buttonTitle = "Submit"
    
    // MARK: - Public Methods
    func setup(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.centerXAnchor.constraint(equalTo: superView.centerXAnchor)
        let verticalConstraint = self.centerYAnchor.constraint(equalTo: superView.centerYAnchor)
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: buttonWidth)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: buttonHeight)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func setTitle(_ title: String, textColor: UIColor, font: UIFont, backgroundColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        titleLabel?.font = font
        self.backgroundColor = backgroundColor
    }
}
