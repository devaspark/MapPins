//
//  MapVC.swift
//  MapPins
//
//  Created by Rex Kung on 1/13/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//
//  Map Icon by Delwar Hossain from the Noun Project

import UIKit
import MapKit
import SwiftyJSON

class MapVC: UIViewController {

    @IBOutlet weak var screenCoverButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuCurve: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var dispAnnoButton: UIButton!
    @IBOutlet weak var rmvAnnoButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dirWalkButton: UIButton!
    @IBOutlet weak var dirCarButton: UIButton!
    @IBOutlet weak var hideMenuButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //menuCurve.image = #imageLiteral(resourceName: "MenuCurve")
    
        hideMenu()
    }

    @IBAction func menuBtnPressed(_ sender: Any) {
        showMenu()
    }
    
    @IBAction func hideMenuBtnPressed(_ sender: Any) {
        hideMenu()
    }
    
    @IBAction func screenCoverTapped(_ sender: UIButton) {
        hideMenu()
    }
    
    func showMenu() {
        menuView.isHidden = false
        
        UIView.animate(withDuration: 0.7, animations: {
            self.screenCoverButton.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.06, options: .curveEaseOut, animations: {
            self.menuCurve.transform = .identity
        })
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.rmvAnnoButton.transform = .identity
            self.searchButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.06, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.dispAnnoButton.transform = .identity
            self.dirWalkButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.12, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = .identity
            self.dirCarButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.18, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImg.transform = .identity
            self.hideMenuButton.transform = .identity
        })
    
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.7, animations: {
            self.screenCoverButton.alpha = 0
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImg.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.hideMenuButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.08, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.dirCarButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.16, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.dispAnnoButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.dirWalkButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.08, options: .curveEaseOut, animations: {
            self.menuCurve.transform = CGAffineTransform(translationX: -self.menuCurve.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.21, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.rmvAnnoButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.searchButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        }) { success in
            self.menuView.isHidden = true
        }
    }

}

