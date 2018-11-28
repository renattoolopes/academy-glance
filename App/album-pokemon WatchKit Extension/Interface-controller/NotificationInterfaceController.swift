//
//  NotificationInterfaceController.swift
//  album-pokemon WatchKit Extension
//
//  Created by Renato Lopes on 27/11/18.
//  Copyright © 2018 Renato Lopes. All rights reserved.
//

import Foundation
import UserNotifications
import WatchKit

extension InterfaceController: UNUserNotificationCenterDelegate{
    
    // MARK: Notification
    // função de chamar a notificação
    func callNotification(){
        registerUserNotificationSettings()
        scheduleLocalNotification()
    }
    
    // estruturando a notificação
    func registerUserNotificationSettings() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let okAction = UNNotificationAction(identifier: "okButtonAction", title: "ok", options: .foreground)  // criando botões de ação na notificação
                
                let testeCategory = UNNotificationCategory(identifier: "pokemonCategory", actions: [okAction], intentIdentifiers: [], options: []) // criando categoria da notificação
                
                UNUserNotificationCenter.current().setNotificationCategories([testeCategory]) // atribuindo os botões criados na categoria
                
                UNUserNotificationCenter.current().delegate = self
                print("Registro de configuração de notificação criada com sucesso.")
            } else {
                print("ERROR: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    
    func scheduleLocalNotification() {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.alertSetting == .enabled {
                
                
                let notificationContent = UNMutableNotificationContent() // estruturando a notificação
                notificationContent.title = "Nova figurinha"
                notificationContent.body = self.listaDePokemons.first!.nome
                notificationContent.categoryIdentifier = "pokemonCategory"
                
                notificationContent.sound = UNNotificationSound.default // atribuindo som da notificação
                // 2 segundos
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false) // definindo intervalo para exibir a notificação
                
                let notificationRequest = UNNotificationRequest(identifier: "pokemonCategory", content: notificationContent, trigger: notificationTrigger) // criando o pedido de notificação
                
                UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                    if let error = error {
                        print("ERROR:\(error.localizedDescription)")
                    } else {
                        print("A notificação foi escalada.")
                    }
                }
            } else {
                print("Não é permitido a exibição de alertas.")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    //MARK: okButton notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "okButtonAction":
            print("Ok action tapped")
            mandar_pokemon()
            mandar_image()
            print("pokemon enviado para o IOS")
        case "Dismiss":
            print("Dismiss action tapped")
        default:
            break
        }
        completionHandler()
    }
}
