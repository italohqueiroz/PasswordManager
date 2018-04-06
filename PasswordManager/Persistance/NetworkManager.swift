//
//  NetworkManager.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 01/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation

fileprivate let kApi = "https://dev.people.com.ai/mobile/api/v2/"
fileprivate let kLogin = "login"
fileprivate let kLogo = "logo/"
fileprivate let kRegister = "register"

typealias RegisterHandler = (Bool, [String]) -> ()
typealias LogoHandler = (Data?, [String]) -> ()
typealias LoginHandler = (Bool, [String]) -> ()
class NetworkManager {
    
    private(set) var token: String?
    static let shared = NetworkManager()
    let session = URLSession.shared
    
    func register(name: String, email: String, senha: String, completion: @escaping RegisterHandler){
        var request = URLRequest(url: URL(string: kApi + kRegister)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dict = ["email": email,
                    "name": name,
                    "password":senha]
        do {
            let json:Data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            request.httpBody = json
            session.dataTask(with: request, completionHandler: { (data, response, err) in
                if let data = data, err == nil{
                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                        let type = result["type"] as! String
                        if type == "sucess" {
                            let newToken = result["token"] as! String
                            self.token = newToken
                            completion(true, [])
                        }else {
                            completion(false,[result["message"] as! String])
                            return
                        }
                    } catch {
                        completion(false, ["Cannot get data"])
                        return
                    }
                }
            }).resume()
        } catch {
            completion(false, ["Cannot convert data"])
            return
        }
     
    }

    func logo(url: String, completion: @escaping LogoHandler){
        guard let token = self.token else {
            completion(nil,["User not logged"])
            return
        }
        var request = URLRequest(url: URL(string: kApi + kLogo + url)!)
        request.httpMethod = "GET"
        
        request.setValue(token, forHTTPHeaderField: "authorization")
        self.session.dataTask(with: request) { (data, response, err) in
            
            if let data = data, err == nil {
                completion(data, [])
            }else {
                completion(nil, ["Cannot get data"])
            }
        }.resume()
    }
    
    func login(email: String, senha: String, completion: @escaping LoginHandler){
        var request = URLRequest(url: URL(string: kApi + kLogin)!)
        request.httpMethod = "POST"
        let dict = ["email": email,
                    "password": senha]
        do{
            let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request, completionHandler: { (data, response, err) in
                if let data = data, err == nil{
                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                        let type = result["type"] as! String
                        if type == "sucess" {
                            let newToken = result["token"] as! String
                            self.token = newToken
                            completion(true, [])
                        }else {
                            completion(false,[result["message"] as! String])
                            return
                        }
                    } catch {
                        completion(false, ["Cannot get data"])
                        return
                    }
                }
            }).resume()
        } catch {
            completion(false, ["Cannot convert data"])
            return
        }
        
    }
    
    private init(){}
}
