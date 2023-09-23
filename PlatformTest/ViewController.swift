//
//  ViewController.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 21.09.2023.
//

import UIKit

class ViewController: UIViewController {

    var loadMoreStatus = false
    var isLoadFromCoreData = false
    var characters: [CharacterModel] = [] {didSet {
        print("\n \n Save!! \n \n")
        saveInCoreData()
    }}

    lazy var tableView: UITableView = {
        $0.toAutoLayout()
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .backgroundColor
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rick & Morty"
        self.view.backgroundColor = .backgroundColor
        layout()
    }

    func saveInCoreData() {
        for character in characters {
            let coreDataCoordinator = CoreDataCoordinator()
            coreDataCoordinator.seveCharacter(character: character)
        }
    }

    func loadFromCoreData (error: NSError?) {
        if !self.isLoadFromCoreData {
            self.isLoadFromCoreData = true
            self.errorAlert(title: "Error", buttomTitle: "OK", error: error) { _ in
                let coreDataCoordinator = CoreDataCoordinator()
                let countCharacter = coreDataCoordinator.getCharactersCount()
                if countCharacter > 0{
                    for characterID in 0...countCharacter-1 {
                        guard let character = coreDataCoordinator.getCharacter(characterID: characterID) else {return}
                        let ch = CharacterModel(from: character)
                        self.characters.append(ch)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        self.loadMoreStatus = false
    }


    func network (character: Int) {
        if !loadMoreStatus {
            loadMoreStatus = true
            let network = NetworkServise()
            network.requestUrl(character: character) { error in
                self.loadFromCoreData(error: error as NSError?)
            } action: { character in
                self.characters.append(character)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadMoreStatus = false
                }
            }
        }
    }

    func errorAlert (title: String, buttomTitle: String, error: Error?, cancelAction:((UIAlertAction) -> Void)?) {
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            alertStyle = UIAlertController.Style.alert
        }
        let alert: UIAlertController = {
            if let error = error {
                $0.message = error.localizedDescription
            } else { $0.message = "UnknownError" }
            return $0
        }(UIAlertController(title: title, message: "UnknownError" , preferredStyle: alertStyle))

        alert.addAction(UIAlertAction(title: buttomTitle, style: .cancel, handler: cancelAction))
        navigationController?.present(alert, animated: true)
    }

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
        network(character: characters.count+1)
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DescriptionViewController()
        vc.setDescription(avatar: self.characters[indexPath.row].image, name: self.characters[indexPath.row].name, status: self.characters[indexPath.row].status, species: self.characters[indexPath.row].species, gender: self.characters[indexPath.row].gender)
        navigationController?.present(vc, animated: true, completion: .none)
    }
}
