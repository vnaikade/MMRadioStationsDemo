//
//  StationsViewController.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//
import Foundation
import UIKit

class StationsViewController: BaseViewController {

    // MARK: - Properties
    var viewModel: StationsViewModel!
    var tableView: UITableView!
    var loader: UIActivityIndicatorView!
    var noDataFoundLabel: UILabel!
    let noStationsFoundText = "No stations to display."
    
    // MARK: - Private Methods
    private func intializeNoDataFoundLabel() {
        noDataFoundLabel = UILabel()
        noDataFoundLabel.text = noStationsFoundText
        noDataFoundLabel.isHidden = true
        view.addSubview(noDataFoundLabel)
        noDataFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = noDataFoundLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        let verticalConstraint = noDataFoundLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    private func initializeTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = tableView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = tableView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let topConstraint = tableView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let bottomConstraint = tableView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initializeLoader() {
        loader = UIActivityIndicatorView()
        loader.style = .medium
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        let verticalConstraint = loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    private func initialize() {
        initializeTableView()
        initializeLoader()
        intializeNoDataFoundLabel()
        getStations()
    }
    
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.stopAnimating()
            let radioStationsToDisplay = self?.viewModel.totalRadioStations()
            self?.noDataFoundLabel.isHidden = radioStationsToDisplay ?? 0 > 0
            self?.tableView.reloadData()
        }
    }
    
    private func parseXML(data: Data) {
        XMLHelper().parseData(data: data) { [weak self] (parsedData) in
            self?.viewModel.updateRadioStations(stations: parsedData.map { RadioStation(details: $0) })
            self?.reloadTable()
        }
    }
    
    private func getStations() {
        guard let urlString = viewModel.url else {
            return
        }
        loader.startAnimating()
        NetworkManager.shared.getStations(urlString: urlString) { [weak self] (data) in
            if let stationsData = data {
                self?.parseXML(data: stationsData)
            }
        }
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stations"
        initialize()
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource Methods
extension StationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalRadioStations()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: StationsTableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: StationsTableViewCell.identifier) as? StationsTableViewCell {
            cell = reusedCell
        } else {
            cell = StationsTableViewCell(style: .subtitle, reuseIdentifier: StationsTableViewCell.identifier)
        }
        let stationInfo = viewModel.getRadionStation(for: indexPath.row)
        let logo = viewModel.isLogoImageAvailable(for: indexPath)
        cell.setup(radioStationInfo: stationInfo, logo: logo, indexPath: indexPath) { [weak self] (logoData, indexPathForDownloadedLogo) in
            self?.viewModel.updateStationLogo(for: indexPathForDownloadedLogo, data: logoData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
