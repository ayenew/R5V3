//
//  Repo.swift
//  RM53
//
//  Created by Ayu on 7/15/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import Foundation
var relationshipRepo = [[String:Any]]()
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
                        c["zip"] = aCompany["zip"] as! String
                        c["notifications"] = aCompany["notifications"] as! [String:Any]
                        c["alerts"] = aCompany["alerts"] as! [String:Any]
                        c["depositRevenue"] = aCompany["depositRevenue"] as! [String:Any]
                        c["callFrequency"] = aCompany["callFrequency"] as! [String:Any]
                        c["depositBalance"] = aCompany["depositBalance"] as! [String:Any]
                        relationshipRepo.append(c)
                    }
                } catch {}
            } catch {}
        }
    }
}

