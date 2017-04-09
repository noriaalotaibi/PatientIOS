//
//  DonorCache.swift
//  MHealth
//
//  Created by trn15 on 3/7/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import UIKit

class DonorCache: NSObject, NetworkCaller {

  
    private var myDonors:[DonorDH] = [DonorDH]()
    
    private static var singlenton = DonorCache()
    var caller:NetworkCaller? = nil
    
    
    public static func myInstanc() -> DonorCache
    {
        return singlenton
    }
    
    public func addDonor( newDonor: DonorDH )
    {
        myDonors.append( newDonor )
    }
    
   
    
    
    
    public func getDonors() -> [DonorDH]
    {
        return myDonors
    }
    
    override init() {
        // get doctors as array
        super.init()
        let networkManager = Networking()
        networkManager.logging = true
        networkManager.AMGetArrayData("http://34.196.107.188:8080/mHealthWS/ws/donor", params: [:], reqId: 1, caller: self)
    }
    
    func setDictResponse(resp:NSDictionary, reqId:Int) {
        caller?.setDictResponse(resp, reqId: reqId)
    }
    
    func setArrayResponse(resp:NSArray, reqId:Int) {
        // set donors
        if (reqId == 1)
        {
            print( resp )
            
            for i in 0 ..< resp.count {
                let donor:DonorDH = DonorDH()
                print(resp.objectAtIndex(i))
                donor.loadDictionary( resp.objectAtIndex(i) as! NSDictionary )
                self.addDonor( donor )
            }
            
            print("My Donors Set!")
        }
        caller?.setArrayResponse(resp, reqId: reqId)
    }
    

    
    
}
