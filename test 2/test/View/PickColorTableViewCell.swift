//
//  PickColorTableViewCell.swift
//  test
//
//  Created by adam on 2023/8/17.
//


import UIKit
import RxSwift

class PickColorTableViewCell:UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var model:PickColorCellViewModel?
    var disposeBag = DisposeBag()
    

    
    @IBAction func click(_ sender: Any) {
        self.model?.pickSubject?.onNext(true)
    }
    
}
extension PickColorTableViewCell:ReactiveView {
    func provide(model: Any) {
        self.model = model as? PickColorCellViewModel
        self.titleLabel?.text = self.model?.name

    }
 
}

protocol ReactiveView {
    func provide(model: Any)
}
