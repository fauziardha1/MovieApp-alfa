//
//  ReviewCell.swift
//  Alfagift-MovieApp
//
//  Created by FauziArda on 10/01/23.
//

import Foundation
import UIKit

class ReviewCell: UITableViewCell {
    static let  id = reviewCellID
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(iconImage)
        addSubview(titleLabel)
        addSubview(descLabel)
        backgroundColor = .darkGray.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 50),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError(coderErrMessage)
    }
}
