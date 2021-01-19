//
//  HistoryViewController.swift
//  Okan University Coding Challenge
//
//  Created by Giray Uçar on 16.01.2021.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var link : [String]?
    
    @IBOutlet var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        title = "History"
        link = UserDefaults.standard.value(forKey: "links") as? [String] ?? [String]()
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    @IBAction func thrashButtonClicked(_ sender: Any) {
        askForPermission()
    }
    
    func askForPermission() {
        let controller = UIAlertController(title: "Are you sure?", message: "This will delete history", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.link?.removeAll()
            UserDefaults.standard.removeObject(forKey: "links")
            DispatchQueue.main.async {
                self.historyTableView.reloadData()
            }
        })
        let noButton = UIAlertAction(title: "No", style: .default, handler: nil)
        controller.addAction(okButton)
        controller.addAction(noButton)
        self.present(controller, animated: true, completion: nil)
    }
    
}

extension HistoryViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.link?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qrCode", for: indexPath)
        cell.textLabel?.text = self.link?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let link = self.link?[indexPath.row] {
            if let url = URL(string: link) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            else {
                let controller = UIAlertController(title: "Error", message: "Link is in wrong format or broken.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                controller.addAction(okButton)
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            UserDefaults.standard.removeObject(forKey: "links")
            self.link!.remove(at: indexPath.row)
            UserDefaults.standard.setValue(self.link, forKey: "links")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
}
