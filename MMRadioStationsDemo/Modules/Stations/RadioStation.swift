//
//  RadioStation.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation

struct RadioStation {
    
    // MARK: - Properties
    var stationID: String
    var stationName: String
    var stationLogo: String
    var logoDada: Data?
    
    // MARK: - Life Cycle Methods
    init(details: [String:Any]) {
        stationID = details["StationId"] as? String ?? ""
        stationName = details["StationName"] as? String ?? ""
        stationLogo = details["Logo"] as? String ?? ""
    }
}
