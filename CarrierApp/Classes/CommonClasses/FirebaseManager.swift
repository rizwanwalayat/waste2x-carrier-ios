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
    var counter = 1
    var dispatchID = 0
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
            dataBase.child("\(dispatchID)").child("\(Date().dateToString("yyyy-MM-dd HH:mm:ss A"))").setValue(["lat": lat, "lon": lon])

        }
    }
    
    func stopUpdatingLocation(){
        self.timer.invalidate()
    }
}
