//
//  EmailCellViewModel.swift
//  test
//
//  Created by adam on 2023/8/18.
//


import Foundation
import RxSwift

struct EmailCellViewModel:BaseViewModel {
    var cellClass: UITableViewCell.Type =  EmailTableViewCell.self
    var height: CGFloat = 100
    let labelTitleString: String
    let name: String
    let nameObject:PublishSubject<String>
}

extension EmailCellViewModel: Hashable {
    static func == (lhs: EmailCellViewModel, rhs: EmailCellViewModel) -> Bool {
        lhs.labelTitleString == rhs.labelTitleString
    }
    
  
    func hash(into hasher: inout Hasher) {
        hasher.combine(labelTitleString)
    }
}
