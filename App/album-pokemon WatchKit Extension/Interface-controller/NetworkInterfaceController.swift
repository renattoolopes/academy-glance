//
//  ServiceInterfaceController.swift
//  album-pokemon WatchKit Extension
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import Foundation
import WatchKit

extension InterfaceController{

    func novaFigurinha(){
        self.obterPokemonDaAPI(comID: Int.randomInt(1, 200))
    }
    
    //MARK: - DataTask Foreground
    func obterPokemonDaAPI(comID id: Int){
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
       
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
            print("Erro ao gerar URL")
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if error == nil, data != nil {
                guard let json = converterDadosParaJSON(comDados: data!) else {return}
                self.buscandoPokemonLabel.setText("Pokémon encontrado!")
                self.obterPokemonDoJSON(json)
//                self.baixarSprint()
            }else{
                print(error!)
                self.buscandoPokemonLabel.setText("Erro ao buscar pokémon!")
            }
        }.resume()
        
    }
    
    
    func obterPokemonDoJSON(_ json: [String: Any]){
        let formPokemon = json["forms"] as! [[String: Any]]
        let nomePokemon = formPokemon.first!["name"] as! String
        self.criarPokemon(comNome: nomePokemon, eComSprite: nil)
    }
    
    func criarPokemon(comNome nome: String, eComSprite sprite: UIImage?){
        let newPokemon = Pokemon.init(nome: nome, sprite: sprite)
        listaDePokemons.append(newPokemon)
        self.buscandoPokemonLabel.setText(newPokemon.nome)
        
        //Terminou e agora deve chamar a notificação
//        callNotification()
    }
    
    
    // MARK: - Download background
//    func baixarSprint(){
//        let configuracao = URLSessionConfiguration.background(withIdentifier: "download-image.renato")
//        let session = URLSession.init(configuration: configuracao, delegate: self, delegateQueue: nil)
//        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!
//        session.downloadTask(with: url).resume()
//
//
//    }
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("Download imagem do pokémon")
//
//        let fileManager = FileManager()
//
//        let url = try! fileManager.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: location, create: true).appendingPathComponent("\(listaDePokemons.first?.nome ?? "sem_nome").png")
//
//        do{
//            try fileManager.moveItem(at: location, to: url)
//            self.obterSpriteBaixado()
//        }catch let error {
//            print("Erro =>> \(error)")
//        }
//
//    }
    
//    //Função que obtem o arquivo baixado e troca o background do pokémon
//    func obterSpriteBaixado(){
//        let file = try? FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("\(listaDePokemons.first?.nome ?? "sem_nome").png")
//        guard let data = file else {return}
//        print(data.relativeString)
//        let urlImage = try? Data(contentsOf: data)
//        guard let dataImage = urlImage else {
//            return
//        }
//        let image = UIImage(data: dataImage)
//
//        self.spritePokemon.setBackgroundImage(image)
//
//        print("trocando imagem")
//        callNotification()
//    }
    
}
