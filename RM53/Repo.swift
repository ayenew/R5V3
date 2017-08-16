//
//  Repo.swift
//  RM53
//
//  Created by Ayu on 7/15/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import Foundation
var relationshipRepo = [[String:Any]]()
var meetingsRepo = [[String:Any]]()
var alertNotifRepo = [[String:Any]]()
var reportRepo = [[String:Any]]()
struct Repo {
    
    static func loadCompanyInfo(){
        if let path = Bundle.main.path(forResource: "Company", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: [String:[[String:Any]]] = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:[[String:Any]]]
                    
                    let companiesArray : [[String:Any]] = jsonResult["relationship"]! as [[String:Any]]
                    for aCompany in companiesArray {
                        var c = [String:Any]()
                        c["name"] = aCompany["name"] as! String
                        c["address"] = aCompany["address"] as! String
                        c["contact"] = aCompany["contact"] as! [[String:String]]
                        c["product"] = aCompany["product"] as! [String:Any]
                        c["opportunity"] = aCompany["opportunity"] as! [[String:Any]]
                        c["meeting"] = aCompany["meeting"] as! Int
                        c["notification"] = aCompany["notification"] as! Int
                        relationshipRepo.append(c)
                    }
                } catch {}
            } catch {}
        }
    }
    
    static func loadMeetingsInfo(){
        if let path = Bundle.main.path(forResource: "Meetings", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: [String:[[String:Any]]] = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:[[String:Any]]]
                    
                    let meetingsArray : [[String:Any]] = jsonResult["meetings"]! as [[String:Any]]
                    for aMeeting in meetingsArray {
                        var c = [String:Any]()
                        c["company"] = aMeeting["company"] as! String
                        c["callPlaneName"] = aMeeting["callPlaneName"] as! String
                        c["date"] = aMeeting["date"] as! String
                        c["reason"] = aMeeting["reason"] as! String
                        c["details"] = aMeeting["details"] as! String
                        meetingsRepo.append(c)
                    }
                } catch {}
            } catch {}
        }
    }
    
    static func loadAlertNotifInfo(){
        if let path = Bundle.main.path(forResource: "Notifications", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: [String:[[String:Any]]] = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:[[String:Any]]]
                    let alertNotifArray : [[String:Any]] = jsonResult["alertNotif"]! as [[String:Any]]
                    for aNotifAlert in alertNotifArray {
                        var c = [String:Any]()
                        c["category"] = aNotifAlert["category"] as! String
                        c["type"] = aNotifAlert["type"] as! String
                        c["typeId"] = aNotifAlert["typeId"] as! String
                        c["eid"] = aNotifAlert["eid"] as! String
                        c["date"] = aNotifAlert["date"] as! String
                        c["entity"] = aNotifAlert["entity"] as! String
                        c["accountType"] = aNotifAlert["accountType"] as! String
                        c["pastDueAmount"] = aNotifAlert["pastDueAmount"] as! String
                        c["daysPastDue"] = aNotifAlert["daysPastDue"] as! String
                        c["segment"] = aNotifAlert["segment"] as! String
                        c["daysPastSLA"] = aNotifAlert["daysPastSLA"] as! String
                        c["changeAmount"] = aNotifAlert["changeAmount"] as! String
                        c["product"] = aNotifAlert["product"] as! String
                        c["accountNumber"] = aNotifAlert["accountNumber"] as! String
                        c["commitmentAmount"] = aNotifAlert["commitmentAmount"] as! String
                         c["interestRate"] = aNotifAlert["interestRate"] as! String
                         c["primaryContact"] = aNotifAlert["primaryContact"] as! String
                         c["phone"] = aNotifAlert["phone"] as! String
                         c["email"] = aNotifAlert["email"] as! String
                         c["autoBillPayer"] = aNotifAlert["autoBillPayer"] as! String
                         c["billPayerAccount"] = aNotifAlert["billPayerAccount"] as! String
                         c["pdRating"] = aNotifAlert["pdRating"] as! String
                         c["portfolioManager"] = aNotifAlert["portfolioManager"] as! String
                         c["originationDate"] = aNotifAlert["originationDate"] as! String
                         c["outstandingBalance"] = aNotifAlert["outstandingBalance"] as! String
                        c["billPayerBalance"] = aNotifAlert["billPayerBalance"] as! String
                        c["maturityDate"] = aNotifAlert["maturityDate"] as! String
                        c["pdDate"] = aNotifAlert["pdDate"] as! String
                        c["previousBalance"] = aNotifAlert["previousBalance"] as! String
                        c["availableBalance"] = aNotifAlert["availableBalance"] as! String
                        c["noOfDaysOD"] = aNotifAlert["noOfDaysOD"] as! String
                        c["daysODLast12Months"] = aNotifAlert["daysODLast12Months"] as! String
                        c["timesODLast12Months"] = aNotifAlert["timesODLast12Months"] as! String
                        alertNotifRepo.append(c)
                    }

                } catch {
                print(error.localizedDescription)
                }
            } catch {}
        }
    }
    
    static func loadReportInfo(){
        if let path = Bundle.main.path(forResource: "Report", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: [String:[[String:Any]]] = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:[[String:Any]]]
                    
                    let reportArray : [[String:Any]] = jsonResult["report"]! as [[String:Any]]
                    for aReport in reportArray {
                        var c = [String:Any]()
                        c["name"] = aReport["name"] as! String
                        c["entities"] = aReport["entities"] as! [[String:Any]]
                        reportRepo.append(c)
                    }
                } catch {}
            } catch {}
        }
    }
}
