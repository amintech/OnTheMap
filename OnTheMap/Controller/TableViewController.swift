//
//  TableViewController.swift
//  OnTheMap
//
//  Created by  AminSaleh on 09/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func reload() {
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
                    
                    let mediaURL = locationStruct.mediaURL ?? " "
                    let first = locationStruct.firstName ?? " "
                    let last = locationStruct.lastName ?? " "
                    let lat = locationStruct.latitude ?? 0
                    let lon = locationStruct.longitude ?? 0
                    let created = locationStruct.createdAt ?? " "
                    let location = locationStruct.mapString ?? " "
                    
                    let studentInfo = StudentInformation.StudentInfo.init(createdAt: created, uniqueKey: "", firstName: first, lastName: last, address: location, url: mediaURL, latitude: lat, longitude: lon)
                    
                    StudentInformation.studentInformation.append(studentInfo)

                }
                
                self.reload()
                ActivityIndicator.aiStop()
                print("table reloaded")
                
            }
            
        }
        
    }
    
}

extension TableViewController
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInformation.studentInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pinCell") as! TableViewCell
        
        let cellContent = StudentInformation.studentInformation[(indexPath as NSIndexPath).row]
        
        cell.nameText.text = "\(cellContent.firstName ?? " ") \(cellContent.lastName ?? " ")"
        cell.urlText.text = cellContent.url
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellContent = StudentInformation.studentInformation[(indexPath as NSIndexPath).row]
        guard let url = URL(string: cellContent.url!) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
}
