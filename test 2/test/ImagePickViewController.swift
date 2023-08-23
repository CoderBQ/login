//
//  ImagePickViewController.swift
//  test
//
//  Created by adam on 2023/8/17.
//


import UIKit
import IGColorPicker
class ImagePickViewController: UIViewController {
    
    
    @IBOutlet weak var contentViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    
    var confirmBlock : ConfirmBlock = { _ in  }
    typealias ConfirmBlock = ((UIColor) -> (Void))
    var colorPickerView: ColorPickerView!
    var selectColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPickerView = ColorPickerView(frame: self.contentView.bounds)
        contentView.addSubview(colorPickerView)
        colorPickerView.delegate = self
        contentViewBottomCons.constant = -(346 + 24)
        contentView.layer.cornerRadius = 24
        
    }
}


extension ImagePickViewController {
    
    class func show(with target: UIViewController,  confirm: @escaping ConfirmBlock) {
        let presented = target.presentedViewController
        if let _ = presented { return }
        let vc = ImagePickViewController()
        vc.modalPresentationStyle = .custom
        vc.confirmBlock = confirm
        target.present(vc, animated: false, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.contentViewBottomCons.constant = -24;
            UIView.animate(withDuration: 0.25) {
                self.view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func dismiss(_ completion: (() -> Void)? = nil) -> Void {
        contentViewBottomCons.constant = -(346 + 24)
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = UIColor.init(white: 0.5, alpha:0)
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.confirmBlock(self.selectColor ?? UIColor())
            self.dismiss(animated: false, completion: nil)
        }
    }
}
// MARK: - ColorPickerViewDelegate
extension ImagePickViewController: ColorPickerViewDelegate {
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        let colorArray = colorPickerView.colors
        let colorSelect = colorPickerView.indexOfSelectedColor ?? 0
         selectColor = colorArray[colorSelect]
        dismiss(nil)
    }
    
}
