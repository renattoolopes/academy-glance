//
//  CommunicationInterfaceController.swift
//  album-pokemon WatchKit Extension
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    //mandando nome por tranferUserIndo
    func mandar_pokemon(){
        let session = WCSession.default
        if session.activationState == .activated{
            guard let pokemon = listaDePokemons.last else {
                return
            }
            
            let data = ["pokemon": pokemon.nome]
            session.transferUserInfo(data)
        }
    }
    
    //mandando por UpdateApplication
    func mandar_pokemon_contexto(){
        if WCSession.isSupported(){
            do {
                guard let pokemon = listaDePokemons.last else {
                    return
                }
                let data = ["pokemon": pokemon.nome]
                try WCSession.default.updateApplicationContext(data)
            }catch{
                print("error\(error)")
            }
        }
    }
    
    //mandar image por TransferFile
    func mandar_image() {
        if let fileURL = Bundle.main.url(forResource: "Ekans", withExtension: "png") {
            WCSession.default.transferFile(fileURL, metadata: nil)
        } else {
            print("Could get fileURL")
        }
    }
}
