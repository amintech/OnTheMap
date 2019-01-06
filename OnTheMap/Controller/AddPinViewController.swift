//
//  AddPinViewController.swift
//  OnTheMap
//
//  Created by  AminSaleh on 12/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit
import MapKit

class AddPinViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var findLocation: UIButton!
    
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var urlText: UITextField!
    
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        self.navigationItem.backBarButtonItem?.title = "Cancel"
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    @IBAction func findLocation(_ sender: Any) {
        
        if addressText.text != "" && urlText.text != "" {
            
            let MKSearch = MKLocalSearch.Request()
            MKSearch.naturalLanguageQuery = addressText.text
            
            let liveSearch = MKLocalSearch(request: MKSearch)
            
            liveSearch.start { (response, error) in
                if error != nil {
                    let error = UIAlertController(title: "Erorr", message: "There was an error", preferredStyle: .alert )
                    
                    error.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(error, animated: true, completion: nil)
                    return
                } else {
                    
                    self.latitude = response?.boundingRegion.center.latitude
                    self.longitude = response?.boundingRegion.center.longitude
                    
                    self.performSegue(withIdentifier: "toSaveLocation", sender: nil)
                    
                }
            }
        } else {
            
            DispatchQueue.main.async {
                
                let error = UIAlertController(title: "Erorr", message: "error", preferredStyle: .alert )
                
                error.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                    return
                }))
                self.present(error, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
}

extension AddPinViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSaveLocation"{
            
            let vc = segue.destination as! SaveLocatinViewController
            
            vc.addressText = addressText.text
            vc.urlText = urlText.text
            vc.latitude = self.latitude
            vc.longitude = self.longitude
            
        }
        
    }
    
}
