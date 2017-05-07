//
//  Doctor.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/23/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit
import Firebase
class Doctor {
    
    // Get a reference to the storage service using the default Firebase App
    let storage = FIRStorage.storage()
    
    // Create a storage reference from our storage service
    
    
    
    var _fullname: String!
    var _address: String!
    var _phone: String!
    var _mobile: String!
    var _specialists: NSArray!
    var _image: UIImage!
    var _longitude: Double!
    var _latitude: Double!
    var _imageUrl: String!
    
    var fullname: String {
        if _fullname == nil {
            _fullname = ""
        }
        return _fullname
    }
    
    var address: String {
        if _address == nil {
            _address = ""
        }
        return _address
    }
    
    var phone: String {
        if _phone == nil {
            _phone = ""
        }
        return _phone
    }
    
    var mobile: String {
        if _mobile == nil {
            _mobile = ""
        }
        return _mobile
    }
    
    var specialists: NSArray {
        if _specialists == [] {
            _specialists = []
        }
        return _specialists
    }
    
    var image: UIImage {
        if _image == nil {
            _image = UIImage(named: "doctor-m")
        }
        return _image
    }
    
    var longitude: Double {
        if _longitude == nil {
            _longitude = 0.0
        }
        return _longitude
    }
    
    var latitude: Double {
        if _latitude == nil {
            _latitude = 0.0
        }
        return _latitude
    }
    
    var imageUrl: String {
        if _imageUrl == nil {
            _imageUrl = "doctor-m"
        }
        return _imageUrl
    }
    
    init(doctorDict: NSDictionary) {

        self._fullname = doctorDict["fullname"] as? String
        
        self._address = doctorDict["address"] as? String
        
        self._phone = doctorDict["phone"] as? String
        
        self._mobile = doctorDict["mobile"] as? String
        
        self._latitude = doctorDict["latitude"] as? Double
        
        self._longitude = doctorDict["longitude"] as? Double
        
        if let specialist = doctorDict["specialists"] as? NSDictionary {
            
            self._specialists = specialist.allKeys as NSArray
            
        } else {
            
            self._specialists = []
        }
        self._imageUrl = doctorDict["imageUrl"] as? String
        
        downloadDoctorImage()
        
    }
    
    func downloadDoctorImage() {
        let ref = FIRStorage.storage().reference(forURL: imageUrl)
        ref.data(withMaxSize: 2 * 512 * 512, completion: { (data, error) in
            if error != nil {
                print("ZAK: Unable to download image form FIR")
            } else {
                print("ZAK: imgae downloaded successfuly")
                if let imgData = data {
                    if let img = UIImage(data: imgData) {
                        self._image = img
    //                    self.doctorImage.image = img
    //                    ListDoctorsViewController.imageCache.setObject(img, forKey: imageUrl as NSString)
                    }
                }
            }
            
            }
        )
        
        
    }
    
}
