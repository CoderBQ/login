//
//  ProfileHeaderModel.swift
//  test
//
//  Created by adam on 2023/8/17.
//

import UIKit

protocol BaseViewModel {
    var height: CGFloat { get set }
    var cellClass: UITableViewCell.Type { get set}
}
