//
//  TrackerViewController.swift
//  Waste2x
//
//  Created by HaiDer's Macbook Pro on 04/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import GoogleMaps

class TrackerViewController: BaseViewController {
    
//MARK: - Variables
    
    var pickupLocation = ""
    var deliveryLocation = ""
    var currentLocation = ""
    var currentLat = Double()
    var currentLon = Double()
   
    var timer = Timer()
    var trackID = 1
    var viewModel:TrackerVM?
    var pickupLat = Double()
    var pickupLng = Double()
    var deliveryLat = Double()
    var deliveryLng = Double()
    
    //MARK: - Outlets
    
    @IBOutlet weak var dispatchRepLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var deliveryLocationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickupLocationLabel: UILabel!
    
    
    //MARK: - Controller's Life cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        pickupLocationLabel.setAttributedTextInLable("From", "6C6C6C", 10, "Isale, Bujumbura Rural, Burundi", "6C6C6C", 10)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        mainView.roundCornersTopView(36)    
        mapView.roundCornersTopView(36)
        loadMap()
        dispatchRepLabel.text = viewModel?.data?.result?.details?.dispatch_rep ?? "Dispatch Rep"
        deliveryLocationLabel.text = viewModel?.data?.result?.delivery?.location ?? "Delivery Location"
        pickupLocationLabel.text = viewModel?.data?.result?.pickup?.location ?? "Pickup Location"
        NotificationCenter.default.addObserver(self, selector: #selector(loadMap), name: .didReceiveLocation, object: nil)
    }

    
    //MARK: - Functions

    
    @objc func loadMap(){
        pickupLat = viewModel?.data?.result?.pickup?.latitude ?? 0.00
        pickupLng = viewModel?.data?.result?.pickup?.longitude ?? 0.00
        deliveryLat = viewModel?.data?.result?.delivery?.latitude ?? 0.00
        deliveryLng = viewModel?.data?.result?.delivery?.longitude ?? 0.00
        pickupLocation = "\(self.pickupLat),\(self.pickupLng)"
        deliveryLocation = "\(self.deliveryLat),\(self.deliveryLng)"
        
        if let location = LocationManager.shared.currentLocation {
            currentLat = location.latitude
            currentLon = location.longitude
            currentLocation = "\(currentLat),\(currentLon)"
            fetchGoogleMapData(Current: currentLocation, Pickup: pickupLocation, DropOff: deliveryLocation)
        } else {
            fetchGoogleMapData(Current: nil, Pickup: pickupLocation, DropOff: deliveryLocation)

        }
        
        
        markerUpdate(s_lat: pickupLat, s_lon: pickupLng, d_lat: deliveryLat, d_lon: deliveryLng)
    }
        
    func markerUpdate(s_lat : Double,s_lon:Double,d_lat:Double,d_lon:Double){

        // MARK: Marker for source location
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: s_lat, longitude: s_lon)
        marker.title = "Pickup"
        marker.icon = UIImage (named: "Location Next")
        
                
                
        // MARK: Marker for destination location
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: d_lat, longitude: d_lon)
        marker1.title = "Ending"
        marker1.icon = UIImage (named: "endmark")
        
        
        DispatchQueue.main.async {
            marker.map = self.mapView
            marker1.map = self.mapView
            
            }
    }

    func fetchGoogleMapData(Current : String?, Pickup: String, DropOff : String) {
        
        mapView.clear()
        print(Pickup,DropOff)
        if Current != nil {
            APIRoutes.polyLineUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=\(Current!)&destination=\(DropOff)&mode=driving&waypoints=\(Pickup)&key=\(googleAPIKey)"
        } else {
            APIRoutes.polyLineUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=\(Pickup)&destination=\(DropOff)&mode=driving&key=\(googleAPIKey)"
        }
        
        print(APIRoutes.polyLineUrl)
        PolyLineAPIModel.PolyLineAPICall { jsonData, error, status, message in
            if jsonData?.routes != nil{
                let item = jsonData!.routes.first
                
//            for item in jsonData!.routes {
                self.deliveryLocationLabel.text = item?.legs[0].end_address
                self.timeLabel.text = item?.legs[0].duration?.text
                self.kmLabel.text = item?.legs[0].distance?.text
                let points = item?.overviewPolyline?.points
                let path = GMSPath.init(fromEncodedPath: points ?? "")
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeColor = UIColor(named: "lineColor")!
                polyline.strokeWidth = 5
                polyline.geodesic = true
                polyline.map = self.mapView
                DispatchQueue.main.async {
                    let bounds = GMSCoordinateBounds(path: path!)
                    self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                }
//            }
//                let cam = GMSCameraPosition(latitude: self.deliveryLat, longitude: self.deliveryLng, zoom: 10)
                
            }
        }
    }
    
    
    //MARK: - IBOutlets
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}




