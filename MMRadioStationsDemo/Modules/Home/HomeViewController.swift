//
//  HomeViewController.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    // MARK:- Properties
    var defaultUrlButton: Button?
    var submitButton: Button?
    var textField: UITextField?
    private var viewModel = HomeViewModel()
    
    // MARK:- Private Methods
    private func initializeTextField() {
        let leftPadding: CGFloat = 20.0
        textField = UITextField()
        textField?.borderStyle = .roundedRect
        textField?.delegate = self
        textField?.placeholder = "Please Enter URL"
        view.addSubview(textField!)
        textField?.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = textField!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leftPadding)
        let trailingConstraint = textField!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: leftPadding * -1.0)
        let bottomConstraint = textField!.bottomAnchor.constraint(equalTo: submitButton!.topAnchor, constant: -60.0)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint])
    }
    
    private func initializeDefaultUrlButton() {
        defaultUrlButton = Button()
        defaultUrlButton?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(defaultUrlButton!)
        let trailingConstraint = defaultUrlButton!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
        let topConstraint = defaultUrlButton!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0)
        NSLayoutConstraint.activate([trailingConstraint, topConstraint])
        defaultUrlButton?.setTitle("Use default Url", textColor: .blue, font: UIFont.systemFont(ofSize: 16.0), backgroundColor: .white)
        defaultUrlButton?.addTarget(self, action: #selector(defaultButtonAction), for: .touchUpInside)
    }
    
    private func initializeSubmitButton() {
        submitButton = Button()
        view.addSubview(submitButton!)
        submitButton?.setup(superView: view)
        submitButton?.setTitle("Submit", textColor: .white, font: UIFont.boldSystemFont(ofSize: 16.0), backgroundColor: .black)
        submitButton?.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
    }
    
    private func initialize() {
        title = "Home"
        initializeDefaultUrlButton()
        initializeSubmitButton()
        initializeTextField()
    }
    
    private func navigateToStations() {
        let stationsViewController = StationsViewController()
        stationsViewController.viewModel = StationsViewModel(staionsUrl: viewModel.getStationUrl())
        navigationController?.pushViewController(stationsViewController, animated: true)
    }
    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @objc func defaultButtonAction() {
        textField?.text = defaultUrl
        viewModel.setStationUrl(urlString: defaultUrl)
    }
    
    @objc func submitButtonAction() {
        view.endEditing(true)
        guard let stationUrl = viewModel.getStationUrl(), !stationUrl.isEmpty else {
            showAlert(message: "URL can not be empty", cancelButtonTitle: AlertButtonTitles.ok.rawValue, cancelButtonAction: nil, otherButtonTitle: "", otherButtonAction: nil)
            return
        }
        navigateToStations()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            viewModel.setStationUrl(urlString: updatedText)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.setStationUrl(urlString: textField.text)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
