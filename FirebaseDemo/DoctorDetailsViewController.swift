//
//  DoctorDetailsViewController.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/29/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit

class DoctorDetailsViewController: UIViewController {
    
    @IBOutlet weak var fullnameLabel: UILabel!
    var doctor: Doctor!
    
    @IBOutlet weak var doctorImage: UIImageView!

    @IBOutlet weak var specialistsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        fullnameLabel.text = doctor.fullname
        
        self.navigationItem.title = doctor.fullname

        doctorImage.image = doctor.image
        
        specialistsLabel.text = doctor.specialists.componentsJoined(by: " - ")
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MapVC" {
            
            if let mapVC = segue.destination as? MapViewController {
                
                if let doctor = sender as? Doctor {
                    
                    mapVC.doctor = doctor
                }
            }
        }
    }

    @IBAction func showDoctorLocationPressed(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "MapVC", sender: doctor)
    }
    
    
}
