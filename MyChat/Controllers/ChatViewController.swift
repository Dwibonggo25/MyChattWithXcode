//
//  ChatViewController.swift
//  MyChat
//
//  Created by Dwi Bonggo Pribadi on 12/19/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var message: [Message] =  [
        Message(sender: "hdey@gmail.com", body: "Hallo"),
        Message(sender: "hdey@gmail.com", body: "What?"),
        Message(sender: "hdey@gmail.com", body: "Byeee")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Chat"
        tableView.dataSource = self
        tableView.delegate = self
        
        //Deklaratif custom
        tableView.register(UINib (nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print("Logout gagal", error)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    //Position
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label?.text = message [indexPath.row].body
        print(message [indexPath.row].body)
        return cell
    }
}

//Jika pilih salah satu cell

extension ChatViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
