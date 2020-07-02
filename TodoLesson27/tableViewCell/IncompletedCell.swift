//
//  IncompletedCell.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/18/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol RemindProtocol {
    func remindBtnPressed(position: Int)
}

protocol DetailProtocol {
    func detailBtnPressed(position: Int)
}

class IncompletedCell: UITableViewCell {
    
    var remindDelegate: RemindProtocol?
    var detailDelegate: DetailProtocol?
   
    var positionOfThisCell = 0
    
    
    
    @IBOutlet weak var strikeThroughLine: UIView!
    @IBOutlet weak var isDoneView: UIImageView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var titleOfTaskLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var remindBtn: UIButton!
    
    @IBOutlet weak var detailBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        tagView.layer.cornerRadius = 5
        tagView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        
    }
    
    func setRemindImage(img: UIImage){
        remindBtn.setImage(img, for: .normal)
    }
    
    @IBAction func remindBtnPressed(_ sender: UIButton) {

        remindDelegate?.remindBtnPressed(position: positionOfThisCell)
    }
    
    
    @IBAction func detailBtnPressed(_ sender: Any) {
        detailDelegate?.detailBtnPressed(position: positionOfThisCell)
    }
}


