//
//  DescriptionViewController.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 22.09.2023.
//

import UIKit


class DescriptionViewController: UIViewController {
    
    private let avatar = UIFactory().addImage(imageNamed: "image",
                                              cornerRadius: 0,
                                              borderWidth: 0,
                                              borderColor: .none,
                                              clipsToBounds: true,
                                              contentMode: .scaleAspectFill,
                                              tintColor: .none,
                                              backgroundColor: .none)

    private let name = UIFactory().addBoldTextLable(lable: "Tom Sanches",
                                                    textColor: .textColor,
                                                    textSize: 50,
                                                    textAlignment: .center)

    private let statusLable = UIFactory().addBoldTextLable(lable: "Status: ",
                                                           textColor: .statusTextColor,
                                                           textSize: 20,
                                                           textAlignment: .left)

    private let status = UIFactory().addRegularTextLable(lable: "Alive",
                                                         textColor: .textColor,
                                                         textSize: 20,
                                                         textAlignment: .left)

    private let speciesLable = UIFactory().addBoldTextLable(lable: "Species: ",
                                                            textColor: .statusTextColor,
                                                            textSize: 20,
                                                            textAlignment: .left)

    private let species = UIFactory().addRegularTextLable(lable: "Human",
                                                          textColor: .textColor,
                                                          textSize: 20,
                                                          textAlignment: .left)

    private let genderLable = UIFactory().addBoldTextLable(lable: "Gender: ",
                                                           textColor: .statusTextColor,
                                                           textSize: 20,
                                                           textAlignment: .left)

    private let gender = UIFactory().addRegularTextLable(lable: "man",
                                                         textColor: .textColor,
                                                         textSize: 20,
                                                         textAlignment: .left)

    func setDescription (avatar: UIImage, name: String, status: String, species: String, gender: String ) {
        self.avatar.image = avatar
        self.name.text = name
        self.status.text = status
        self.species.text = species
        self.gender.text = gender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        layout()
    }

    private func layout() {
        view.addSubviews(avatar, name,statusLable, status, speciesLable, species, genderLable, gender)

        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])

        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            statusLable.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            statusLable.leadingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            status.topAnchor.constraint(equalTo: statusLable.topAnchor),
            status.leadingAnchor.constraint(equalTo: statusLable.trailingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            speciesLable.topAnchor.constraint(equalTo: statusLable.bottomAnchor, constant: 10),
            speciesLable.leadingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            species.topAnchor.constraint(equalTo: speciesLable.topAnchor),
            species.leadingAnchor.constraint(equalTo: speciesLable.trailingAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            genderLable.topAnchor.constraint(equalTo: speciesLable.bottomAnchor, constant: 10),
            genderLable.leadingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            gender.topAnchor.constraint(equalTo: genderLable.topAnchor),
            gender.leadingAnchor.constraint(equalTo: genderLable.trailingAnchor, constant: 8)
        ])


    }
}



