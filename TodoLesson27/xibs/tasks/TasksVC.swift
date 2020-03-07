//
//  TasksVC.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 1/15/20.
//  Copyright © 2020 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

class TasksVC: UIViewController {
    
    var tasklistdata: [TaskDM] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
         tableView.register(UINib(nibName: "IncompletedCell", bundle: nil), forCellReuseIdentifier: "IncompletedCell")
    }
    
    
    
}

extension TasksVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasklistdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncompletedCell", for: indexPath) as? IncompletedCell else {return UITableViewCell()}
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH':'mm"
        let time = dateformatter.string(from: tasklistdata[indexPath.row].time)
        
        cell.timeLbl.text = time
        
        dateformatter.dateFormat = "dd'.'MM"
        let date = dateformatter.string(from: taskData[indexPath.row].time)
        cell.dateLbl.text = date
        
        cell.titleOfTaskLbl.text = tasklistdata[indexPath.row].taskTitle
        switch tasklistdata[indexPath.row].typeOfTask {
               case 0:
                   cell.tagView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
               case 1:
                   cell.tagView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
               case 2:
                   cell.tagView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
               case 3:
                   cell.tagView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
               case 4:
                   cell.tagView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                   
               default:
                   cell.tagView.backgroundColor = #colorLiteral(red: 0.05409421772, green: 0.6748788953, blue: 0.8069198728, alpha: 1)
               }
               
               
               if tasklistdata[indexPath.row].shouldRemaind{
                   cell.remindBtn.setImage(#imageLiteral(resourceName: "bell"), for: .normal)
               }else{
                   cell.remindBtn.setImage(#imageLiteral(resourceName: "bell2"), for: .normal)
               }
               
               if tasklistdata[indexPath.row].isDone{
                   cell.isDoneView.image = #imageLiteral(resourceName: "checked")
                   cell.strikeThroughLine.isHidden = false
               }else{
                   cell.isDoneView.image = #imageLiteral(resourceName: "unchecked")
                   cell.strikeThroughLine.isHidden = true
               }
               
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasklistdata[indexPath.row].isDone = !tasklistdata[indexPath.row].isDone
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
}

extension TasksVC: CollectionProtocol{
    func collectionViewSelected(with items: [TaskDM]) {

        tasklistdata = items
     
        tableView.reloadData()
    }
    
    
}
