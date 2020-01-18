//
//  TextViewDesignables.swift
//  Zagil
//
//  Created by Apple on 17/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

@IBDesignable class TextViewWithInsets: UITextView {

    @IBInspectable var topInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: topInset, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }

    @IBInspectable var bottmInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: bottmInset, right: self.contentInset.right)
        }
    }

    @IBInspectable var leftInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: leftInset, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }

    @IBInspectable var rightInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: self.contentInset.bottom, right: rightInset)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
