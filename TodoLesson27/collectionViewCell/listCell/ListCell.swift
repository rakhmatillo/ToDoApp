//
//  ListCell.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/24/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var selectedLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func updateCell(data: TaskListDM){
        colorView.backgroundColor = data.color
        titleLbl.text = data.title
        selectedLbl.text = data.title
        selectedLbl.backgroundColor = data.color
        selectedLbl.isHidden = !self.isSelected
   
    }
    
    func cellsSelected(){
        selectedLbl.isHidden = !selectedLbl.isHidden
    }
}
