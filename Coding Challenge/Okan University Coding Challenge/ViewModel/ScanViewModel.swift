//
//  CodeViewModel.swift
//  Okan University Coding Challenge
//
//  Created by Giray Uçar on 16.01.2021.
//

import Foundation
import ScanKitFrameWork

protocol ScanViewModelDelegate {
    
    func decodingSuccesfull()
    func decodingFailed()
    func showHmsView()
    
}

class ScanViewModel : NSObject {
    
    var delegate : ScanViewModelDelegate?
    var scanResult = Scan(link: "", codeFormat: "", resultType: "")
    var hmsView : HmsDefaultScanViewController?
    var error = ""
    var links : [String]?
}

extension ScanViewModel {
    
    func decodeQr() {
        let options = HmsScanOptions(scanFormatType: 0, photo: false)
        guard let hmsDefaultScanViewController = HmsDefaultScanViewController(defaultScanWithFormatType: options)
        else {
            self.delegate?.decodingFailed()
            return print("error")
        }
        hmsDefaultScanViewController.defaultScanDelegate = self
        self.hmsView = hmsDefaultScanViewController
        self.delegate?.showHmsView()
    }
    
    func parseResult(_ dictionary: [AnyHashable : Any]?) {
        if let dictionary = dictionary, let link = dictionary["text"] as? String {
            self.scanResult.link = link
            if let formatValue = dictionary["formatValue"] as? String {
                self.scanResult.codeFormat = formatValue
            }
            if let sceneType = dictionary["sceneType"] as? String {
                self.scanResult.resultType = sceneType
            }
        } else {
            self.error = "Couldn't find any QR Code!"
        }
    }
}

extension ScanViewModel : DefaultScanDelegate {
    
    func defaultScanImagePickerDelegate(for image: UIImage!) {
        DispatchQueue.main.async {
            let dic = HmsBitMap.bitMap(for: image, with: HmsScanOptions(scanFormatType: 0, photo: true))
            self.parseResult(dic)
            if self.error != "" {
                self.delegate?.decodingFailed()
            }
            else {
                self.links = UserDefaults.standard.value(forKey: "links") as? [String] ?? [String]()
                UserDefaults.standard.setValue(self.links, forKey: "links")
                self.delegate?.decodingSuccesfull()
            }
        }
    }
        
    func defaultScanDelegate(forDicResult resultDic: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.parseResult(resultDic)
            if self.error != "" {
                self.delegate?.decodingFailed()
            }
            else {
                self.links = UserDefaults.standard.value(forKey: "links") as? [String] ?? [String]()
                self.links?.insert(self.scanResult.link, at: 0)
                UserDefaults.standard.setValue(self.links, forKey: "links")
                self.delegate?.decodingSuccesfull()
            }
        }
    }
    
}

