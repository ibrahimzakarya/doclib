//
//  MyProfileViewController.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/15/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import InteractiveSideMenu

class MyProfileViewController: MenuItemContentViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userAddressTextField: UITextField!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    var cities: [String] = [String]()
    let userID = FIRAuth.auth()!.currentUser!.uid
    
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {
        showMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCities()
        
        cityPicker.delegate = self
        
        cityPicker.dataSource = self
        
        ref.child("users").child("\(self.userID)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let value = snapshot.value as? NSDictionary {
                
                if let address = value.value(forKey: "Address1") as? String {
                    
                    self.userAddressTextField.text = address
                }
                
                if let fullname = value.value(forKey: "FullName") as? String {
                    
                    self.fullnameTextField.text = fullname
                }
                
                if let phone = value.value(forKey: "Phone") as? String {
                    
                    self.phoneNumberTextField.text = phone
                }
                
                if let mobile = value.value(forKey: "Mobile") as? String {
                    
                    self.mobileNumberTextField.text = mobile
                }
                
                if let dateofbirth = value.value(forKey: "dateofbirth") as? String {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM d, yyyy"
                    let date = dateFormatter.date(from: dateofbirth)
                    print(date ?? "")
                    self.dateOfBirthPicker.date = date!
                    
                }
            }
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row].capitalized
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // ggh
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let newDate = dateFormatter.string(from: dateOfBirthPicker.date)
        
        print(newDate)
        
        let post =
            [
                "Address1": userAddressTextField.text!,
                "FullName": fullnameTextField.text!,
                "Mobile": mobileNumberTextField.text!,
                "Phone": phoneNumberTextField.text!,
                "dateofbirth": newDate,
                "City": self.cities[cityPicker.selectedRow(inComponent: 0)]
                
                ] as [String : String]
        
        let childUpdates = ["/users/\(self.userID)": post]
        
        ref.updateChildValues(childUpdates)
        
        let alertController = UIAlertController(title: "Done", message: "Data saved succesfuly.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getCities(){
        
        ref.child("cities").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.cities = value?.allKeys as! [String]
            
            self.cityPicker.reloadAllComponents()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}









