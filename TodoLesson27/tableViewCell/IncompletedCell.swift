//
//  IncompletedCell.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/18/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol RemindProtocol {
    func remindBtnPressed()
}

class IncompletedCell: UITableViewCell {
    
    var remindDelegate: RemindProtocol?
    
    @IBOutlet weak var strikeThroughLine: UIView!
    @IBOutlet weak var isDoneView: UIImageView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var titleOfTaskLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var isFirst:Bool = false
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var remindBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        tagView.layer.cornerRadius = 5
        tagView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        
    }
    
    @IBAction func remindBtnPressed(_ sender: UIButton) {
        isFirst = !isFirst
        if isFirst{
            remindBtn.setImage(#imageLiteral(resourceName: "bell"), for: .normal)
        }else{
             remindBtn.setImage(#imageLiteral(resourceName: "bell2"), for: .normal)
        }
        
        
        
        remindDelegate?.remindBtnPressed()
    }
    
}


