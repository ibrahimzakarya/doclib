//
//  HostViewController.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/14/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class HostViewController: MenuContainerViewController {

    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuViewController = self.storyboard!.instantiateViewController(withIdentifier: "NavigationMenu") as! MenuViewController
        
        contentViewControllers = contentControllers()
        
        selectContentViewController(contentViewControllers.first!)
    }
    
    override func menuTransitionOptionsBuilder() -> TransitionOptionsBuilder? {
        return TransitionOptionsBuilder() { builder in
            builder.duration = 0.5
            builder.contentScale = 1
        }
    }
    
    private func contentControllers() -> [MenuItemContentViewController] {
        var contentList = [MenuItemContentViewController]()
        contentList.append(self.storyboard?.instantiateViewController(withIdentifier: "Home") as! MenuItemContentViewController)
//        contentList.append(self.storyboard?.instantiateViewController(withIdentifier: "MyFavorite") as! MenuItemContentViewController)
        contentList.append(self.storyboard?.instantiateViewController(withIdentifier: "MyProfile") as! MenuItemContentViewController)
//        contentList.append(self.storyboard?.instantiateViewController(withIdentifier: "AboutUs") as! MenuItemContentViewController)
        return contentList
    }
}

    


