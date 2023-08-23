//
//  NameCellViewModel.swift
//  test
//
//  Created by adam on 2023/8/18.
//

import Foundation
import RxSwift

struct NameCellViewModel:BaseViewModel {
    var cellClass: UITableViewCell.Type =  NameTableViewCell.self
    var height: CGFloat = 100
    let labelTitleString: String
    let name: String
    let nameObject:PublishSubject<String>
}

extension NameCellViewModel: Hashable {
    static func == (lhs: NameCellViewModel, rhs: NameCellViewModel) -> Bool {
        lhs.labelTitleString == rhs.labelTitleString
    }
    
  
    func hash(into hasher: inout Hasher) {
        hasher.combine(labelTitleString)
    }
}
