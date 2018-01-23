//
//  DesignableView.swift
//  MapPins
//
//  Created by Rex Kung on 1/23/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
