//
//  DoctorCell.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/21/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit
import Firebase

class DoctorCell: UITableViewCell {
    
    var ref = FIRDatabase.database().reference()
    var doctorsRef = FIRDatabase.database().reference().child("doctors")
    
    
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorSpecialtyLabel: UILabel!
    @IBOutlet weak var doctorAddressLabel: UILabel!
    @IBOutlet weak var doctorPhoneLabel: UILabel!
    
    func configureCell(doctor: Doctor, img: UIImage? = nil) {
        
        doctorImage.image = doctor.image
        doctorNameLabel.text = doctor.fullname
        doctorPhoneLabel.text = doctor.mobile + " - " + doctor.phone
        doctorAddressLabel.text = doctor.address
        doctorSpecialtyLabel.text = doctor.specialists.componentsJoined(by: " - ")
        doctorImage.image = doctor.image
        
//        if img != nil {
//            self.doctorImage.image = img
//            
//        } else {
//            let ref = FIRStorage.storage().reference(forURL: doctor.imageUrl)
//            ref.data(withMaxSize: 2 * 512 * 512, completion: { (data, error) in
//                if error != nil {
//                    print("ZAK: Unable to download image form FIR")
//                } else {
//                    print("ZAK: imgae downloaded successfuly")
//                    if let imgData = data {
//                        if let img = UIImage(data: imgData) {
//                            self.doctorImage.image = img
//                            ListDoctorsViewController.imageCache.setObject(img, forKey: doctor.imageUrl as NSString)
//                        }
//                    }
//                }
//                
//                }
//            )
//            
//        }
    }
}
