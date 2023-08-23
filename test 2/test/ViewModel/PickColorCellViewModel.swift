//
//  PickColorCellViewModel.swift
//  test
//
//  Created by adam on 2023/8/18.
//

import Foundation
import RxSwift

struct PickColorCellViewModel: Hashable,BaseViewModel {
    
    var cellClass:UITableViewCell.Type = PickColorTableViewCell.self
    let name:String
    var height: CGFloat = 80
    let pickSubject:PublishSubject<Bool>?
    init(name: String, pickSubject: PublishSubject<Bool> ) {
        self.name = name
        self.pickSubject = pickSubject
    }
}

extension PickColorCellViewModel {
    static func == (lhs: PickColorCellViewModel, rhs: PickColorCellViewModel) -> Bool {
        lhs.name == rhs.name
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
