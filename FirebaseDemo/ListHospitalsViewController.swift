//
//  ListHospitalsViewController.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 5/2/17.
//  Copyright © 2017 chacha. All rights reserved.
//


import UIKit
import Firebase

class ListHospitalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var listHospitalsTabelView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    @IBAction func segmentedView(_ sender: UISegmentedControl) {
    }
    var ref = FIRDatabase.database().reference()
    
    var docCell = DoctorCell()
    var doctor: Doctor!
    var hospitals = [Doctor]()
    var filteredHospitals = [Doctor]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listHospitalsTabelView.delegate = self
        
        listHospitalsTabelView.dataSource = self
        
        downloadHospitalsData()
        
        searchBarOutlet.delegate = self
        
        searchBarOutlet.returnKeyType = UIReturnKeyType.done
    }
    
    func downloadHospitalsData() {
        
        ref.child("hospital").observe(.value, with: { snapshot in
            
            let enumerator = snapshot.children
            
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                
                let hospitalId = rest.key
                
                if let child = rest.value as? NSDictionary {
                    
                    let hospital = Doctor(doctorDict: child)
                    
                    self.hospitals.append(hospital)
                }
                self.listHospitalsTabelView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var hospital: Doctor!
        
        if inSearchMode {
            
            hospital = filteredHospitals[indexPath.row]
            
        } else {
            
            hospital = hospitals[indexPath.row]
        }
        
        performSegue(withIdentifier: "DoctorDetailsVC", sender: hospital)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listHospitalsTabelView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as! DoctorCell
        
        let doctor: Doctor!
        
        if inSearchMode {
            
            doctor = filteredHospitals[indexPath.row]
            
            cell.configureCell(doctor: doctor)
            
        } else {
            
            doctor = hospitals[indexPath.row]
            
            cell.configureCell(doctor: doctor)
            
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredHospitals.count
        }
        return hospitals.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBarOutlet.text == nil || searchBarOutlet.text == "" {
            
            inSearchMode = false
            
            listHospitalsTabelView.reloadData()
            
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBarOutlet.text!
            
            filteredHospitals = hospitals.filter({ ($0.fullname.range(of: lower) != nil) })
            
            listHospitalsTabelView.reloadData()
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
}



