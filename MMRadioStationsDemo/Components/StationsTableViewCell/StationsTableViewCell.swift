//
//  StationsTableViewCell.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import UIKit

class StationsTableViewCell: UITableViewCell {

    static let identifier: String = "StationsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(radioStationInfo: RadioStation, logo: Data?, indexPath: IndexPath, completion: ((_ data: Data?, _ indexPath: IndexPath) -> Void)?) {
        if let logoImageData = logo {
            imageView?.image = UIImage(data: logoImageData)
        } else {
            imageView?.image = UIImage(named: "placeholder")
            NetworkManager.shared.downloadImage(from: radioStationInfo.stationLogo) { [weak self] imageData in
                if let data = imageData {
                    DispatchQueue.main.async {
                        self?.imageView?.image = UIImage(data: data)
                    }
                    completion?(data, indexPath)
                } else {
                    completion?(nil, indexPath)
                }
            }
        }
        textLabel?.text = radioStationInfo.stationName
        detailTextLabel?.text = radioStationInfo.stationID
    }
}
