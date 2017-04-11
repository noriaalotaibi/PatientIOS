//
//  HospitalCache.swift
//  MHealth
//
//  Created by Abrar Al-Failakawi on 4/10/17.
//  Copyright © 2017 PIFSS. All rights reserved.
//

import Foundation
class HospitalCache: NSObject, NetworkCaller {
    
    
    private var Hospital:[HospitalDH] = [HospitalDH]()
    
    private static var singlenton = HospitalCache()
    var caller:NetworkCaller? = nil
    
    
    public static func myInstanc() -> HospitalCache
    {
        return singlenton
    }
    
    public func addHospital( newHospital: HospitalDH )
    {
        Hospital.append( newHospital )
    }
    
    
    
    
    
    public func getHospital() -> [HospitalDH]
    {
        return Hospital
    }
    
    override init() {
        
        super.init()
        let networkManager = Networking()
        networkManager.logging = true
        networkManager.AMGetArrayData("http://34.196.107.188:8081/MhealthWeb/webresources/hospital", params: [:], reqId: 1, caller: self)
    }
    
    func setDictResponse(resp:NSDictionary, reqId:Int) {
        caller?.setDictResponse(resp, reqId: reqId)
    }
    
    func setArrayResponse(resp:NSArray, reqId:Int) {
        if (reqId == 1)
        {
            print( resp )
            
            for i in 0 ..< resp.count {
                let hospital:HospitalDH = HospitalDH()
                print(resp.objectAtIndex(i))
                hospital.loadDictionary( resp.objectAtIndex(i) as! NSDictionary )
                self.addHospital(hospital)
            }
            
            print("My Hospital Set!")
        }
        caller?.setArrayResponse(resp, reqId: reqId)
    }
    
    
    
    
}
