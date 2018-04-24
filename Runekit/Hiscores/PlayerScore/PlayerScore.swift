//
//  PlayerScore.swift
//  Runekit
//
//  Created by David Cruz on 3/12/18.
//  Copyright © 2018 AppShuttle.io. All rights reserved.
//

import Foundation

struct PlayerType {
    static let Normal = "normal"
    static let Ironman = "ironman"
    static let Hardcore = "hardcore"
    static let Ultimate = "ultimate"
    static let Deadman = "deadman"
}

class PlayerScore: NSObject {
    
    var username: String!
    var overall: SkillScore!
    var skills: [SkillScore]!
    var minigames: [MinigameScore]!
    
    override init () {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, Any>) {
        self.init()
        
        username = dictionary["username"] as! String
        
        skills = [SkillScore]()
        let skillsDictionary = dictionary["Skills"] as! Dictionary<String, Any>
        for skill in skillsDictionary {
            do {
                var skillObject = skill.value as! Dictionary<String, Any>
                skillObject["skillName"] = skill.key.replacingOccurrences(of: "_", with: " ")
                let jsonData = try JSONSerialization.data(withJSONObject: skillObject)
                
                if skill.key == "Overall" {
                    overall = try JSONDecoder().decode(SkillScore.self, from: jsonData)
                } else {
                    skills.append(try JSONDecoder().decode(SkillScore.self, from: jsonData))
                }
            } catch {
                print("Error adding skills")
            }
        }
        
        skills.sort { (skill1, skill2) -> Bool in
            return skill1.skillName <= skill2.skillName
        }
        
        minigames = [MinigameScore]()
        let minigamesDictionary = dictionary["Minigames"] as! Dictionary<String, Any>
        for minigame in minigamesDictionary {
            do {
                var minigameObject = minigame.value as! Dictionary<String, Any>
                minigameObject["minigameName"] = minigame.key.replacingOccurrences(of: "_", with: " ")
                let jsonData = try JSONSerialization.data(withJSONObject: minigameObject)
                minigames.append(try JSONDecoder().decode(MinigameScore.self, from: jsonData))
            } catch {
                print("Error adding minigames")
            }
        }
        
        minigames.sort { (m1, m2) -> Bool in
            return m1.minigameName <=  m2.minigameName
        }
        
    }
}

