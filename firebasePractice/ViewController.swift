//
//  ViewController.swift
//  firebasePractice
//
//  Created by MC975-107 on 27/09/2019.
//  Copyright © 2019 comso. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource {
    
    var ref : DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    var todos = [String]()
    
    override func viewDidLoad() {
        let rootRef = Database.database().reference()
        rootRef.child("memos").observe(.value) { snapshot in
            
            let memosDic = snapshot.value as? [String: Any] ?? [:]
            for (key, value) in memosDic {
                print("key \(key) value\(value)")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel!.text = self.todos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.todos.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    @IBAction func addTodo(_ sender: Any) {
        let dialog = UIAlertController(title: "새 할일 추가", message: nil, preferredStyle: .alert)
        dialog.addTextField()
        let okAction = UIAlertAction(title: "확인", style: .default) { (action : UIAlertAction) in
            if let newTodo = dialog.textFields?[0].text {
                print("입력할 할일 : \(newTodo)")
                self.todos.append(newTodo)
                self.tableView.reloadData()
                /*
                self.ref = Database.database().reference()
                // ref에 fireDatabase의 주소를 넣어줍니다.
                // reference는 데이터베이스의 특정 위치를 나타내며, 해당 데이터베이스 위치로 데이터를 읽거나 쓸 수 있게 만들어 줍니다.
                let itemsRef = self.ref.child("list")
                let itemRef = itemsRef.childByAutoId()
                //데이터베이스의 위치(ref)의 child라고 하네요.
                //child는 지정된 상대 경로에있는 위치의 주소를 가져오는 프로퍼티
                itemRef.setValue(["title": newTodo])
                */
            }
            
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        self.show(dialog, sender: nil)
    }
}

