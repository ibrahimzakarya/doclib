//
//  HomeViewController.swift
//  FirebaseTutorial
//
//  Created by James Dacombe on 16/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import InteractiveSideMenu

class HomeViewController: MenuItemContentViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    var ref = FIRDatabase.database().reference()
    
    
    @IBAction func sideMenuButtonPressed(_ sender: UIButton) {

    }
    
    @IBAction func listDoctorsPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "ListDoctors", sender: self)
    }
    
    @IBAction func myProfilePressed(_ sender: AnyObject) {
        //performSegue(withIdentifier: "MyProfile", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//           // let user = User.init(username: username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutAction(sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
