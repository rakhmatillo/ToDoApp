//
//  WelcomeVC.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/18/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    @IBAction func getStartPressed(_ sender: UIButton) {
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        UserDefaults.standard.setValue(true, forKey: "isOld")
        self.present(vc, animated: true, completion: nil)
        
    }
    
   

}
