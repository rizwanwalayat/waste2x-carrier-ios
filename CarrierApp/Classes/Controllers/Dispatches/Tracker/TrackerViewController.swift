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
    
    var locationManager = CLLocationManager()
    var currentLocation = ""
    var endingLocation = ""
    var currentLat = Double()
    var currentLon = Double()
    var destinationLat = Double()
    var destinationLng = Double()
    var timer = Timer()
    var trackID = 1
    
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    //MARK: - Controller's Life cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        locationLabel.setAttributedTextInLable("From", "6C6C6C", 10, "Isale, Bujumbura Rural, Burundi", "6C6C6C", 10)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        mainView.roundCornersTopView(36)    
        mapView.roundCornersTopView(36)
        initializeTheLocationManager()
        
    }

    
    //MARK: - Functions
    
    func initializeTheLocationManager() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        
        }
    func markerUpdate(s_lat : Double,s_lon:Double,d_lat:Double,d_lon:Double){

        // MARK: Marker for source location
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: s_lat, longitude: s_lon)
        marker.title = "Starting"
        marker.icon = UIImage (named: "startmark")
        
                
                
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

    
    //MARK: - IBOutlets
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

//MARK: - MapView

extension TrackerViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("lcoation delegate call")
        
        self.locationManager.stopUpdatingLocation()

    }
    
    
}


