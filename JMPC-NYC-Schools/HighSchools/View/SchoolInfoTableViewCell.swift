//
//  SchoolInfoTableViewCell.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import UIKit

class SchoolInfoTableViewCell: UITableViewCell {

    // MARK: - Static elements
    static let identifier = "SchoolInfoTableViewCell"
    
    // MARK: - UI elements
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MAR: - Properties
    var schoolRecord: HighSchoolRecord?
    
    // MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Receive :
    ///     - highSchoolRecord: Record representing a highschool
    ///
    func configureCell(highSchoolRecord: HighSchoolRecord) {
        self.setupUI()
        self.schoolRecord = highSchoolRecord
        self.populateData()
    }
}

// MARK: - UI elements
extension SchoolInfoTableViewCell {
    private func setupUI() {
        self.contentView.addSubview(name)
        self.name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.name.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        self.name.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
    }
}

// MARK: - Data managment
extension SchoolInfoTableViewCell {
    private func populateData() {
        self.name.text = self.schoolRecord?.school_name
    }
}
