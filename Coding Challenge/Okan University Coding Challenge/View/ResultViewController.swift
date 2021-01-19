//
//  ResultViewController.swift
//  Okan University Coding Challenge
//
//  Created by Giray Uçar on 12.01.2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    var scanResult : Scan!

    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var codeFormatLabel: UILabel!
    @IBOutlet var resultTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkLabel.text = "Link: \(self.scanResult.link)"
        codeFormatLabel.text = "Code Format: \(self.scanResult.codeFormat)"
        resultTypeLabel.text = "Result Type: \(self.scanResult.resultType)"
    }
    
    @IBAction func goLinkButtonPressed(_ sender: Any) {
        if let url = URL(string: self.scanResult.link) {
            if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            createLinkAlert(title: "Error", message: "Link is broken or in wrong format", buttonTitle: "OK")
        }
    }
    
    func createLinkAlert(title:String,message:String,buttonTitle:String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        controller.addAction(okButton)
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func scanAgainButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
