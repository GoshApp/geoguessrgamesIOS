//
//  MapsViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 16.12.2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapViewPosition: GMSMapView!
    
    @IBOutlet weak var mapViewPanorama: GMSPanoramaView!
    
    
    @IBOutlet weak var placeTourMap: UIButton!
    
    @IBOutlet weak var button: UIButton!
    
    var isBigFrame = true
    var latitudeOfPoint: Double = 0.0
    var longitudeOfPoint: Double = 0.0
    var curentPoints: CourseViewModel?
    
    static var curentPoint: Int = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: 48.876225, longitude: 2.320808, zoom: 0.0)
        mapViewPosition.camera = camera
        showMarker(position: camera.target)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.clear()
        self.view.addSubview(mapView)
        
        
        let panoView = GMSPanoramaView(frame: .zero)
        self.mapViewPanorama = panoView
        
        var latitude: Double?
        var longitude: Double?
        // plass 1 for next screen
        switch MapViewController.curentPoint {
        case 1:
            latitude = Double(curentPoints!.latitude1)!
            longitude = Double(curentPoints!.longitude1)!
        case 2:
            latitude = Double(curentPoints!.latitude2)!
            longitude = Double(curentPoints!.longitude2)!
        case 3:
            latitude = Double(curentPoints!.latitude3)!
            longitude = Double(curentPoints!.longitude3)!
        case 4:
            latitude = Double(curentPoints!.latitude4)!
            longitude = Double(curentPoints!.longitude4)!
        case 5:
            latitude = Double(curentPoints!.latitude5)!
            longitude = Double(curentPoints!.longitude5)!
        case 6:
            latitude = Double(curentPoints!.latitude6)!
            longitude = Double(curentPoints!.longitude6)!
        case 7:
            latitude = Double(curentPoints!.latitude7)!
            longitude = Double(curentPoints!.longitude7)!
        case 8:
            latitude = Double(curentPoints!.latitude8)!
            longitude = Double(curentPoints!.longitude8)!
        default:
            print("Error initializing point")
        }
        
        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
         

        placeTourMap.isHidden = false
        configureButtons()
        self.mapViewPosition.delegate = self
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        
    }
    
    @IBAction func changesize(_ sender: UIButton) {
        setSizeOfFrameMap()
        isBigFrame == isBigFrame
    }
    
    func setSizeOfFrameMap(){
        var sizeOfFrame = 0
        var sizeOfFrameLeft = 90
        if(isBigFrame){
            sizeOfFrame = 0
            sizeOfFrameLeft = 0
        }
        
        self.view.addSubview(mapViewPosition!)
        mapViewPosition?.translatesAutoresizingMaskIntoConstraints = false
        mapViewPosition?.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive=true
        mapViewPosition?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(sizeOfFrameLeft)).isActive=true
        mapViewPosition?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive=true
        mapViewPosition?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(sizeOfFrame)).isActive = false
    }
    
    func configureButtons(){
        button.layer.cornerRadius = 25.0
        button.setTitle("", for: .normal)
        button.isHidden = true
        placeTourMap.isHidden = true
        placeTourMap.titleLabel?.textAlignment = NSTextAlignment.center

    }
    
    
    @IBAction func nextButtons(_ sender: UIButton) {
        
        placeTourMap.isHidden = true
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RezultViewControllerID") as? RezultViewController
        vc!.curentPoints = curentPoints
        vc!.latitudeOfPoint = latitudeOfPoint
        vc!.longitudeOfPoint = longitudeOfPoint
        show(vc!, sender: self)
        MapViewController.curentPoint += 1
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        
        let marker: GMSMarker = GMSMarker()
         marker.title = ""
         marker.snippet = ""
         marker.icon = UIImage(named: "marker")
         marker.appearAnimation = .pop
         marker.position = coordinate
         mapView.clear()
        DispatchQueue.main.async {
            marker.map = self.mapViewPosition
        }
        
        let target = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapViewPosition?.camera = GMSCameraPosition(target: target, zoom: 0.5)
        
        latitudeOfPoint = coordinate.latitude
        longitudeOfPoint = coordinate.longitude
        
        placeTourMap.isHidden = false
    }
    
    @IBAction func backCourse(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CoursesControllerID") as! CoursesController
//        navigationController?.pushViewController(vc, animated: false)
    }
}
