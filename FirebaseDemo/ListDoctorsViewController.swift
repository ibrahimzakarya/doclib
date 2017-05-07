//
//  ListDoctorsViewController.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/21/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit
import Firebase

class ListDoctorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var listDoctorTableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    var ref = FIRDatabase.database().reference()
    var imgRef = FIRStorage.storage().reference().child("doctorImages")
    
    var doctor: Doctor!
    var doctors = [Doctor]()
    var filteredDoctors = [Doctor]()
    var inSearchMode = false
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listDoctorTableView.delegate = self
        
        listDoctorTableView.dataSource = self
        
        downloadDoctorsData()
        listDoctorTableView.reloadData()
        
        searchBarOutlet.delegate = self
        
        searchBarOutlet.returnKeyType = UIReturnKeyType.done
    }
    
    func downloadDoctorsData() {
        
        ref.child("doctors").observe(.value, with: { snapshot in
            
            let enumerator = snapshot.children
            
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                
                if let child = rest.value as? NSDictionary {
                    
                    let doctor = Doctor(doctorDict: child)
                    
                    self.doctors.append(doctor)
                    
                    self.doctors.sort(by: { $0.fullname < $1.fullname } )
                    
                    self.listDoctorTableView.reloadData()

                }
                self.listDoctorTableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var doctor: Doctor!
        
        if inSearchMode {
            
            doctor = filteredDoctors[indexPath.row]
            
        } else {
            
            doctor = doctors[indexPath.row]
        }
        
        performSegue(withIdentifier: "DoctorDetailsVC", sender: doctor)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listDoctorTableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as! DoctorCell
        
        let doctor: Doctor!
        
        if inSearchMode {
            
            doctor = filteredDoctors[indexPath.row]
            
            cell.configureCell(doctor: doctor)
            
        } else {
            
            doctor = doctors[indexPath.row]
            
            if let img = ListDoctorsViewController.imageCache.object(forKey: doctor.imageUrl as NSString) {
                
                cell.configureCell(doctor: doctor, img: img)
                
            } else {
                
                cell.configureCell(doctor: doctor)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredDoctors.count
        }
        return doctors.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBarOutlet.text == nil || searchBarOutlet.text == "" {
            
            inSearchMode = false
            
            listDoctorTableView.reloadData()
            
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBarOutlet.text!
            
            filteredDoctors = doctors.filter({ ($0.fullname.range(of: lower) != nil) })
            
            listDoctorTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DoctorDetailsVC" {
            
            if let detailsVC = segue.destination as? DoctorDetailsViewController {
                
                if let doctor = sender as? Doctor {
                    
                    detailsVC.doctor = doctor
                }
            }
        }
    }
    
    @IBAction func segmentedView(_ sender: UISegmentedControl) {
        
        if segmentedOutlet.selectedSegmentIndex == 1 {
            
            self.doctors.sort(by: { $0.address.capitalized < $1.address.capitalized })
            
            listDoctorTableView.reloadData()
            
        } else if segmentedOutlet.selectedSegmentIndex == 2 {
            
            self.doctors.reverse()
            
            listDoctorTableView.reloadData()
            
        } else if segmentedOutlet.selectedSegmentIndex == 0 {
            
            self.doctors.sort(by: { $0.fullname < $1.fullname } )
            
            listDoctorTableView.reloadData()
        }
    }
}


