//
//  InterfaceController.swift
//  album-pokemon WatchKit Extension
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController{
    
    // MARK: - Definição dos var e let da URLSession
    let identificador: String = "com.album-pokemon.download-pokemon"
    var listaDePokemons: [Pokemon] = []
    
    @IBOutlet weak var buscandoPokemonLabel: WKInterfaceLabel!
    @IBOutlet weak var spritePokemon: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.novaFigurinha()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}

