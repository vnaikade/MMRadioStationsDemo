//
//  XMLHelper.swift
//  MMRadioStationsDemo
//
//  Created by Vinay Naikade on 31/12/21.
//

import Foundation

class XMLHelper: NSObject {
    
    // MARK: - Properties
    let itemKey = "Item"
    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var completionHandler: ((_ parsedData: [[String: Any]]) -> Void)?
    
    // MARK: - Private Methods
    private func reset() {
        xmlDict = [:]
        xmlDictArr = []
        currentElement = ""
    }
    
    // MARK: - Public Methods
    func parseData(data: Data, completion: ((_ parsedData: [[String: Any]]) -> Void)?) {
        reset()
        completionHandler = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
}

// MARK: - XMLParserDelegate Methods
extension XMLHelper: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == itemKey {
            xmlDict = [:]
        } else {
            currentElement = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if xmlDict[currentElement] == nil {
                   xmlDict.updateValue(string, forKey: currentElement)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == itemKey {
            xmlDictArr.append(xmlDict)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completionHandler?(xmlDictArr)
    }
}
