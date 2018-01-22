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
    @IBOutlet weak var locTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var delegate: LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtnPress(_ sender: UIButton) {
        
        guard let text = locTextField.text, !(locTextField.text?.isEmpty)!, !(locTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! else {
            return
        }
        
        _ = delegate?.InputLocation(input: text)
        dismiss(animated: true) {
            self.delegate!.hideMenu()
        }
    }
    
}
