//
//  SaveLocatinViewController.swift
//  OnTheMap
//
//  Created by  AminSaleh on 19/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit
import MapKit

class SaveLocatinViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var appKey:      String?
    var addressText: String?
    var urlText:     String?
    var latitude:    Double?
    var longitude:   Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createAnnotation()
    }
    
    @IBAction func saveLocation(_ sender: Any) {
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appKey = appDelegate.uniqueKey!
        
        guard let key = appKey, let address = addressText, let url = urlText, let lat = latitude, let lon = longitude else {
            return
        }
        
        API.saveLocation(key, address, url, lat, lon){ (states, error) in
            
            ActivityIndicator.aiStart(view: self.view)
            
            DispatchQueue.main.async {
                
                ActivityIndicator.aiStop()
                
                if states == false {
                    
                    let error = UIAlertController(title: "Erorr", message: "There was an error", preferredStyle: .alert )
                    
                    error.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(error, animated: true, completion: nil)
                    return
                    
                } else {
                    
                    ActivityIndicator.aiStop()
                    
                    let success = UIAlertController(title: "Success", message: "Student Saved", preferredStyle: .alert )
                    
                    success.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(success, animated: true, completion: nil)
                    return
                    
                }
            }
            
        }
        
    }
    
    func createAnnotation(){
        let annotation = MKPointAnnotation()
        annotation.title = addressText!
        annotation.subtitle = urlText!
        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        self.mapView.addAnnotation(annotation)
        
        let coredinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coredinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
}

extension SaveLocatinViewController {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
}
