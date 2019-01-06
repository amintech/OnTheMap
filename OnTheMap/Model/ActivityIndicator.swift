//
//  ActivityIndicator.swift
//  OnTheMap
//
//  Created by  AminSaleh on 27/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit
import Foundation

struct ActivityIndicator {
    
    private static var ai :UIActivityIndicatorView = UIActivityIndicatorView()
    
    static func aiStart(view: UIView) {
        
        ai.center = view.center
        ai.hidesWhenStopped = true
        ai.style = .gray
        view.addSubview(ai)
        ai.startAnimating()
        
    }
    
    static func aiStop() {
        
        ai.stopAnimating()
        
    }
    
}

