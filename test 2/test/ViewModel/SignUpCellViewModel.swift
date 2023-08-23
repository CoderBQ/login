//
//  SignUpViewModel.swift
//  test
//
//  Created by adam on 2023/8/18.
//

import Foundation
import UIKit
import RxSwift

struct SignUpCellViewModel: Hashable,BaseViewModel {
    
    var cellClass:UITableViewCell.Type = SignUpTableViewCell.self
    var height: CGFloat = 100
    let signUpSubject:PublishSubject<Bool>?

    init( signUpSubject: PublishSubject<Bool>) {
        self.signUpSubject = signUpSubject
    }
    
}

extension SignUpCellViewModel {
    static func == (lhs: SignUpCellViewModel, rhs: SignUpCellViewModel) -> Bool {
        lhs.height == rhs.height
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(height)
    }
}
