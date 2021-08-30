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
    
    var trackID = 1
    var viewModel:TrackerVM?
    var deliveryType = DispatchesDeliveryType.none
    
    /// for timer
    var timer = Timer()
    
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
        pickupLocationLabel.setAttributedTextInLable("From", "6C6C6C", 10, "Isale, Bujumbura Rural, Burundi", "6C6C6C", 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        mainView.roundCornersTopView(36)    
        mapView.roundCornersTopView(36)
        loadMap()
        startTimer()
        dispatchRepLabel.text = viewModel?.data?.result?.details?.dispatch_rep ?? "Dispatch Rep"
        deliveryLocationLabel.text = viewModel?.data?.result?.delivery?.location ?? "Delivery Location"
        pickupLocationLabel.text = viewModel?.data?.result?.pickup?.location ?? "Pickup Location"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.timer.invalidate()
    }
    
    //MARK: - Functions
    
    func startTimer()
    {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.timerAction(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction( _ timer : Timer) {
        loadMap()
    }
    
    //MARK: - IBOutlets
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Maps Related
extension TrackerViewController
{
    func fetchGoogleMapData(sLat: Double, sLon: Double, dLat: Double, dLon: Double) {
        mapView.clear()
        
        let origin = "\(sLat),\(sLon)"
        let destination = "\(dLat),\(dLon)"
        APIRoutes.polyLineUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(googleAPIKey)"
        print(APIRoutes.polyLineUrl)
        PolyLineAPIModel.PolyLineAPICall { jsonData, error, status, message in
    
            if jsonData?.routes != nil{
                if let item = jsonData!.routes.first {
                    self.deliveryLocationLabel.text = item.legs[0].end_address
                    self.timeLabel.text = item.legs[0].duration?.text
                    self.kmLabel.text = item.legs[0].distance?.text
                    let points = item.overviewPolyline?.points
                    let path = GMSPath.init(fromEncodedPath: points ?? "")
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeColor = UIColor(named: "lineColor")!
                    polyline.strokeWidth = 5
                    polyline.geodesic = true
                    polyline.map = self.mapView
                    
                    DispatchQueue.main.async {
                        let cam = GMSCameraPosition(latitude: sLat, longitude: sLon, zoom: 15)
                        self.mapView.animate(to: cam)

//                     Zoom for complete Path
//                        let bounds = GMSCoordinateBounds(path: path!)
//                        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
                    }
                }
            }
        }
    }
    
    @objc func loadMap(){
        let pickupLat = viewModel?.data?.result?.pickup?.latitude ?? 0.00
        let pickupLng = viewModel?.data?.result?.pickup?.longitude ?? 0.00
        let deliveryLat = viewModel?.data?.result?.delivery?.latitude ?? 0.00
        let deliveryLng = viewModel?.data?.result?.delivery?.longitude ?? 0.00
        
        if let location = LocationManager.shared.currentLocation {
            let currentLat = location.latitude
            let currentLon = location.longitude
            
            let sLat = currentLat
            let sLon = currentLon
            var dLat = pickupLat
            var dLon = pickupLng
            
            if deliveryType == .delivery {
                dLat = deliveryLat
                dLon = deliveryLng
            }
            
            fetchGoogleMapData(sLat:sLat, sLon:sLon, dLat: dLat, dLon: dLon)
            
            self.markerUpdate(s_lat: sLat, s_lon: sLon, d_lat: dLat, d_lon: dLon)
        }
    }
    
    func markerUpdate(s_lat : Double,s_lon:Double,d_lat:Double,d_lon:Double){
        
        // MARK: Marker for source location
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: s_lat, longitude: s_lon)
        marker.title = "Pickup"
        marker.icon = UIImage (named: "location-track-truck")
        let  heading:Double = LocationManager.shared.currentHeading?.trueHeading ?? 0.0
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.rotation = heading
        
        
        // MARK: Marker for destination location
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: d_lat, longitude: d_lon)
        marker1.title = "Ending"
        marker1.icon = UIImage (named: "location-destination")
        
        
        DispatchQueue.main.async {
            marker.map = self.mapView
            marker1.map = self.mapView
        }
    }
}



