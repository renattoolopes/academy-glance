//
//  ViewController.swift
//  album-pokemon
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import UIKit
import WatchConnectivity


class ViewController: UIViewController , WCSessionDelegate{
    
    @IBOutlet weak var nomePokemon: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    
    //funcao receber info transferUser
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            if let pokemon = userInfo["pokemon"] as? String{
                self.nomePokemon.text = pokemon
            }
        }
    }
    
    //receber pelo applicationContext
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let pokemon = applicationContext["pomemon"] as? String{
            DispatchQueue.main.async(execute:{
                self.nomePokemon.text = pokemon
            })
        }
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        DispatchQueue.main.async {
            let imageData = NSData.init(contentsOf: file.fileURL)
            self.imagePokemon.image = UIImage(data: imageData! as Data)
        }

    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    print("Watch Instalado")
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}

