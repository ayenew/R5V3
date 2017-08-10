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
                        c["opportunity"] = aCompany["opportunity"] as! [[String:String]]
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
                        c["name"] = aMeeting["name"] as! String
                        c["date"] = aMeeting["date"] as! String
                        c["reason"] = aMeeting["reason"] as! String
                        c["company"] = aMeeting["company"] as! String
                        c["details"] = aMeeting["details"] as! String
                        meetingsRepo.append(c)
                    }
                } catch {}
            } catch {}
        }
    }
}

