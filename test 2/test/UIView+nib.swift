//
//  UIView+nib.swift
//  SwiftDemo
//
//  Created by ABC on 2021/11/2.
//

import UIKit

extension UIView {
    
    class func fromNib() -> Self {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: nibName(), ofType: "nib")
        guard let _ = path else { return Self.init() }
        let array = bundle.loadNibNamed(nibName(), owner: nil, options: nil) as! [UIView]
        for item in array {
            if item.isMember(of: Self.self) {
                return item as! Self
            }
        }
        return Self.init()
    }
    
    class func nibName() -> String {
        let className = NSStringFromClass(self)
        return className.contains(".") ? className.components(separatedBy: ".").last! : className
    }
    
    class func nib() -> UINib? {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: self.nibName(), ofType: "nib")
        guard let _ = path else { return nil }
        return UINib(nibName: self.nibName(), bundle: bundle)
    }
}

protocol NibLoadable {}
extension UIView : NibLoadable {}
extension NibLoadable where Self : UIView {
    static func loadFromNib() -> Self {
        return nib()?.instantiate(withOwner: self, options: nil).first as! Self
    }
}

