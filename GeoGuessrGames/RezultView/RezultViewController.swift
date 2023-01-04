//
//  RezultViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 19.12.2022.
//
import Foundation
import UIKit
import GoogleMaps
import GoogleMobileAds

class RezultViewController: UIViewController, GADFullScreenContentDelegate {
    
    var timer2: Timer?
    var interstitial: GADInterstitialAd?
    var curentPoints: CourseViewModel?
    var mapViewController: MapViewController?
    var latitudeOfPoint: Double?
    var longitudeOfPoint: Double?
    var longitudeFromList: Double?
    var latitudeFromList: Double?
    var isAdsShowed = false
    var isSeccondClick = false
    var timeLeft = 0
    var counterTimer: Double = 1
    var counter = 5
    static var progressi: Float = 1 / 8
    static var score: Int = 0
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var ratingStackView: RatingController!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textGuessWas: UILabel!
    @IBOutlet weak var textPoint: UILabel!
    @IBOutlet weak var textScore: UILabel!
    @IBOutlet weak var textState: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textLocation: UILabel!
    
    let textguesswas = "Your guess was:".addLocalizableString()
    let textpoint = "Your point:".addLocalizableString()
    let textscore = "Your score:".addLocalizableString()
    let textstate = "Your state:".addLocalizableString()
    let timertext = "You can start the game in:".addLocalizableString()
    let secondstext = "seconds".addLocalizableString()
    let letsstart = "Let's start!".addLocalizableString()
    let textlocation = "Did you enjoy this location?".addLocalizableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        button.setTitle("PLAY NEXT ROUND", for: .normal)
        button.titleLabel?.textAlignment = .center
        let singUp = NSLocalizedString("PLAY NEXT ROUND", comment: "Next round")
        button.setTitle(singUp, for: .normal)
        
        textLocation.text = textlocation
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        button.isEnabled = false
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
        
        let camera = GMSCameraPosition.camera(withLatitude: latitudeOfPoint!, longitude: longitudeOfPoint!, zoom: 2.0)
        mapView.camera = camera
        self.show_marker(position: mapView.camera.target)
        
        let coordinate0 = CLLocation(latitude: latitudeOfPoint!, longitude: longitudeOfPoint!)
        let coordinate1 = CLLocation(latitude: latitudeFromList!, longitude: longitudeFromList!)
        
        progressView.progress = RezultViewController.progressi
        
        changeLanguale(str: "en")
        
        calculator(coordinate0: coordinate0, coordinate1: coordinate1)
        
        timer2 = Timer.scheduledTimer(
            timeInterval: counterTimer,
            target: self,
            selector: #selector(updateCounter),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func updateCounter() {
        counter -= 1
        counterTimer -= 1
        timer.text = "\(timertext) \(counter) \(secondstext)"
        if counter == 0 {
            timer.text = letsstart
            handleTimerExecution() }
    }
    
    private func handleTimerExecution() {
        timer2?.invalidate()
        button.isEnabled = true
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
    
    func show_marker(position: CLLocationCoordinate2D) {
        
        switch MapViewController.curentPoint {
        case 1:
            latitudeFromList = Double(curentPoints!.latitude1)!
            longitudeFromList = Double(curentPoints!.longitude1)!
        case 2:
            latitudeFromList = Double(curentPoints!.latitude2)!
            longitudeFromList = Double(curentPoints!.longitude2)!
        case 3:
            latitudeFromList = Double(curentPoints!.latitude3)!
            longitudeFromList = Double(curentPoints!.longitude3)!
        case 4:
            latitudeFromList = Double(curentPoints!.latitude4)!
            longitudeFromList = Double(curentPoints!.longitude4)!
        case 5:
            latitudeFromList = Double(curentPoints!.latitude5)!
            longitudeFromList = Double(curentPoints!.longitude5)!
        case 6:
            latitudeFromList = Double(curentPoints!.latitude6)!
            longitudeFromList = Double(curentPoints!.longitude6)!
        case 7:
            latitudeFromList = Double(curentPoints!.latitude7)!
            longitudeFromList = Double(curentPoints!.longitude7)!
        case 8:
            latitudeFromList = Double(curentPoints!.latitude8)!
            longitudeFromList = Double(curentPoints!.longitude8)!
        default:
            print("Error initializing point")
        }
        
        let path = GMSMutablePath()
        path.addLatitude(latitudeOfPoint!, longitude: longitudeOfPoint!)
        path.addLatitude(latitudeFromList!, longitude: longitudeFromList!)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 2.5
        polyline.strokeColor = .red
        polyline.map = mapView
        
        let position1 = CLLocationCoordinate2D(latitude: latitudeFromList!, longitude: longitudeFromList!)
        let marker1 = GMSMarker(position: position1)
        marker1.title = "Hello World"
        marker1.icon = UIImage(named: "marker")
        marker1.map = mapView
        
        let position2 = CLLocationCoordinate2D(latitude: latitudeOfPoint!, longitude: longitudeOfPoint!)
        let marker2 = GMSMarker(position: position2)
        marker2.icon = UIImage(named: "marker")
        marker2.title = "Hello World"
        marker2.map = mapView
    }
    
    func changeLanguale(str: String){
//        textGuessWas.text = textguesswas.addLocalizableString(str: str)
//        textPoint.text = textpoint.addLocalizableString(str: str)
    }
    
    func calculator(coordinate0: CLLocation, coordinate1: CLLocation){
        let distance = Int(coordinate0.distance(from: coordinate1))
        var defPoint = 33
        let point = 5000 - distance
        if(point > 0){
            defPoint = point
        }
        RezultViewController.score = RezultViewController.score + defPoint
        textGuessWas.text = "\(textguesswas) \(distance / 1000)km"
        textPoint.text = "\(textpoint) \(defPoint)"
        textScore.text = "\(textscore) \(RezultViewController.score + defPoint)"
        textState.text = "\(textstate) \(MapViewController.curentPoint - 1)"
    }
    
    @IBAction func nextPlayRound(_ sender: UIButton) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            isAdsShowed = true
        } else {
            print("Ad wasn't ready")
        }
        if(isSeccondClick){
            if(isAdsShowed){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if MapViewController.curentPoint - 1 != 8 {
                    let vc = storyboard.instantiateViewController(withIdentifier: "MapViewControllerID") as! MapViewController
                    vc.curentPoints = curentPoints
                    vc.modalTransitionStyle = .flipHorizontal
                    vc.modalPresentationStyle = .currentContext
                    self.navigationController?.pushViewController(vc, animated: true)
                    RezultViewController.progressi += 1 / 8
                    isAdsShowed = false
                }else{
                    let presentOne = storyboard.instantiateViewController(withIdentifier: "CoursesControllerID") as! CoursesController
                    self.navigationController?.pushViewController(presentOne, animated: true)
                    MapViewController.curentPoint = 1
                    RezultViewController.progressi = 1 / 8
                    RezultViewController.score = 0
                    isAdsShowed = false
                }
            }
        }else {
            isSeccondClick = true
        }
    }
}

extension String {
    func addLocalizableString() -> String {
//        let path = Bundle.main.path(forResource: str, ofType: "lproj")
//        let bundle = Bundle(path: path!)
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}

