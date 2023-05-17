//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Alex Ochigov on 5/10/23.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        return tableView
    }()
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view.backgroundColor = .systemBackground
        
        view.addSubview(spinner)
        startLoader()
        
        fetchProfile()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

        spinner.center = view.center
        tableView.frame = view.bounds
    }
    
    private func fetchProfile() {
        APIClient.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(model):
                    self?.updateUI(with: model)
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                    break
                }
                
                self?.spinner.stopAnimating()
            }
        }
        
    }
    
    private func startLoader() {
        spinner.bringSubviewToFront(self.view)
        spinner.startAnimating()
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Username: \(model.id)")
        models.append("Full Name: \(model.display_name)")
        models.append("Email: \(model.email)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first??.url)
        tableView.reloadData()
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        
        view.addSubview(label)
        label.center = view.center
    }
    
    private func createTableHeader(with image: String?) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 1.5))
        let imageSize: CGFloat = headerView.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        
        if let imageURL = image, let url = URL(string: imageURL) {
            imageView.sd_setImage(with: url, completed: nil)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageSize / 2
        } else {
            imageView.sd_setImage(with: nil, placeholderImage: UIImage(systemName: "person"))
        }
        
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
