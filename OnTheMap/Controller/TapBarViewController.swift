//
//  TapBarViewController.swift
//  OnTheMap
//
//  Created by  AminSaleh on 12/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class TapBarViewController: UITabBarController {

    @IBOutlet weak var addPin: UIBarButtonItem!
    @IBOutlet weak var logOut: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPin(_ sender: Any) {
        self.performSegue(withIdentifier: "addPin", sender: self)
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        API.logout { (states, error) in

            print("signed out success")
            if error != nil {
                let error = UIAlertController(title: "Erorr", message: "There was an error", preferredStyle: .alert )

                error.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                    return
                }))
                self.present(error, animated: true, completion: nil)
                return
            } else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toLogIn", sender: self)
                }

            }

        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        let vc = viewControllers?[0] as! MapViewController
        vc.reload()
        
        let vc2 = viewControllers?[1] as! TableViewController
        vc2.reload()
        
    }

}
