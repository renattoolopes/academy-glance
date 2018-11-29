//
//  ServiceInterfaceController.swift
//  album-pokemon WatchKit Extension
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import Foundation
import WatchKit

extension InterfaceController: URLSessionDelegate, URLSessionDownloadDelegate{
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
                print("Download imagem do pokémon")
                do{
                    let data = try Data(contentsOf: location)
                 
                    let image = UIImage(data: data)
                    self.listaDePokemons.first?.sprite = image
                    self.spritePokemon.setBackgroundImage(image)
                    callNotification()
                    
                }catch let error {
                    print("Erro =>> \(error)")
                }
    }

    func novaFigurinha(){
        self.obterPokemonDaAPI(comID: Int.randomInt(1, 200))
    }
    
    //MARK: - DataTask Foreground
    func obterPokemonDaAPI(comID id: Int){
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
       
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else{
            print("Erro ao gerar URL")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if error == nil, data != nil {
                guard let json = converterDadosParaJSON(comDados: data!) else {return}
                self.buscandoPokemonLabel.setText("Pokémon encontrado!")
                self.obterPokemonDoJSON(json)
            }else{
                print(error!)
                self.buscandoPokemonLabel.setText("Erro ao buscar pokémon!")
            }
        }.resume()
        
    }
    
    func downloadSpritePokemon(comURL: String){
        let configuracao = URLSessionConfiguration.background(withIdentifier: self.identificador)
        
        let sessao = URLSession.init(configuration: configuracao, delegate: self, delegateQueue: nil)
        
        guard let url = URL(string: comURL) else {
            return
        }
        
        sessao.downloadTask(with: url).resume()
    }
    
    func obterPokemonDoJSON(_ json: [String: Any]){
        let formPokemon = json["forms"] as! [[String: Any]]
        let nomePokemon = formPokemon.first!["name"] as! String
        let sprites = json["sprites"] as! [String: Any]
        let urlSprite = sprites["front_default"] as! String
        self.criarPokemon(comNome: nomePokemon, eComSprite: nil)
        self.downloadSpritePokemon(comURL: urlSprite)
    }
    
    func criarPokemon(comNome nome: String, eComSprite sprite: UIImage?){
        let newPokemon = Pokemon.init(nome: nome, sprite: sprite)
        listaDePokemons.append(newPokemon)
        self.buscandoPokemonLabel.setText(newPokemon.nome)
    }
 
}
