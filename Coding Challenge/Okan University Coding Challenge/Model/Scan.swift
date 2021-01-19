//
//  ScanResult.swift
//  Okan University Coding Challenge
//
//  Created by Giray Uçar on 13.01.2021.
//

import Foundation

struct Scan {
    
    var link : String
    var codeFormat : String
    var resultType : String
    
    init(link:String,codeFormat:String,resultType:String) {
        self.link = link
        self.codeFormat = codeFormat
        self.resultType = resultType
    }
}
