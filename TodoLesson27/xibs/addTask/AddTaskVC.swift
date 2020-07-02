//
//  AddTaskVC.swift
//  TodoLesson27
//
//  Created by Rakhmatillo Topiboldiev on 12/23/19.
//  Copyright © 2019 Rakhmatillo Topiboldiev. All rights reserved.
//

import UIKit

protocol AddTaskDelegate {
    func doneWith(task: TaskDM)
}

class AddTaskVC: UIViewController, UITextFieldDelegate {
    
    var delegate: AddTaskDelegate?
    var selectedList: TaskListDM?
    var bool = false
    
    @IBOutlet weak var choosenDateLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var plusImg: UIImageView!
    @IBOutlet weak var taskTextFld: UITextField!
    @IBOutlet weak var descLTextFld: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
        
        taskTextFld.delegate = self
        descLTextFld.delegate = self

        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())

        datePicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        
    }
    

    
    @objc func valueChanged(){
        if let datePicker = datePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH':'mm dd '/' MM '/' yyyy"
           
            choosenDateLbl.text = dateformatter.string(from: datePicker.date)
         
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.cardImageView.transform = CGAffineTransform(scaleX: 1, y: 1.05)
        }) { (_) in
            UIView.animate(withDuration: 0.3){
                self.cardImageView.transform = .identity
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.plusImg.transform = CGAffineTransform(rotationAngle: .pi/4)
            }) { (_) in
                
            }
        }
        
    }
    
    //MARK: - close button pressed
    @IBAction func closePressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations:  {
            self.plusImg.transform = .identity
        }) {(_) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    //MARK: - done button pressed
    @IBAction func donePressed(_ sender: UIButton) {
        if let list = selectedList{
            UIView.animate(withDuration: 0.3, animations:  {
                self.plusImg.transform = .identity
            }){(_) in
                
                ///converting string date to Date type
                let stringDate = self.choosenDateLbl.text!
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "HH':'mm dd '/' MM '/' yyyy"
                let date = dateformatter.date(from: stringDate)
                if !self.choosenDateLbl.text!.contains("C"){
                    let item = TaskDM(id: 0, isDone: false, time: date!, taskTitle: self.taskTextFld.text!, taskDesc: self.descLTextFld.text! , shouldRemaind: false, typeOfTask: list.id)
                    self.delegate?.doneWith(task: item)
                }
                
                
                
            }
        }else{
            
        }
        UIView.animate(withDuration: 0.2, animations:  {
            self.plusImg.transform = .identity
        }) {(_) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    //MARK: - Choose Date button pressed
    @IBAction func chooseDate(_ sender: UIButton) {
        bool = !bool
        UIView.animate(withDuration: 0.3) {
            self.datePicker.isHidden = !self.datePicker.isHidden
            
        }
        if bool{
        sender.setTitle("tap to close", for: .normal)
        }else{
           sender.setTitle("tap to choose", for: .normal)
        }
    }
}

//MARK: - Extension CollectionView

extension AddTaskVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        taskListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else {return UICollectionViewCell()}
        cell.updateCell(data: taskListData[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListCell else {return}
        cell.cellsSelected()
        selectedList = taskListData[indexPath.item]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3, height: 50)
    }
}
