//
//  MainViewController.swift
//  Okan University Coding Challenge
//
//  Created by Giray Uçar on 9.01.2021.
//

import UIKit
import ScanKitFrameWork
import Lottie

class MainViewController: UIViewController {
    
    var animationView : AnimationView!
    private lazy var scanViewModel : ScanViewModel = {
        let vm = ScanViewModel()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        self.navigationController?.isNavigationBarHidden = true
        title = "QR Reader"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.animationView.play()
    }
    
    private func setupAnimation() {
        self.animationView = AnimationView(name: "qrScanAnimation")
        self.animationView.frame = CGRect(x: 0, y: view.frame.midY / 2.7 , width: view.frame.width, height: view.bounds.height / 1.6 )
        self.animationView.contentMode = .scaleAspectFill
        self.animationView.loopMode = .loop
        view.addSubview(animationView)
        self.animationView.play()
        view.sendSubviewToBack(animationView)
    }
    
    
    @IBAction func scanNowButtonClicked(_ sender: Any) {
        scanViewModel.decodeQr()
    }
    
    @IBAction func historyButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHistoryVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultVC" {
            let vc = segue.destination as! ResultViewController
            vc.scanResult = self.scanViewModel.scanResult
        }
    }
    
    func showErrorMessage() {
        let controller = UIAlertController(title: "Error", message: "Couldn't decode QR", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel , handler: nil)
        controller.addAction(okButton)
        self.present(controller, animated: true, completion: nil)
    }
    
}

extension MainViewController : ScanViewModelDelegate {
    func showHmsView() {
        let hmsView = scanViewModel.hmsView
        if let view = hmsView {
            self.present(view, animated: true, completion: nil)
        }
    }
    
    func decodingSuccesfull() {
        performSegue(withIdentifier: "goToResultVC", sender: nil)
    }
    
    func decodingFailed() {
        showErrorMessage()
    }
    
}
