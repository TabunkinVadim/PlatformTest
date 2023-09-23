//
//  TableViewCell.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 21.09.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    private let image = UIFactory().addImage(imageNamed: "image",
                                             cornerRadius: 0,
                                             borderWidth: 0,
                                             borderColor: nil,
                                             clipsToBounds: true,
                                             contentMode: .scaleAspectFill,
                                             tintColor: .none,
                                             backgroundColor: nil)

    private let name = UIFactory().addBoldTextLable(lable: "",
                                                    textColor: .textColor,
                                                    textSize: 15,
                                                    textAlignment: .left)

    private let about = UIFactory().addRegularTextLable(lable: "",
                                                        textColor: .statusTextColor,
                                                        textSize: 15,
                                                        textAlignment: .left)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell (image: UIImage, name: String, about: String) {
        self.image.image = image
        self.name.text = name
        self.about.text = about
    }
    
    private func layout() {
        contentView.addSubviews(image, name, about)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60)
        ])

        NSLayoutConstraint.activate([
            about.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            about.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            about.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60)
        ])
    }
}
