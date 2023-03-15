//
//  HighSchoolDetailTableViewCell.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import UIKit

class HighSchoolDetailTableViewCell: UITableViewCell {

    // MARK: - Static elements
    static let identifier = "HighSchoolDetailTableViewCell"
    
    // MARK: - Top-left UI elements
    lazy var satTestTakers: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2.0
        view.layer.borderColor =  UIColor(red: 6.0/255.0, green: 159.0/255.0, blue: 200.0/255.0,alpha: 1.0).cgColor
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var satTestTakersLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var satTestTakersDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "SAT - Test takers"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 8)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Top-right UI elements
    lazy var satCriticalReadingAvgScore: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2.0
        view.layer.borderColor =  UIColor(red: 6.0/255.0, green: 159.0/255.0, blue: 200.0/255.0,alpha: 1.0).cgColor
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var satCriticalReadingAvgScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var satCriticalReadingAvgScoreDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "SAT - Critical Reading Avg Score"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 8)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - bottom-left UI elements
    lazy var satMathAvgScore: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2.0
        view.layer.borderColor =  UIColor(red: 6.0/255.0, green: 159.0/255.0, blue: 200.0/255.0,alpha: 1.0).cgColor
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var satMathAvgScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var satMathAvgScoreDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "SAT - Math Avg Score"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 8)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - bottom-right UI elements
    lazy var satWritingAvgScore: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2.0
        view.layer.borderColor =  UIColor(red: 6.0/255.0, green: 159.0/255.0, blue: 200.0/255.0,alpha: 1.0).cgColor
        view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var satWritingAvgScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var satWritingAvgScoreDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "SAT - Writing Avg Score"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 8)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    // MARK: - Properties
    var highSchoolDetailRecord: HighSchoolDetailRecord?
    
    // MARK: - Default methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with highSchoolDetailRecord: HighSchoolDetailRecord) {
        self.highSchoolDetailRecord = highSchoolDetailRecord
        self.setupUI()
        self.populateData()
    }
}

// MARK: - UI Setup
extension HighSchoolDetailTableViewCell {
    func setupUI() {
        self.contentView.addSubview(satTestTakers)
        self.satTestTakers.addSubview(satTestTakersLabel)
        self.satTestTakers.addSubview(satTestTakersDetailLabel)
        
        self.contentView.addSubview(satCriticalReadingAvgScore)
        self.satCriticalReadingAvgScore.addSubview(satCriticalReadingAvgScoreLabel)
        self.satCriticalReadingAvgScore.addSubview(satCriticalReadingAvgScoreDetailLabel)
        
        self.contentView.addSubview(satMathAvgScore)
        self.satMathAvgScore.addSubview(satMathAvgScoreLabel)
        self.satMathAvgScore.addSubview(satMathAvgScoreDetailLabel)
        
        self.contentView.addSubview(satWritingAvgScore)
        self.satWritingAvgScore.addSubview(satWritingAvgScoreLabel)
        self.satWritingAvgScore.addSubview(satWritingAvgScoreDetailLabel)
        
        // top-left container
        self.satTestTakers.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.satTestTakers.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.satTestTakers.trailingAnchor.constraint(equalTo: self.satCriticalReadingAvgScore.leadingAnchor, constant: -10).isActive = true
        self.satTestTakersLabel.topAnchor.constraint(equalTo: self.satTestTakers.topAnchor, constant: 10).isActive = true
        self.satTestTakersLabel.centerXAnchor.constraint(equalTo: satTestTakers.centerXAnchor, constant: 0).isActive = true
        self.satTestTakersDetailLabel.topAnchor.constraint(equalTo: self.satTestTakersLabel.bottomAnchor, constant: 10).isActive = true
        self.satTestTakersDetailLabel.bottomAnchor.constraint(equalTo: self.satTestTakers.bottomAnchor, constant: -10).isActive = true
        self.satTestTakersDetailLabel.centerXAnchor.constraint(equalTo: satTestTakers.centerXAnchor, constant: 0).isActive = true
        
        // top-right container
        self.satCriticalReadingAvgScore.topAnchor.constraint(equalTo: satTestTakers.topAnchor, constant: 0).isActive = true
        self.satCriticalReadingAvgScore.bottomAnchor.constraint(equalTo: satTestTakers.bottomAnchor, constant: 0).isActive = true
        self.satCriticalReadingAvgScore.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.satCriticalReadingAvgScore.widthAnchor.constraint(equalTo: self.satTestTakers.widthAnchor, constant: 10).isActive = true
        self.satCriticalReadingAvgScoreLabel.topAnchor.constraint(equalTo: self.satCriticalReadingAvgScore.topAnchor, constant: 10).isActive = true
        self.satCriticalReadingAvgScoreLabel.centerXAnchor.constraint(equalTo: satCriticalReadingAvgScore.centerXAnchor, constant: 0).isActive = true
        self.satCriticalReadingAvgScoreDetailLabel.topAnchor.constraint(equalTo: self.satCriticalReadingAvgScoreLabel.bottomAnchor, constant: 10).isActive = true
        self.satCriticalReadingAvgScoreDetailLabel.bottomAnchor.constraint(equalTo: self.satCriticalReadingAvgScore.bottomAnchor, constant: -10).isActive = true
        self.satCriticalReadingAvgScoreDetailLabel.centerXAnchor.constraint(equalTo: satCriticalReadingAvgScore.centerXAnchor, constant: 0).isActive = true
        
        // bottom-left container
        self.satMathAvgScore.leadingAnchor.constraint(equalTo: self.satTestTakers.leadingAnchor, constant: 0).isActive = true
        self.satMathAvgScore.trailingAnchor.constraint(equalTo: self.satTestTakers.trailingAnchor, constant: 0).isActive = true
        self.satMathAvgScore.topAnchor.constraint(equalTo: self.satTestTakers.bottomAnchor, constant: 10).isActive = true
        self.satMathAvgScore.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.satMathAvgScoreLabel.topAnchor.constraint(equalTo:           self.satMathAvgScore.topAnchor, constant: 10).isActive = true
        self.satMathAvgScoreLabel.centerXAnchor.constraint(equalTo:       self.satMathAvgScore.centerXAnchor, constant: 0).isActive = true
        self.satMathAvgScoreDetailLabel.topAnchor.constraint(equalTo:     self.satMathAvgScoreLabel.bottomAnchor, constant: 10).isActive = true
        self.satMathAvgScoreDetailLabel.bottomAnchor.constraint(equalTo:  self.satMathAvgScore.bottomAnchor, constant: -10).isActive = true
        self.satMathAvgScoreDetailLabel.centerXAnchor.constraint(equalTo: self.satMathAvgScore.centerXAnchor, constant: 0).isActive = true

        // bottom - right container
        self.satWritingAvgScore.leadingAnchor.constraint(equalTo: self.satCriticalReadingAvgScore.leadingAnchor, constant: 0).isActive = true
        self.satWritingAvgScore.trailingAnchor.constraint(equalTo: self.satCriticalReadingAvgScore.trailingAnchor, constant: 0).isActive = true
        self.satWritingAvgScore.topAnchor.constraint(equalTo: self.satTestTakers.bottomAnchor, constant: 10).isActive = true
        self.satWritingAvgScore.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        self.satWritingAvgScoreLabel.topAnchor.constraint(equalTo:           self.satWritingAvgScore.topAnchor, constant: 10).isActive = true
        self.satWritingAvgScoreLabel.centerXAnchor.constraint(equalTo:       self.satWritingAvgScore.centerXAnchor, constant: 0).isActive = true
        self.satWritingAvgScoreDetailLabel.topAnchor.constraint(equalTo:     self.satWritingAvgScoreLabel.bottomAnchor, constant: 10).isActive = true
        self.satWritingAvgScoreDetailLabel.bottomAnchor.constraint(equalTo:  self.satWritingAvgScore.bottomAnchor, constant: -10).isActive = true
        self.satWritingAvgScoreDetailLabel.centerXAnchor.constraint(equalTo: self.satWritingAvgScore.centerXAnchor, constant: 0).isActive = true
    }
}

extension HighSchoolDetailTableViewCell {
    private func populateData() {
        guard let highSchoolDetailRecord = self.highSchoolDetailRecord else {
            //  We can send a default state
            return
        }
        
        satTestTakersLabel.text = highSchoolDetailRecord.num_of_sat_test_takers
        satCriticalReadingAvgScoreLabel.text = highSchoolDetailRecord.sat_critical_reading_avg_score
        satMathAvgScoreLabel.text = highSchoolDetailRecord.sat_math_avg_score
        satWritingAvgScoreLabel.text = highSchoolDetailRecord.sat_writing_avg_score
    }
}
