//
//  ViewController.swift
//  ManageEvent
//
//  Created by TMA on 26/05/2021.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let eventManager : EventManager = EventManager()
    let tableView : UITableView = {
        let tableView : UITableView = UITableView()
//        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    var listEvent : [EKCalendar] = [EKCalendar]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()
        }
        
        cell.configure(event: listEvent[indexPath.row])
        
        return cell
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidAppear(_ xanimated: Bool) {
        
        let authorStatus:Bool = self.eventManager.checkAuthorization()
        
        print("Status author (Checking): \(authorStatus)")
        
        // CHECK AUTHOR IF FALSE(.denied) -> ALERT
        if !authorStatus {
            // ALERT
            // CREATE ACTION
            var actions : [UIAlertAction] = []
            actions.append(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            
            
            self.customAlert(title: "Calendar access denied", message: "null temp", preferredStyle: UIAlertController.Style.alert, alertActions: actions, animated: true, completion: nil)
        } else {
            
            listEvent = eventManager.loadCalendar()
            tableView.reloadData()
        }
    }
    
    private func customAlert(title:String, message:String, preferredStyle:UIAlertController.Style, alertActions:[UIAlertAction], animated:BooleanLiteralType, completion:(() -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in alertActions {
            alertController.addAction(action)
        }
        
        print("Present alert")
        present(alertController, animated: true, completion: completion)
    }
    
}
