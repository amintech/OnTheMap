//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by  AminSaleh on 27/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import Foundation

class StudentInformation {
    
    static var studentInformation  = [StudentInfo]()
    
    struct StudentInfo : Codable {
        
        let createdAt:  String?
        let uniqueKey:  String?
        let firstName:  String?
        let lastName:   String?
        let address :   String?
        let url :       String?
        let latitude :  Double?
        let longitude : Double?
        
    }

    
}
