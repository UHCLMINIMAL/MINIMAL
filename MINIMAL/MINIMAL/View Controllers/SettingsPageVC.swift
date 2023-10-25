//
//  SettingsViewController.swift
//  MINIMAL
//
//  Created by Chintu Chowdary on 10/24/23.
//

import UIKit

class SettingsPageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var settingsTableView: UITableView!
    
    private var settingsList = ["Account", "Notifications", "Appearance", "Privacy & Security", "Help & Support", "About"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        settingsTableView.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settingsList[indexPath.row]
        let settingsCell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        settingsCell.textLabel?.text = setting
        settingsCell.imageView?.image = UIImage(named: setting)
        settingsCell.accessoryType = .disclosureIndicator
        
        return settingsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

}
