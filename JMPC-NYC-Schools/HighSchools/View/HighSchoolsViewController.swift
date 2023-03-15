//
//  HighSchoolsViewController.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import UIKit

class HighSchoolsViewController: UIViewController {

    // MARK: - Injected data
    var requestsManager: RequestsManagerProtocol
    
    // MARK: - Lazy properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        return tableView
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints =  false
        return pickerView
    }()
    
    
    // MARK: - Loading view
    // This loading view should be done
    lazy var loadingView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.alpha = 0.7
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var spinnerLabel: UILabel = {
        let label = UILabel()
        // This is a good canditate to translate
        label.text = "Loading"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    // MARK: - ViewModel properties
    var viewModel: MainFeedViewModel
    
    
    // MARK: - Init methods
    init(with requestsManager: RequestsManager = RequestsManager()) {
        // TODO: Request manager should come by injection/ protocl
        self.requestsManager = requestsManager
        self.viewModel = MainFeedViewModel(requestsManager: requestsManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Request manager should come by injection/ protocl
        self.viewModel = MainFeedViewModel(requestsManager: requestsManager)

        self.setupUI()
        self.requestData()
    }
}

// MARK: - UI elements
extension HighSchoolsViewController {
    private func setupUI() {
        self.navigationItem.title = "HighSchools"
        self.view.backgroundColor = UIColor(red: 6.0/255.0, green: 159.0/255.0, blue: 200.0/255.0,alpha: 1.0)
        
        // Setup table view
        self.view.addSubview(tableView)
        self.view.addSubview(pickerView)
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.pickerView.topAnchor, constant: 0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SchoolInfoTableViewCell.self, forCellReuseIdentifier: SchoolInfoTableViewCell.identifier)
        
        pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        pickerView.dataSource = self
        pickerView.delegate = self
        

        // Setup our spinner
        self.createSpinner()
    }
    

    private func createSpinner() {
        self.view.addSubview(loadingView)
        self.loadingView.addSubview(spinner)
        self.loadingView.addSubview(spinnerLabel)
        
        loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        
        spinner.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor, constant: 0).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor, constant: 0).isActive = true
        
        spinnerLabel.leadingAnchor.constraint(equalTo: self.loadingView.leadingAnchor, constant: 10).isActive = true
        spinnerLabel.trailingAnchor.constraint(equalTo: self.loadingView.trailingAnchor, constant: -10).isActive = true
        spinnerLabel.bottomAnchor.constraint(equalTo: self.loadingView.bottomAnchor, constant: -10).isActive = true
        spinnerLabel.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor, constant: 0).isActive = true
    }
    
    private func createAlert(with message: String) {
        let alertController = UIAlertController(title: "Alert message", message: message, preferredStyle: .alert)
        let dismissACtion = UIAlertAction(title: "Ok", style: .cancel) { (alert) in
            self.noResultsHandling()
        }
        alertController.addAction(dismissACtion)
        self.present(alertController, animated: true)
    }
    
    private func noResultsHandling() {
        self.loadingView.isHidden = true
        self.spinner.stopAnimating()
    }
}

// MARK: - Data managment
extension HighSchoolsViewController {
    private func loadData() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.spinner.stopAnimating()
            self.tableView.isHidden = false
            self.pickerView.isHidden = false
            self.tableView.reloadData()
            self.pickerView.reloadAllComponents()
        }
    }
    
    private func requestData() {
        loadingView.isHidden = false
        spinner.startAnimating()
        self.viewModel.fetchData()
        self.viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            self.loadData()
        }
        
        self.viewModel.isThereAnyError = { [weak self] message in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.createAlert(with: message)
            }
        }
    }
}

// MARK: - tableview delegate methods
extension HighSchoolsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.highSchoolRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SchoolInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: SchoolInfoTableViewCell.identifier, for: indexPath) as? SchoolInfoTableViewCell else {
            return UITableViewCell()
        }

        let highSchoolRecord: HighSchoolRecord = self.viewModel.highSchoolRecords[indexPath.row]
        cell.configureCell(highSchoolRecord: highSchoolRecord)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let highSchoolRecord = self.viewModel.highSchoolRecords[indexPath.row]
        self.presentDetail(with: highSchoolRecord)
    }
}

// MARK: - tableview delegate methods
extension HighSchoolsViewController {
    private func presentDetail(with highSchoolRecord :HighSchoolRecord) {
        let highSchoolDetailViewController = HighSchoolDetailViewController(highSchoolRecord: highSchoolRecord, requestsManager: self.requestsManager)
        highSchoolDetailViewController.modalPresentationStyle = .fullScreen
        self.present(highSchoolDetailViewController, animated: false)
    }
}

// MARK: - PickerView delegate methods
extension HighSchoolsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.cities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let citySelected = viewModel.cities[row]
        self.viewModel.filterHighSchools(by: citySelected)
    }
}
