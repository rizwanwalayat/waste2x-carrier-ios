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
    var viewModel : DispatchesDetailModel?
    let dataBase = Database.database().reference().child("dispatch_id")
    
    private override init() {
        super.init()
    }
    
    func startUpdatingLocation(dispatchID: Int, _ viewModel : DispatchesDetailModel?){
        self.dispatchID = dispatchID
        self.viewModel = viewModel
        self.timer.invalidate()
        // updating location immediately on firebase for the first time
        updateLocationOnFirebase()
        // afterwards updating function will call after every 3 mintues using a timer
        self.timer = Timer.scheduledTimer(timeInterval: 180.0, target: self, selector: #selector(self.updateLocationOnFirebase), userInfo: nil, repeats: true)
    }
    
    @objc func updateLocationOnFirebase(){
        if let location = LocationManager.shared.currentLocation {
            let lat = location.latitude
            let lon = location.longitude
            
            let pickupLat = viewModel?.result?.pickup?.latitude ?? 0.00
            let pickupLng = viewModel?.result?.pickup?.longitude ?? 0.00
            
            fetchGoogleMapData(sLat: lat, sLon: lon, dLat: pickupLat, dLon: pickupLng)

        }
    }
    
    func stopUpdatingLocation(){
        dispatchID = -1
        self.timer.invalidate()
    }
    
    
    func fetchGoogleMapData(sLat: Double, sLon: Double, dLat: Double, dLon: Double) {
        
        
        let origin = "\(sLat),\(sLon)"
        let destination = "\(dLat),\(dLon)"
        APIRoutes.polyLineUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(googleAPIKey)"
        print(APIRoutes.polyLineUrl)
        PolyLineAPIModel.PolyLineAPICall { jsonData, error, status, message in
    
            if jsonData?.routes != nil{
                
                if let item = jsonData!.routes.first {
                    
                    let eta = item.legs[0].duration?.text
                    let distance = item.legs[0].distance?.text
                    
                    let timestamp = Date().dateToString("yyyy-MM-dd HH:mm:ss")
                    
                    let postDict : [String : Any] = ["lat": sLat,
                                                     "lon": sLon,
                                                     "eta": eta ?? "",
                                                     "distance": distance ?? ""]
                    
                    self.dataBase.child("\(self.dispatchID)").child("\(timestamp)").setValue(postDict)
                    
                }
            }
        }
    }
}
