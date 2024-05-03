//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 06/04/2024.
//

import UIKit
import SDWebImage
class ProfileViewController: UIViewController , ProfileViewModelDelegate {

    //MARK: - Properties
    private let viewModel : ProfileViewModel = ProfileViewModel()
    private var dataModel : [String] = []

    //MARK: - UIElements
    private  var label : UILabel = {
        var label = UILabel()
        label.textColor = .accent
        return label
    }()
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .background
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds

    }
    //MARK: - Functions
    func setup(){
        self.viewModel.getUserData()
        self.title = "Profile"
        view.backgroundColor = .background
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        viewModel.delegate = self
        createProfileImage()
    }
    func createProfileImage(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 1.5))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 2))
        if let url = viewModel.userData?.images?.first?.url{
            imageView.sd_setImage(with: URL(string: url), completed: nil)
        }else{
            imageView.image = UIImage(named: "spot-logo")
        }
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        tableView.tableHeaderView = headerView
    }
    func updateUI() {
        guard let userData = viewModel.userData else{
            return
        }
        self.dataModel.append("Full Name : \(userData.displayName ?? "")")
        self.dataModel.append("Email Addresse : \(userData.email ?? "")")
        self.dataModel.append("User Id : \(userData.id ?? "")")
        self.dataModel.append("Plan : \(userData.type ?? "")")
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func errorOccured(error: String) {
        Utilities.errorALert(title: "Oops", message:error , actionTitle: "Ok", action: {}, vc: self)
        tableView.isHidden = true
        label.text = error
        label.center = view.center
        view.addSubview(label)
  
    }
}
//MARK: - Table View DataSource METHODS
extension ProfileViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataModel[indexPath.row]
        return cell
    }
    
}
//MARK: - Table View Delegate METHODS

extension ProfileViewController  :UITableViewDelegate {
    
}
