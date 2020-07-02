//
//  HomeVC.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/18/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit
protocol CollectionProtocol {
    func collectionViewSelected(with items: [TaskDM])
}
//MARK: - TaskDataModel
struct TaskDM: Codable {
    var id: Int
    var isDone: Bool = false
    var time: Date
    var taskTitle: String
    var taskDesc: String
    var shouldRemaind: Bool = false
    var typeOfTask: Int
    
}

//MARK: - TaskListModel
struct TaskListDM{
    var id: Int
    var title: String
    var color: UIColor
}

//MARK: - CollectionViewModel
struct DM {
    var id: Int?
    var img: UIImage?
    var title: String?
    var taskCount: String?
    var backViewColor: UIColor?
    
}

var data: [DM] = [DM(id: 0, img: #imageLiteral(resourceName: "user"), title: "Personal", taskCount: "No tasks yet",backViewColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.3075770548)),
                  DM(id: 1, img: #imageLiteral(resourceName: "briefcase"), title: "Work", taskCount: "No tasks yet", backViewColor: #colorLiteral(red: 0.100979872, green: 0.8199692369, blue: 0.003014332615, alpha: 0.2877782534)),
                  DM(id: 2, img: #imageLiteral(resourceName: "presentation"), title: "Meeting", taskCount: "No tasks yet", backViewColor: #colorLiteral(red: 0.8241401315, green: 0.009862788953, blue: 0.3883349299, alpha: 0.3060252568)),
                  DM(id: 3, img: #imageLiteral(resourceName: "study"), title: "Study", taskCount: "No tasks yet", backViewColor: #colorLiteral(red: 0.7481927872, green: 0.001008408843, blue: 0.4973296523, alpha: 0.3514287243)),
                  DM(id: 4, img: #imageLiteral(resourceName: "shoppingBag"), title: "Shopping", taskCount: "No tasks yet", backViewColor: #colorLiteral(red: 0.9270916581, green: 0.4244014323, blue: 0.04395454377, alpha: 0.3095569349)),
                  DM(id: 5, img: #imageLiteral(resourceName: "party"), title: "Party", taskCount: "No tasks yet", backViewColor: #colorLiteral(red: 0.02439733408, green: 0.6750020385, blue: 0.802734375, alpha: 0.2963666524)),
                  DM(id: 6, img: #imageLiteral(resourceName: "candy"), title: "Others", taskCount: "No tasks yet", backViewColor: #colorLiteral(red: 0.1333333333, green: 0.4745098039, blue: 0.7450980392, alpha: 0.3337435788))]

var taskListData : [TaskListDM] = [
    TaskListDM(id: 0, title: "Personal", color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
    TaskListDM(id: 1, title: "Work", color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),
    TaskListDM(id: 2, title: "Meeting", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
    TaskListDM(id: 3, title: "Study", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
    TaskListDM(id: 4, title: "Shopping",color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
    TaskListDM(id: 5, title: "Party",color: #colorLiteral(red: 0.05409421772, green: 0.6748788953, blue: 0.8069198728, alpha: 1)),
    TaskListDM(id: 6, title: "Others",color: #colorLiteral(red: 0.1333333333, green: 0.4745098039, blue: 0.7450980392, alpha: 1))
]

var taskData: [TaskDM] = []
class HomeVC: UIViewController {
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var homeImgView: UIImageView!
    @IBOutlet weak var taskImgView: UIImageView!
    @IBOutlet weak var todaysTasksCountLbl: UILabel!
    @IBOutlet weak var emptyBack: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var todaysTaskNameLbl: UILabel!
    @IBOutlet weak var timeOfTaskLbl: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    
    var n: CGFloat = 1
    var todaysTasks = 0
    var cellselectedDelegate: CollectionProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        updateTodaysTaskLabel()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IncompletedCell", bundle: nil), forCellReuseIdentifier: "IncompletedCell")
        
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        
    }
    
    func updateTodaysTaskLabel(){
        var times = [""]
        let today = Date()
        
        let calendar = Calendar.current
        let todayDate = calendar.component(.day, from: today)
        
        
        todaysTasks = 0
        for i in taskData{
            let date = calendar.component(.day, from: i.time)
            if date == todayDate && !i.isDone {
                todaysTasks += 1
            }
        }
            
        for i in 0..<taskData.count{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH':'mm dd '/' MM '/' yyyy"
            let dateStr = dateformatter.string(from: taskData[i].time)
            times.append(dateStr)
        }
        
        
        
        
        todaysTasksCountLbl.text = "Today you have \(todaysTasks) tasks"
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let encodedData = try encoder.encode(taskData)
            try encodedData.write(to: self.filePath!)
        }catch{
            print(error)
        }
    }
    
    
    func loadItems(){
        let decoder = PropertyListDecoder()
        do{
            let dat = try Data(contentsOf: filePath!)
            let decodedData = try decoder.decode([TaskDM].self, from: dat)
            taskData = decodedData
            
            tableView.reloadData()
        }catch{
            print(error)
        }
    }
    
 
    
    
    //MARK: - Change name of user
    @IBAction func nameBtnPressed(_ sender: Any) {
     
        let alert = UIAlertController(title: "Change your username", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in
           
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.userNameLbl.text = "Hello, \(alert.textFields![0].text ?? "")"
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - add task button pressed
    @IBAction func addTaskBtnPressed(_ sender: UIButton) {
       
        let vc = AddTaskVC(nibName:"AddTaskVC", bundle: nil)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    //MARK: - x button pressed
    @IBAction func xBtnPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.notificationView.isHidden = true
        }
    }
    
    
    
    
    //MARK: - taskBtnPressed
    @IBAction func taskBtnPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.x = self.view.frame.width
            self.taskImgView.image = #imageLiteral(resourceName: "task1")
            self.homeImgView.image = #imageLiteral(resourceName: "home1")
        }
        collectionView.reloadData()
        
        
    }
    //MARK: - homeBtnPressed
    @IBAction func homeBtnPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.x = 0
            self.taskImgView.image = #imageLiteral(resourceName: "task")
            self.homeImgView.image = #imageLiteral(resourceName: "home")
        }
        tableView.reloadData()
    }
    
    
}
//MARK: - Image picker section
extension HomeVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBAction func importUserPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        userPhoto.image = image
    }
}



//MARK: - TableViewDelegate and Datasource
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ///if there are no datas then sets emty background, if not then removes that background
        if taskData.count == 0{
            scrollView.isHidden = true
            emptyBack.isHidden = false
            
        }else{
            scrollView.isHidden = false
            emptyBack.isHidden = true
            
        }
        return taskData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncompletedCell", for: indexPath) as? IncompletedCell else {return UITableViewCell()}
        
        cell.remindDelegate  = self
        cell.detailDelegate = self
        cell.positionOfThisCell = indexPath.row
        taskData[indexPath.row].id = indexPath.row
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH':'mm"
        let time = dateformatter.string(from: taskData[indexPath.row].time)
        
        cell.timeLbl.text = time
        
        dateformatter.dateFormat = "dd'.'MM"
        let date = dateformatter.string(from: taskData[indexPath.row].time)
        cell.dateLbl.text = date
        
        cell.titleOfTaskLbl.text = taskData[indexPath.row].taskTitle
        
        if taskData[indexPath.row].shouldRemaind{
            cell.setRemindImage(img: #imageLiteral(resourceName: "bell"))
        }else{
            cell.setRemindImage(img: #imageLiteral(resourceName: "bell2"))
        }
        
        
        switch taskData[indexPath.row].typeOfTask {
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
        case 5:
            cell.tagView.backgroundColor = #colorLiteral(red: 0.05409421772, green: 0.6748788953, blue: 0.8069198728, alpha: 1)
        default:
            cell.tagView.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4745098039, blue: 0.7450980392, alpha: 1)
        }
        
        
        if taskData[indexPath.row].shouldRemaind{
            cell.remindBtn.setImage(#imageLiteral(resourceName: "bell"), for: .normal)
        }else{
            cell.remindBtn.setImage(#imageLiteral(resourceName: "bell2"), for: .normal)
        }
        
        if taskData[indexPath.row].isDone{
            cell.isDoneView.image = #imageLiteral(resourceName: "checked")
            cell.strikeThroughLine.isHidden = false
        }else{
            cell.isDoneView.image = #imageLiteral(resourceName: "unchecked")
            cell.strikeThroughLine.isHidden = true
        }
        
        
        return cell
    }
    
    // MARK: - Did select function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskData[indexPath.row].isDone = !taskData[indexPath.row].isDone
        updateTodaysTaskLabel()
        tableView.reloadData()
    }
    
    
    // MARK: - Deleting row function
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            taskData.remove(at: indexPath.row)
           
            self.saveItems()
            self.updateTodaysTaskLabel()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
           
            
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9882352941, blue: 1, alpha: 1)
        deleteAction.image = #imageLiteral(resourceName: "delete")
        
        //actions digan joyga hutti bir hil qilib deleteaction dagidek action yasab qoshishim mumkin, ketma ket chiqoradi
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10 + 8
    }
    
    
    
}


//MARK: - Protocols
extension HomeVC: AddTaskDelegate, RemindProtocol, DetailProtocol{
    func detailBtnPressed(position: Int) {
        let alert = UIAlertController(title: taskData[position].taskTitle, message: taskData[position].taskDesc, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func remindBtnPressed(position: Int) {
        taskData[position].shouldRemaind = !taskData[position].shouldRemaind
        tableView.reloadData()
        
    }
    
    
    func doneWith(task: TaskDM) {
        taskData.append(task)
        saveItems()
        tableView.reloadData()
        updateTodaysTaskLabel()
    }
    
    
}


//MARK: - CollectionView Delegate and Datasource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? TaskCell else {return UICollectionViewCell()}
        var zero: Int = 0
        var one: Int = 0
        var two: Int = 0
        var three: Int = 0
        var four: Int = 0
        var five: Int = 0
        var six: Int = 0
        for i in taskData{
            switch i.typeOfTask {
            case 0:
                zero += 1
            case 1:
                one += 1
            case 2:
                two += 1
            case 3:
                three += 1
            case 4:
                four += 1
            case 5:
                five += 1
                
            default:
                six += 1
            }
        }
        switch data[indexPath.item].id {
        case 0:
            data[indexPath.item].taskCount = "\(zero) tasks"
        case 1:
            
            data[indexPath.item].taskCount = "\(one) tasks"
        case 2:
            
            data[indexPath.item].taskCount = "\(two) tasks"
        case 3:
            
            data[indexPath.item].taskCount = "\(three) tasks"
        case 4:
            
            data[indexPath.item].taskCount = "\(four) tasks"
        case 5:
                       
            data[indexPath.item].taskCount = "\(five) tasks"
        default:
            
            data[indexPath.item].taskCount = "\(six) tasks"
        }
        
        cell.titleInCell.text = data[indexPath.item].title
        cell.imgView.image = data[indexPath.item].img
        cell.numberTasks.text = data[indexPath.item].taskCount
        cell.backColorView.backgroundColor = data[indexPath.item].backViewColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var datas: [TaskDM] = []
        switch indexPath.item {
        case 0:
            for i in taskData where i.typeOfTask == 0{
                datas.append(i)
            }
        case 1:
            for i in taskData where i.typeOfTask == 1{
                datas.append(i)
            }
        case 2:
            for i in taskData where i.typeOfTask == 2{
                datas.append(i)
            }
        case 3:
            for i in taskData where i.typeOfTask == 3{
                datas.append(i)
            }
        case 4:
            for i in taskData where i.typeOfTask == 4{
                datas.append(i)
            }
        case 5:
            for i in taskData where i.typeOfTask == 5{
            datas.append(i)
        }
        default:
            
            for i in taskData where i.typeOfTask == 6{
                datas.append(i)
            }
        }
        
        
        let vc = TasksVC(nibName: "TasksVC", bundle: nil)
        
        self.cellselectedDelegate = vc
        
        
        self.present(vc, animated: true)
        cellselectedDelegate?.collectionViewSelected(with: datas)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = collectionView.frame.width/2 - 30
        return CGSize(width: size, height: size + 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
}


//MARK: - Adding strikethrough line
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}


