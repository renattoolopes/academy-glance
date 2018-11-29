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
            
            let poke = ["pokemon": pokemon]
            session.transferUserInfo(poke)
            
        }
    }

    //mandando por UpdateApplication
    func mandar_pokemon_nome_contexto(){
        if WCSession.isSupported(){
            do {
                guard let pokemon = listaDePokemons.last else {
                    return
                }
                let poke = ["pokemon-nome": pokemon.nome]
                try WCSession.default.updateApplicationContext(poke)
            }catch{
                print("error\(error)")
            }
        }
    }
    
    func mandar_pokemon_imagem_contexto(){
        if WCSession.isSupported(){
            do {
                guard let pokemon = listaDePokemons.last else {
                    return
                }
                let poke = ["pokemon-imagem": pokemon.sprite!.pngData()!]
                try WCSession.default.updateApplicationContext(poke)
            }catch{
                print("error\(error)")
            }
        }
    }
    
}
