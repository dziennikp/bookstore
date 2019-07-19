//
//  BookCell.swift
//  Bookstore
//
//  Created by Paweł Dziennik on 19/07/2019.
//

import Foundation
import EasyPeasy

class BookCell: UITableViewCell {
    static func reuseIdentifier() -> String {
        return "\(self)"
    }
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let pagesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    private let bookTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.brown
        let container = UIView()
        contentView.addSubview(container)

        container.addSubview(authorLabel)
        container.addSubview(titleLabel)
        container.addSubview(pagesLabel)
        container.addSubview(bookTypeLabel)
        container.easy.layout(Top(), Left(), Right())
        
        authorLabel.easy.layout(Top(), Right(), Left(5) )
        titleLabel.easy.layout(Top(5).to(authorLabel), Left(5), Right())
        pagesLabel.easy.layout(Top(5).to(titleLabel), Left(5), Bottom())
        bookTypeLabel.easy.layout(Top(5).to(titleLabel), Left(10).to(pagesLabel), Right(), Bottom())
        
        let spacer = UIView()
        contentView.addSubview(spacer)

        spacer.backgroundColor = .black
        spacer.easy.layout(Top().to(container), Left(), Right(), Height(5), Bottom())
    }
    
    func configure(with book: BookViewModel) {
        authorLabel.text = book.author
        titleLabel.text = book.identifier
        pagesLabel.text = "\(book.pages)"
        bookTypeLabel.text = book.type.rawValue
    }
}
