//
//  RadioStation.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation

struct RadioStation {
    
    var stationID: String
    var stationName: String
    var stationLogo: String
    var logoDada: Data?
    
    init(details: [String:Any]) {
        stationID = details["StationId"] as? String ?? ""
        stationName = details["StationName"] as? String ?? ""
        stationLogo = details["Logo"] as? String ?? ""
    }
}
