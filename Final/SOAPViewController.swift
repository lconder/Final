//
//  SOAPViewController.swift
//  Final
//
//  Created by Luis Conde on 31/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import Alamofire

import SWXMLHash
import StringExtensionHTML
import AEXML

class SOAPViewController: UIViewController {
    
    @IBOutlet var serviceDescription: UILabel!
    @IBOutlet var packageType: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var originName: UILabel!
    @IBOutlet var pickupDateTime: UILabel!
    @IBOutlet var destinationName: UILabel!
    @IBOutlet var deliveryDateTime: UILabel!
    @IBOutlet var receiverName: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedRequest(_ sender: UIButton) {
        
        self.getData()
        
    }
    
    
    func getData(){
        
        print("getdata")
    
        let soapRequest = AEXMLDocument()
        
        let envelopeAttributes = ["xmlns:soapenv" : "http://schemas.xmlsoap.org/soap/envelope/",
                                  "xmlns:est":"http://www.estafeta.com/"]
        
        let act : AEXMLElement = AEXMLElement(name: "est:ExecuteQuery", value: "")
        let suscriberId : AEXMLElement = AEXMLElement(name: "est:suscriberId", value: "25")
        let login : AEXMLElement = AEXMLElement(name: "est:login", value: "Usuario1")
        let password : AEXMLElement = AEXMLElement(name: "est:password", value: "1GCvGIu$")
        
        act.addChild(suscriberId)
        act.addChild(login)
        act.addChild(password)
        
        let searchType : AEXMLElement = AEXMLElement(name: "est:searchType", value: "")
        let waybillRange : AEXMLElement = AEXMLElement(name: "est:waybillRange", value: "")
        let initialWaybill : AEXMLElement = AEXMLElement(name: "est:initialWaybill", value: "8055241528464720099314")
        let finalWaybill : AEXMLElement = AEXMLElement(name: "est:finalWaybill", value: "8055241528464720099314")
        
        waybillRange.addChild(initialWaybill)
        waybillRange.addChild(finalWaybill)
        
        let waybillList : AEXMLElement = AEXMLElement(name: "est:waybillList", value: "")
        let waybillType : AEXMLElement = AEXMLElement(name: "est:waybillType", value: "")
        let waybills : AEXMLElement = AEXMLElement(name: "est:waybills", value: "")
        let string : AEXMLElement = AEXMLElement(name: "est:string", value: "")
        
        waybills.addChild(string)
        
        waybillList.addChild(waybillType)
        waybillList.addChild(waybills)
        
        let type : AEXMLElement = AEXMLElement(name: "est:type", value: "R")
        
        
        searchType.addChild(waybillRange)
        searchType.addChild(waybillList)
        searchType.addChild(type)
        
        
        let searchConfiguration : AEXMLElement = AEXMLElement(name: "est:searchConfiguration", value: "0")
        let includeDimensions : AEXMLElement = AEXMLElement(name: "est:includeDimensions", value: "0")
        let includeWaybillReplaceData : AEXMLElement = AEXMLElement(name: "est:includeWaybillReplaceData", value: "0")
        let includeReturnDocumentData : AEXMLElement = AEXMLElement(name: "est:includeReturnDocumentData", value: "0")
        let includeMultipleServiceData : AEXMLElement = AEXMLElement(name: "est:includeMultipleServiceData", value: "0")
        let includeInternationalData : AEXMLElement = AEXMLElement(name: "est:includeInternationalData", value: "0")
        let includeSignature : AEXMLElement = AEXMLElement(name: "est:includeSignature", value: "0")
        let includeCustomerInfo : AEXMLElement = AEXMLElement(name: "est:includeCustomerInfo", value: "0")
        
        searchConfiguration.addChild(includeDimensions)
        searchConfiguration.addChild(includeWaybillReplaceData)
        searchConfiguration.addChild(includeReturnDocumentData)
        searchConfiguration.addChild(includeMultipleServiceData)
        searchConfiguration.addChild(includeInternationalData)
        searchConfiguration.addChild(includeSignature)
        searchConfiguration.addChild(includeCustomerInfo)
        
        let historyConfiguration : AEXMLElement = AEXMLElement(name: "est:historyConfiguration", value: "")
        let includeHistory : AEXMLElement = AEXMLElement(name: "est:includeHistory", value: "0")
        let historyType : AEXMLElement = AEXMLElement(name: "est:historyType", value: "")
        
        historyConfiguration.addChild(includeHistory)
        historyConfiguration.addChild(historyType)
        
        searchConfiguration.addChild(historyConfiguration)
        
        let filterType : AEXMLElement = AEXMLElement(name: "est:filterType", value: "")
        let filterInformation : AEXMLElement = AEXMLElement(name: "est:filterInformation", value: "0")
        let filterType_ : AEXMLElement = AEXMLElement(name: "est:filterType", value: "")
        
        filterType.addChild(filterInformation)
        filterType.addChild(filterType_)
        
        searchConfiguration.addChild(filterType)
        
        act.addChild(searchType)
        act.addChild(searchConfiguration)
        
        
        
        let envelope = soapRequest.addChild(name: "soapenv:Envelope", attributes: envelopeAttributes)
        envelope.addChild(name :"soapenv:Header")
        let body = envelope.addChild(name: "soapenv:Body")
        body.addChild(act)
        
        let soapLenth = String(soapRequest.xml.characters.count)
        let theURL = URL(string: "https://trackingqa.estafeta.com/Service.asmx?wsdl")
        
        
        var mutableR = URLRequest(url: theURL!)
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        
        Alamofire.request(mutableR).responseString { (response) in
            
            
            if let xmlString = response.result.value {
                
                let xml = SWXMLHash.parse(xmlString)
                
                for element in xml["soap:Envelope"]["soap:Body"]["ExecuteQueryResponse"]["ExecuteQueryResult"].all {
                    
                    print(element)
                    
                    if let serviceDescription = element["trackingData"]["TrackingData"]["serviceDescriptionSPA"].element?.text {
                        self.serviceDescription.text = serviceDescription
                    }

                    if let packageType = element["trackingData"]["TrackingData"]["packageType"].element?.text {
                        
                        self.packageType.text = packageType
                    }
                    
                    if let status = element["trackingData"]["TrackingData"]["statusSPA"].element?.text {
                        self.status.text = status
                    }
                    
                    if let originName = element["trackingData"]["TrackingData"]["pickupData"]["originName"].element?.text {
                        self.originName.text = originName
                    }
                    
                    if let pickupData = element["trackingData"]["TrackingData"]["pickupData"]["pickupDateTime"].element?.text {
                        self.pickupDateTime.text = pickupData
                    }
                    
                    if let destinationName = element["trackingData"]["TrackingData"]["deliveryData"]["destinationName"].element?.text {
                        self.destinationName.text = destinationName
                    }
                    
                    if let deliveryData = element["trackingData"]["TrackingData"]["deliveryData"]["deliveryDateTime"].element?.text {
                        self.deliveryDateTime.text = deliveryData
                    }
                    
                    if let receiverName = element["trackingData"]["TrackingData"]["deliveryData"]["receiverName"].element?.text {
                        self.receiverName.text = receiverName
                    }
                    
                    
                    
                }
            
            }
            
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
