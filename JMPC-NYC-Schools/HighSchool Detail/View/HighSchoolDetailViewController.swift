//
//  HighSchoolDetailViewController.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import UIKit

class HighSchoolDetailViewController: UIViewController {
    // MARK: - Injected data
    var highSchoolRecord: HighSchoolRecord
    var requestsManager: RequestsManagerProtocol
    
    // MARK: - ViewModel properties
    var viewModel: HighSchoolDetailViewModel
    
    // MARK: - UI elements
    lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 6.0/255.0, green: 159.0/255.0, blue: 200.0/255.0,alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-back-white"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var schoolName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    lazy var warningMessage: UILabel = {
        let label = UILabel()
        label.text = "There are not records for this highschool"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Custom init
    init(highSchoolRecord: HighSchoolRecord, requestsManager: RequestsManagerProtocol) {
        self.highSchoolRecord = highSchoolRecord
        self.requestsManager = requestsManager
        self.viewModel = HighSchoolDetailViewModel(requestsManager: self.requestsManager, currentHighSchool: self.highSchoolRecord)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.requestData()
    }
    
    deinit {
        // Just checking not leaving references alive
        print("Leaving the Viewcontroller...")
    }
}


// MARK: - UI elements
extension HighSchoolDetailViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        
        // Header bar
        self.view.addSubview(headerContainer)
        headerContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        headerContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        headerContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        headerContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.headerContainer.addSubview(schoolName)
        self.schoolName.leadingAnchor.constraint(equalTo: self.headerContainer.leadingAnchor, constant: 40).isActive = true
        self.schoolName.trailingAnchor.constraint(equalTo: self.headerContainer.trailingAnchor, constant: -40).isActive = true
        self.schoolName.bottomAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: -20).isActive = true
        
        self.headerContainer.addSubview(backButton)
        self.backButton.leadingAnchor.constraint(equalTo: self.headerContainer.leadingAnchor, constant: 10).isActive = true
        self.backButton.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 0).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Tableview
        self.view.addSubview(tableView)
        self.tableView.leadingAnchor.constraint(equalTo: self.headerContainer.leadingAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.headerContainer.trailingAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 10).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(HighSchoolDetailTableViewCell.self, forCellReuseIdentifier: HighSchoolDetailTableViewCell.identifier)
        self.tableView.tableFooterView = UIView()
        
        self.view.addSubview(warningMessage)
        self.warningMessage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.warningMessage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.warningMessage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        self.schoolName.text = self.highSchoolRecord.school_name
    }
    
    private func createAlert(with message: String) {
        let alertController = UIAlertController(title: "Alert message", message: message, preferredStyle: .alert)
        let dismissACtion = UIAlertAction(title: "Ok", style: .cancel) { (alert) in
            self.noResultsHandling()
        }
        alertController.addAction(dismissACtion)
        self.present(alertController, animated: true)
    }
    
    private func noResultsHandling(){
        // This is an edge case
        self.tableView.isHidden = true
        self.warningMessage.isHidden = false
    }
}

// MARK: - Data
extension HighSchoolDetailViewController {
    private func requestData() {
        self.viewModel.fetchData()
        self.viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.viewModel.isDataAvaliable() {
                    self.tableView.reloadData()
                } else {
                    self.noResultsHandling()
                }
            }
        }
        
        self.viewModel.isThereAnyError = { [weak self] message in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.createAlert(with: message)
            }
        }
    }
}

// MARK: -  Actions
extension HighSchoolDetailViewController {
    @objc func didTapButton() {
        self.dismiss(animated: false)
    }
}

// MARK: - Tableview delegate methods
extension HighSchoolDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: we should not have the model as an optional guy
        return self.viewModel.highSchoolDetailRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: HighSchoolDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: HighSchoolDetailTableViewCell.identifier, for: indexPath) as? HighSchoolDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let highSchoolDetailRecord = self.viewModel.highSchoolDetailRecords[indexPath.row]
        cell.configureCell(with: highSchoolDetailRecord)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
}



