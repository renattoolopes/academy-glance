//
//  Helper.swift
//  album-pokemon WatchKit Extension
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import Foundation


extension Int {
    static func randomInt(_ min: Int, _ max: Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}


func converterDadosParaJSON(comDados dados: Data) -> [String: Any]?{
    guard let json = try? JSONSerialization.jsonObject(with: dados, options: []) as! [String: Any]
    else {
        print("Erro ao criar Json")
        return nil
    }
    return json
}
