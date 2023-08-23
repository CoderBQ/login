//
//  AvaterCellViewModel.swift
//  test
//
//  Created by adam on 2023/8/18.
//


import UIKit
import RxSwift

struct AvaterCellViewModel: Hashable,BaseViewModel {
    
    var cellClass:UITableViewCell.Type = AvaterTableViewCell.self
    var height: CGFloat = 110
    var name:String
    let imageSubject:PublishSubject<Bool>?
    init(name: String, imageSubject: PublishSubject<Bool> ) {
        self.imageSubject = imageSubject
        self.name = name
    }

    
}

extension AvaterCellViewModel {
    static func == (lhs: AvaterCellViewModel, rhs: AvaterCellViewModel) -> Bool {
        lhs.height == rhs.height
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(height)
    }
}
