//
//  ViewController.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    lazy var searchPictureView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "nyc")
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        logoAnimation()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(searchPictureView)
        searchPictureView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        searchPictureView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        searchPictureView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        searchPictureView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
        
    func logoAnimation() {
//        UIView.animate(withDuration: 3.0) {
        UIView.animate(withDuration: 0.5) {
            self.searchPictureView.alpha = 1.0
        } completion: { (success) in
//            UIView.animate(withDuration: 1.0) {
            UIView.animate(withDuration: 0.5) {
                self.searchPictureView.transform = CGAffineTransform.init(scaleX: 100, y: 100)
            } completion: { (success) in
                self.searchPictureView.isHidden = true
                self.searchPictureView.transform = .identity
                self.openHighSchool()
            }
        }
    }
    
    private func openHighSchool(){
        let highSchoolsViewController = HighSchoolsViewController(with: RequestsManager())
        let navigationController = UINavigationController(rootViewController: highSchoolsViewController)
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
    }
}

// TODO: - move to its own file this color extension
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
