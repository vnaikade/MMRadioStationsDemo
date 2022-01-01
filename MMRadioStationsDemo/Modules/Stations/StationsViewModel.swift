//
//  StationsViewModel.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation

struct StationsViewModel {
    
    // MARK: - Properties
    var url: String?
    private var stations: [RadioStation] = []
    private var stationLogos: [IndexPath: Data] = [:]
    
    // MARK: - Life Cycle Methods
    init(staionsUrl: String?) {
        url = staionsUrl
    }
    
    // MARK: - Public Methods
    mutating func updateRadioStations(stations: [RadioStation]) {
        self.stations = stations
        if let firstIndex = self.stations.firstIndex(where: { station in
            return station.stationID.isEmpty
        }) {
            self.stations.remove(at: firstIndex)
        }
    }
    
    func totalRadioStations() -> Int {
        return stations.count
    }
    
    func getRadionStation(for row: Int) -> RadioStation {
        return stations[row]
    }
    
    mutating func updateStationLogo(for indexPath: IndexPath, data: Data?) {
        stationLogos[indexPath] = data
    }
    
    func isLogoImageAvailable(for indexPath: IndexPath) -> Data? {
        return stationLogos[indexPath]
    }
}
