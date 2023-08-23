//
//  RegisterTableViewController.swift
//  test
//
//  Created by adam on 2023/8/16.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

let imageRelay = BehaviorRelay<UIImage?>(value: nil)
let colorRelay = BehaviorRelay<UIColor?>(value: nil)

final class RegisterTableViewController: UIViewController {
    
    
    var fistName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var imageUrl = ""

    lazy var tableView = UITableView(frame: UIScreen.main.bounds)
    var disposeBag = DisposeBag()
    var callback:((UIImage?)->())?
    lazy var viewModel = RegisterTableViewModel(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.black
        tableView.dataSource = viewModel.makeDiffableDataSource()
        tableView.keyboardDismissMode =  .onDrag
        bindViewModel()
    }
    
    private func bindViewModel() {

 
        viewModel.imageSubject.subscribe { [weak self] value in
            guard let self = self else { return }
            self.presentImagePickerController(.photoLibrary)
            self.callback = { image in
                imageRelay.accept(image)
            }
//            还可以设置这个属性重新刷新
//            viewModel.avatarData
        }.disposed(by: disposeBag)
        
        viewModel.nameSubject.subscribe {[weak self]  value in
            self?.fistName = value
        } onError: { err in
            
        } onCompleted: {
            
        }.disposed(by: disposeBag)
        
        viewModel.lastNameSubject.subscribe { [weak self] value in
            self?.lastName = value
        }.disposed(by: disposeBag)
        
        viewModel.phoneSubject.subscribe { [weak self] value in
            self?.phoneNumber = value
        }.disposed(by: disposeBag)
        
        viewModel.emailSubject.subscribe { [weak self] value in
            self?.email = value
        }.disposed(by: disposeBag)
        
        viewModel.pickColorSubject.subscribe { [weak self] value in
            guard let self = self else { return }
            ImagePickViewController.show(with: self) { color in
                colorRelay.accept(color)
            }
        }.disposed(by: disposeBag)
        
        
        viewModel.signUpSubject.subscribe { [weak self] value in
            guard let self = self else { return }
            let dic = ["fistName":self.fistName,
                       "lastName":self.lastName,
                       "email":self.email,
                       "phoneNumber":self.phoneNumber,
                       "imageUrl":self.imageUrl]
            self.viewModel.loginObserverbal(parameters: dic).subscribe(onNext: { _ in
//                   上传完成
                print("上传参数为\(dic)")
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}

extension RegisterTableViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func presentImagePickerController(_ sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let pickerCamera = UIImagePickerController()
            pickerCamera.allowsEditing = true
            pickerCamera.sourceType = sourceType
            pickerCamera.delegate = self
            self.present(pickerCamera, animated: true, completion: nil)
        } else {
            //        let text = sourceType == .camera ? "请打开相机访问权限" : "请打开相册访问权限"
        }
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: { [weak self] in
            let editImage = info[.editedImage] as! UIImage
            self?.callback?(editImage)
          }
        )
    
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}
