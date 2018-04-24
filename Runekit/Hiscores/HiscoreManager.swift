//
//  HiscoreManager.swift
//  Runekit
//
//  Created by David Cruz on 3/12/18.
//  Copyright © 2018 AppShuttle.io. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HiscoreManager: NSObject {
    // MARK: - Initialization Methods
    override init() {
        super.init()
    }
    static let shared: HiscoreManager = {
        let instance = HiscoreManager()
        return instance
    }()
    
    func getPlayerHighscore(_ username: String, playerType: String, completion: @escaping (_ result: PlayerScore?, _ error: Error?) -> Void) {
        
        Alamofire.request("https://us-central1-runescape-app.cloudfunctions.net/getPlayerHighscores", method: .post, parameters: ["username":username as Any, "playerType": playerType as Any]).responseJSON { (response) in
            
            if let jsonObject: Dictionary<String, Any> = response.result.value as? Dictionary<String, Any> {
                do {
                    var modifiedJsonObject = jsonObject
                    modifiedJsonObject["username"] = username
                    let playerScore = PlayerScore.init(modifiedJsonObject)
                    completion(playerScore, nil)
                } catch {
                    completion(nil, NSError(domain: "Invalid JSON", code: -1, userInfo: nil))
                }
            } else {
                completion(nil, response.error)
            }
            
        }
        
    }
}


