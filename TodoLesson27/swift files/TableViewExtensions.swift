//
//  TableViewExtensions.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/22/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

extension UITableView{
    func SetEmptyBackground(with img: UIImage, title: String, subtitle: String){
        
        let backView = UIView(frame: self.frame)
        backView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9882352941, blue: 1, alpha: 1)
        
        let imgView = UIImageView()
        
        imgView.frame = CGRect(x: self.frame.width / 3, y: self.frame.height / 4, width: self.frame.width / 3, height: self.frame.width / 3 + 20)
        
        imgView.image = img
        imgView.contentMode = .scaleAspectFit
        
        backView.addSubview(imgView)
        
        let lbl1 = UILabel(frame: CGRect(x: 20, y: self.frame.height / 4 +  self.frame.width / 3 + 50, width: self.frame.width - 40, height: 30))
        
        lbl1.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        lbl1.textColor = #colorLiteral(red: 0.3333333333, green: 0.3058823529, blue: 0.5607843137, alpha: 1)
        lbl1.text = title
        lbl1.numberOfLines = 1
        lbl1.textAlignment = .center
        
        backView.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect(x: 30, y: self.frame.height / 4 +  self.frame.width / 3 + 90, width: self.frame.width - 60 , height: 60))
        lbl2.numberOfLines  = 3
        lbl2.textAlignment = .center
        lbl2.font = UIFont.systemFont(ofSize: 17 , weight: .regular)
        lbl1.textColor = #colorLiteral(red: 0.5098039216, green: 0.6274509804, blue: 0.7176470588, alpha: 1)
        lbl2.text  = subtitle
        
        backView.addSubview(lbl2)
        
        
        self.backgroundView = backView
        
        
        
        
    }
    
    
    func removeEmptyBackground(){
        self.backgroundView = nil
    }
}
