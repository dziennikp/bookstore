//
//  BookstoreViewController.swift
//  Bookstore
//
//  Created by Paweł Dziennik on 19/07/2019.
//

import Foundation
import RxSwift
import RxCocoa
import EasyPeasy

public class BookstoreViewController: UIViewController {
    private let store: BookstoreStore
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private var viewModel: BookstoreViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    public init() {
        store = BookstoreStore()
        super.init(nibName: nil, bundle: nil)
        store.viewModelRelay.subscribe(onNext: { [weak self] viewModel in
            self?.viewModel = viewModel
        }).disposed(by: disposeBag)
        store.createViewModel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        view.addSubview(button)
        button.backgroundColor = .red
        button.easy.layout(Top(50), Left(), Size(50))
    
        view.addSubview(tableView)
        tableView.easy.layout(Top(10).to(button), Left(), Right(), Bottom())
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseIdentifier())
        
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.store.createViewModel()
        }).disposed(by: disposeBag)
    }
}

extension BookstoreViewController : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.books.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel?.books.indices.contains(indexPath.row) == true ,
            let book = viewModel?.books[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseIdentifier(), for: indexPath) as? BookCell else { return UITableViewCell() }
        cell.configure(with: book)
        return cell
        
    }
    
}
