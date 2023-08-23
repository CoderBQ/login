//
//  NameTableViewCell.swift
//  test
//
//  Created by adam on 2023/8/16.
//

import UIKit
import RxSwift
import RxCocoa
class NameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    var disposeBag = DisposeBag()
    var model:NameCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
   

        nameTF.rx.text.subscribe(onNext: {[weak self] text in
            guard let text = text else { return }
            self?.model?.nameObject.onNext(text)
          
        }).disposed(by: disposeBag)
    }
}

extension NameTableViewCell:ReactiveView {
    func provide(model: Any) {
        self.model = model as? NameCellViewModel
        self.titleLabel?.text = self.model?.labelTitleString
    }
}
