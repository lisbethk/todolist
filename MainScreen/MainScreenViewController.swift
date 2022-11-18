import Foundation
import UIKit
import SnapKit

enum MainScreenSection: Hashable {
    case allNotes
}

struct MainScreenItem: Hashable {
    let id: UUID
    let text: String
}

private typealias MainScreenSnapshot = NSDiffableDataSourceSnapshot<MainScreenSection, MainScreenItem>
private typealias MainScreenCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MainScreenItem>
private typealias MainScreenDataSource = UICollectionViewDiffableDataSource<MainScreenSection, MainScreenItem>

protocol MainScreenViewProtocol: AnyObject {
    func show(items: [MainScreenItem])
}

protocol MainScreenViewOutput: AnyObject {
    func viewDidLoad()
    func didTapItem(at index: Int)
    func didTapNewItem()
    func didTapDelete(at index: Int)
}

final class MainScreenViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            UISwipeActionsConfiguration(actions: [
                UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: { action, view, completion in
                        self.output?.didTapDelete(at: indexPath.row)
                        completion(true)
                    }
                )
            ])
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var dataSource = MainScreenDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
        collectionView.dequeueConfiguredReusableCell(
            using: self.cellRegistration,
            for: indexPath,
            item: itemIdentifier
        )
    }
    
    private let cellRegistration = MainScreenCellRegistration { cell, _, item in
        var configuration = cell.defaultContentConfiguration()
        configuration.text = item.text
        configuration.textProperties.numberOfLines = 3
        cell.contentConfiguration = configuration
    }
    
    private var output: MainScreenViewOutput?
    
    init(output: MainScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        output?.viewDidLoad()
    }
    
    private func setUpUI() {
        navigationItem.title = DateService().getTodayDate()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "plus.square"),
            primaryAction: .init(handler: { [weak self] _ in
                self?.output?.didTapNewItem()
            }),
            menu: nil
        )
    }
}

extension MainScreenViewController: MainScreenViewProtocol {

    
    func show(items: [MainScreenItem]) {
        var snapshot = MainScreenSnapshot()
        snapshot.appendSections([.allNotes])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didTapItem(at: indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
