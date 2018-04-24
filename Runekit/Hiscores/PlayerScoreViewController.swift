//
//  PlayerScoreViewController.swift
//  Runekit
//
//  Created by David Cruz on 3/12/18.
//  Copyright © 2018 AppShuttle.io. All rights reserved.
//

import UIKit
import AlamofireImage

class PlayerScoreViewController: UIViewController {
    
    var playerName: String!
    var playerScore: PlayerScore?

    @IBOutlet weak var scoresTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScoresTableView()
        getPlayerHiscores()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    func setUpUI() {
        self.title = playerName
        self.navigationController?.navigationBar.tintColor = ThemeManager.shared.getThemeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PlayerScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpScoresTableView() {
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Skills"
        case 1:
            return "Minigames"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let score = playerScore else { return 0 }
        
        switch section {
        case 0:
            return score.skills.count
        case 1:
            return score.minigames.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 65
        case 1:
            return 65
        default:
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
            
            let currentSkill = playerScore!.skills[indexPath.row]
            
            let iconImageView = cell.viewWithTag(1) as! UIImageView
            iconImageView.af_setImage(withURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/runescape-app.appspot.com/o/Skills%2FIcons%2FSmall%2FAgility-icon.png?alt=media")!)
            
            let lvlLabel = cell.viewWithTag(2) as! UILabel
            lvlLabel.text = String(currentSkill.level)
            
            let skillNameLabel = cell.viewWithTag(3) as! UILabel
            skillNameLabel.text = currentSkill.skillName
            
            let rankLabel = cell.viewWithTag(4) as! UILabel
            rankLabel.text = "Rank: " + String(currentSkill.rank)
            
            let totalXPLabel = cell.viewWithTag(5) as! UILabel
            totalXPLabel.text = "Total XP: " + String(currentSkill.xp)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MinigameCell", for: indexPath)
            
            let currentMinigame = playerScore!.minigames[indexPath.row]
            
            let scoreLabel = cell.viewWithTag(2) as! UILabel
            scoreLabel.text = currentMinigame.score != -1 ? String(currentMinigame.score):"-"
            
            let minigameNameLabel = cell.viewWithTag(3) as! UILabel
            minigameNameLabel.text = currentMinigame.minigameName
            
            let rankLabel = cell.viewWithTag(4) as! UILabel
            rankLabel.text = "Rank: " + (currentMinigame.rank != -1 ? String(currentMinigame.rank):"Not Ranked")
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension PlayerScoreViewController {
    
    func getPlayerHiscores() {
        HiscoreManager.shared.getPlayerHighscore(playerName, playerType: PlayerType.Normal) { (score, error) in
            if error == nil && score != nil {
                self.playerScore = score
                self.scoresTableView.reloadData()
            }
        }
    }
    
}
