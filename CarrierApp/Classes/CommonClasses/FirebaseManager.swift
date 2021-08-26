//
//  FirebaseManager.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 26/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager: NSObject {
    
    static let shared = FirebaseManager()
    var timer = Timer()
    var dispatchID = -1
    let dataBase = Database.database().reference().child("dispatch_id")
    
    private override init() {
        super.init()
    }
    
    func startUpdatingLocation(dispatchID: Int){
        self.dispatchID = dispatchID
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.updateLocationOnFirebase), userInfo: nil, repeats: true)
    }
    
    @objc func updateLocationOnFirebase(){
        if let location = LocationManager.shared.currentLocation {
            let lat = location.latitude
            let lon = location.longitude
            let timestamp = Date().dateToString("yyyy-MM-dd HH:mm:ss")
            dataBase.child("\(dispatchID)").child("\(timestamp)").setValue(["lat": lat, "lon": lon])
        }
    }
    
    func stopUpdatingLocation(){
        dispatchID = -1
        self.timer.invalidate()
    }
}
