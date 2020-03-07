//
//  TaskCell.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 1/9/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class TaskCell: UICollectionViewCell {

    @IBOutlet weak var titleInCell: UILabel!
    @IBOutlet weak var backColorView: UIView!
    @IBOutlet weak var numberTasks: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
