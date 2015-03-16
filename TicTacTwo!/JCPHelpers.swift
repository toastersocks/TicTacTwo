//
//  JCPHelpers.swift
//  TicTacTwo!
//
//  Created by James Pamplona on 3/10/15.
//  Copyright (c) 2015 James Pamplona. All rights reserved.
//

import Foundation

func log(x: AnyObject, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__, column: Int = __COLUMN__) {
    println("File: \(file) Func: \(function), Line: \(line), Col: \(column)")
    if let stringMessage = x as? String {
        println(stringMessage)
    } else {
        debugPrintln(x)
    }
}