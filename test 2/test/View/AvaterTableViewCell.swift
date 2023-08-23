//
//  AvaterTableViewCell.swift
//  test
//
//  Created by adam on 2023/8/16.
//

import UIKit
import RxSwift

class AvaterTableViewCell:UITableViewCell {
    
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var avatarBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model:AvaterCellViewModel?
    var disposeBag = DisposeBag()

    override  func awakeFromNib() {
        imageRelay.asObservable()
            .subscribe(onNext: { [weak self] image in
                self?.avatarBtn.setImage(image, for: .normal)
            })
            .disposed(by: disposeBag)
        
        colorRelay.asObservable()
            .subscribe(onNext: { [weak self] color in
                self?.colorImageView.image = UIImage.from(color: color ?? UIColor.clear)
            })
            .disposed(by: disposeBag)
    }
    

    
    @IBAction func click(_ sender: Any) {
        self.model?.imageSubject?.onNext(true)
    }
    
}
extension AvaterTableViewCell:ReactiveView {
    func provide(model: Any) {
        self.model = model as? AvaterCellViewModel
        self.titleLabel?.text = self.model?.name
    }
}



extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
 
}
