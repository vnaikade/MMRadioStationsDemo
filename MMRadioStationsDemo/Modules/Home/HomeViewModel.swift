//
//  HomeViewModel.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation

let defaultUrl = "http://phorus.vtuner.com/setupapp/phorus/asp/browsexml/navXML.asp?gofile=LocationLevelFourCityUS-North%20America-New%20York-ExtraDir-1-Inner-14&bkLvl=9237&mac=a8f58cd9758b710c43a7a63762e755947f83f0ad9194aa294bbaee55e0509e02&dlang=eng&fver=1.4.4.2299%20(20150604)&hw=CAP:%201.4.0.075%20MCU:%201.032%20BT:%200.002"

struct HomeViewModel {
    
    private var stationUrl: String?
    
    mutating func setStationUrl(urlString: String?) {
        stationUrl = urlString
    }
    
    func getStationUrl() -> String? {
        return stationUrl
    }
}
