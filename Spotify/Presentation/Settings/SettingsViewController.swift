//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 07/04/2024.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - Properties
    var sections : [Section] = []
    //MARK: - UIElements
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.width, height: view.height - 50)
    }
    //MARK: - Functions
    private func setup(){
        self.title = "Settings"
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .always
        tableView.delegate = self
        tableView.dataSource = self
        configUIElements()
    }
    private func configUIElements(){
        sections.append(Section(title: "Profile", row: [
            Row(title: "View Profile", handler: { [weak self] in
                let vc = ProfileViewController()
                vc.navigationItem.largeTitleDisplayMode = .never
                vc.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc,animated: true)
            })
        ]))
        sections.append(Section(title: "Account", row: [
            Row(title: "Preferneces", handler: { 
                    print("Pref Tapped")
            }),
            Row(title: "Downloads", handler: {
                print("Downloads Tapped")
            }),
            Row(title: "Sign Out", handler: {
                print("Sign Out Tapped")
            })
        ]))
    print(sections)
    }
}
//MARK: - Table View Delegate Methods
extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = sections[indexPath.section].row[indexPath.row]
        selectedRow.handler()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - Table View DataSource Methods
extension SettingsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].row[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = row.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
}

