//
//  ReusePopup.swift
//  MapPins
//
//  Created by Rex Kung on 1/21/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit
import CoreLocation

class ReusePopup: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    var delegate: LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let origImage = UIImage(named: "location_icon2")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        iconImage.image = tintedImage
        iconImage.tintColor = .white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtnPress(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate!.hideMenu()
        }
    }
    
    @IBAction func submitBtnPress(_ sender: UIButton) {
        
        guard let textName = nameTextField.text, !(nameTextField.text?.isEmpty)!, !(nameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! else {
            return
        }
        
        
        guard let textLoc = locTextField.text, !(locTextField.text?.isEmpty)!, !(locTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! else {
            return
        }
        
        _ = delegate?.InputLocation(locationInput: textLoc, nameInput: textName)
        dismiss(animated: true) {
            self.delegate!.hideMenu()
        }
    }
    
}
