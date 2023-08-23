//
//  EmailTableViewCell.swift
//  test
//
//  Created by adam on 2023/8/18.
//

import UIKit
import RxSwift
import RxCocoa

class EmailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var disposeBag = DisposeBag()
    var model:EmailCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        nameTF.rx.text.subscribe(onNext: {[weak self] text in
            guard let text = text else { return }
            self?.model?.nameObject.onNext(text)
          
        }).disposed(by: disposeBag)
    }
}

extension EmailTableViewCell:ReactiveView {
    func provide(model: Any) {
        self.model = model as? EmailCellViewModel
        self.titleLabel?.text = self.model?.labelTitleString
    }
}
