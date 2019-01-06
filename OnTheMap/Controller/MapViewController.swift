//
//  MapViewController.swift
//  OnTheMap
//
//  Created by  AminSaleh on 09/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func reload(){
       let annot = self.mapView.annotations
       self.mapView.removeAnnotations(annot)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        ActivityIndicator.aiStart(view: self.view)
        
        API.getAllLocations() {(studentsLocations, error) in
            
            DispatchQueue.main.async {
                
                if error != nil {
                    ActivityIndicator.aiStop()
                    let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
                    
                    errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                }
                
                var annotations = [MKPointAnnotation] ()
                
                guard let locationsArray = studentsLocations else {
                    ActivityIndicator.aiStop()
                    let locationsErrorAlert = UIAlertController(title: "Erorr loading locations", message: "There was an error loading locations", preferredStyle: .alert )
                    
                    locationsErrorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(locationsErrorAlert, animated: true, completion: nil)
                    return
                    
                }
                
                for locationStruct in locationsArray {
                    
                    let long = CLLocationDegrees(locationStruct.longitude ?? 0)
                    let lat = CLLocationDegrees(locationStruct.latitude ?? 0)
                    
                    let coords = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    let mediaURL = locationStruct.mediaURL ?? " "
                    let first = locationStruct.firstName ?? " "
                    let last = locationStruct.lastName ?? " "
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coords
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                    
                    annotations.append(annotation)
                        
                }
                
                ActivityIndicator.aiStop()
                
                self.mapView.addAnnotations(annotations)
                
            }
            
        }
        
    }
    
}

extension MapViewController {
    
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
