//
//  Pokemon.swift
//  album-pokemon
//
//  Created by Renato Lopes on 28/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import Foundation
import UIKit
class Pokemon  {
    let nome: String
    var sprite: UIImage?
    
    init(nome: String, sprite: UIImage? = nil) {
        self.sprite = sprite
        self.nome = nome
    }
    
}
