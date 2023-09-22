//
//  ViewController.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 21.09.2023.
//

import UIKit

class ViewController: UIViewController {


    var loadMoreStatus = false
    var characters: [CharacterModel] = []
    lazy var tableView: UITableView = {
        $0.toAutoLayout()
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layout()
        requestUrl(chracter: 1)

    }

    func requestUrl(chracter:Int) {
        if !loadMoreStatus {
            self.loadMoreStatus = true
            guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(chracter)" ) else { return}
            let sessions = URLSession.shared
            let task = sessions.dataTask(with: url ){data, response, error in
                guard let data = data else { return }
                do {
                    var character = try JSONDecoder().decode(CharacterModel.self, from: data)
                    guard let url = URL(string: character.imageURL ) else { return}
                    let sessions = URLSession.shared
                    let task = sessions.dataTask(with: url ){data, response, error in
                        guard let data = data else { return }
                        do {
                            guard let image = UIImage(data: (data)) else {
                                return}
                            character.image = image
                            self.characters.append(character)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.loadMoreStatus = false
                            }
                        }
                    }
                    task.resume()
                    //                }
                } catch let error  {
                    print(error)
                }
            }
            task.resume()
        }

    }

    //    func loadMore() {
    //        if !loadMoreStatus  {
    //            self.loadMoreStatus = true
    //            requestUrl(chracter: characters.count)
    //                self.loadMoreStatus = false
    //                self.tableView.reloadData()
    //            }
    //
    //    }

    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        if deltaOffset <= 0 {
        }
        requestUrl(chracter: characters.count+1)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRows = 0
        numberRows = self.characters.count
        return numberRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = TableViewCell()
        cell = tableView.dequeueReusableCell( withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.setupCell(image: characters[indexPath.row].image,
                       name: characters[indexPath.row].name,
                       about: characters[indexPath.row].species)
        return cell

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        if section == 0 {
    //            header.setProfileHeader(nickName: user.nickName, name: user.fullName, avatar: user.avatar, profession: user.profession, numberOfPublications: user.numberOfPublications, numberOfScribes: user.numberOfScribes, numberOfSubscriptions: user.numberOfSubscriptions, isFriend: self.isFriend)
    //        }
    //        return header
    //    }

    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        if section == 0 {
    //            if isFriend {
    //                return 250
    //            } else  {
    //                return 360
    //            }
    //        } else {
    //            return 0
    //        }
    //    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var autiHeight:CGFloat {
            UITableView.automaticDimension
        }
        return autiHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            //            coordinator?.photoVC(user: self.user, isFriend: isFriend)
            //            feedCoordinator?.photoVC(user: self.user, isFriend: isFriend)

        } else {
            //            coordinator?.PostVC(post: self.user.userPosts[indexPath.row], user: self.user)
            //            feedCoordinator?.PostVC(post: self.user.userPosts[indexPath.row], user: self.user)
        }
    }
}
