//
//  SignUpTableViewCell.swift
//  test
//
//  Created by adam on 2023/8/17.
//

import UIKit
import RxSwift

class SignUpTableViewCell: UITableViewCell {

    var model:SignUpCellViewModel?
    var disposeBag = DisposeBag()

    override  func awakeFromNib() {
      
    }
    
  
    
    @IBAction func click(_ sender: Any) {
        self.model?.signUpSubject?.onNext(true)
    }
    
}
extension SignUpTableViewCell:ReactiveView {
    func provide(model: Any) {
        self.model = model as? SignUpCellViewModel
    }
}
