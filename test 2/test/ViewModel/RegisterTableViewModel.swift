
import UIKit
import RxSwift
open class RegisterTableViewModel: NSObject {
    typealias Datasource = UITableViewDiffableDataSource<Section, Item>
    private var diffableDataSource: Datasource!
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable {
        case sectionOne
    }

    
    enum Item: Hashable {
        case avatar(AvaterCellViewModel)
        case firstName(NameCellViewModel)
        case lastName(NameCellViewModel)
        case phoneNumber(NameCellViewModel)
        case email(EmailCellViewModel)
        case signUp(SignUpCellViewModel)
        case pickColor(PickColorCellViewModel)
        var height: Double {
            switch self {
            case .avatar(let dataModel):
                return dataModel.height
            case .firstName(let dataModel):
                return dataModel.height
            case .lastName(let dataModel):
                return dataModel.height
            case .phoneNumber(let dataModel):
                return dataModel.height
            case .signUp(let dataModel):
                return dataModel.height
            case .pickColor(let dataModel):
                return dataModel.height
            case .email(let dataModel):
                return dataModel.height
            }
        }
        var cellClass: UITableViewCell.Type {
            switch self {
            case .avatar(let dataModel):
                return dataModel.cellClass
            case .firstName(let dataModel):
                return dataModel.cellClass
            case .lastName(let dataModel):
                return dataModel.cellClass
            case .phoneNumber(let dataModel):
                return dataModel.cellClass
            case .signUp(let dataModel):
                return dataModel.cellClass
            case .pickColor(let dataModel):
                return dataModel.cellClass
            case .email(let dataModel):
                return dataModel.cellClass
            }
        }
        func getData() -> Any {
                switch self {
                case .avatar(let data):
                    return data
                case .firstName(let data):
                    return data
                case .lastName(let data):
                    return data
                case .phoneNumber(let data):
                    return data
                case .signUp(let data):
                    return data
                case .pickColor(let data):
                    return data
                case .email(let data):
                    return data
                }
            }
     
    }
    
    let nameSubject:PublishSubject<String> = PublishSubject<String>()
    let lastNameSubject:PublishSubject<String> = PublishSubject<String>()
    let phoneSubject:PublishSubject<String> = PublishSubject<String>()
    let emailSubject = PublishSubject<String>()
    let imageSubject:PublishSubject<Bool> = PublishSubject<Bool>()
    let signUpSubject:PublishSubject<Bool> = PublishSubject<Bool>()
    let pickColorSubject:PublishSubject<Bool> = PublishSubject<Bool>()
    
	private weak var tableView: UITableView?
	
    var avatarData: AvaterCellViewModel {
        return AvaterCellViewModel(name: "Avatar", imageSubject: imageSubject )
    }
    
    var firstNameData: NameCellViewModel {
        return NameCellViewModel(labelTitleString: "First Name", name: "", nameObject: nameSubject)
    }
    var lastNameData: NameCellViewModel {
        return NameCellViewModel(labelTitleString: "Last Name", name: "", nameObject: lastNameSubject)
    }
    
    var phoneNumberData: NameCellViewModel {
        return NameCellViewModel(labelTitleString: "Phone Number", name: "", nameObject: phoneSubject)
    }
    
    var emailData: EmailCellViewModel {
        return EmailCellViewModel(labelTitleString: "Email", name: "", nameObject: emailSubject)
    }
    
    var signUpData: SignUpCellViewModel {
        return SignUpCellViewModel(signUpSubject: signUpSubject)
    }
    
    var pickColorData: PickColorCellViewModel {
        return PickColorCellViewModel(name: "Custom Avatar Color", pickSubject: pickColorSubject )
    }
    
	public init(tableView: UITableView) {
		self.tableView = tableView
		super.init()
	}

	

    func cellProvider(_ tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? {

        
        let item = diffableDataSource.itemIdentifier(for: indexPath)
        let cellClass = item?.cellClass ?? UITableViewCell.self
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(cellClass) , for: indexPath)
        if  let data = item?.getData() {
            if let cell = cell as? ReactiveView {
                cell.provide(model: data)
            }
        }
        return cell

    }
}

extension RegisterTableViewModel {
        
        func makeDiffableDataSource() -> UITableViewDiffableDataSource<Section, Item> {
            guard let tableView = self.tableView else { fatalError("TableView should exist but doesn't") }
            
            let diffableDataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView, cellProvider: cellProvider)
            
            self.diffableDataSource = diffableDataSource
            self.tableView = tableView
            self.tableView?.delegate = self
            diffableDataSource.apply(snapshot(), animatingDifferences: false)
            return diffableDataSource
        }
        
    func snapshot() -> Snapshot {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.sectionOne])
        snapshot.appendItems([.avatar(avatarData)], toSection: .sectionOne)
        
        snapshot.appendItems([.firstName(firstNameData), .lastName(lastNameData),.phoneNumber(phoneNumberData)], toSection: .sectionOne)
        snapshot.appendItems([.email(emailData)], toSection: .sectionOne)
        snapshot.appendItems([.pickColor(pickColorData)], toSection: .sectionOne)
        snapshot.appendItems([.signUp(signUpData)], toSection: .sectionOne)
        let items =  snapshot.itemIdentifiers
        items.forEach { item in
            let cellClass = item.cellClass
            tableView?.register(cellClass.nib(), forCellReuseIdentifier: NSStringFromClass(cellClass))

        }
        return snapshot
    }

}

extension RegisterTableViewModel: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = diffableDataSource.itemIdentifier(for: indexPath)
        return  item?.height ?? 0
    }
}

extension RegisterTableViewModel {
    
    func loginObserverbal(parameters: [String : Any]) -> Observable<String> {
        return Observable<String>.create { observer in
            //        NetWorkRequest(APISetting.removeLogin) { response in
            observer.onNext("response")
            observer.onCompleted()
            //        } failureCallback: { error in
            //            observer.onError(error)
            //            self.toast.onNext(error.localizedDescription)
            //        }
            return Disposables.create()
        }
    }
    
}

