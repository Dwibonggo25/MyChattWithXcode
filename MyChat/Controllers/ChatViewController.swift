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
    
    let db = Firestore.firestore()
    
    var message: [Message] =  []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Chat"
        tableView.dataSource = self
        tableView.delegate = self
        
        //Deklaratif custom
        tableView.register(UINib (nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        //To display message
        loadMessage()
    }
    
    func loadMessage(){
        
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.message = []
            if let e = error {
                print("error dimary \(e)")
            }else {
                if let snapshoot = querySnapshot?.documents {
                    for doc in snapshoot {
                        let data = doc.data()
                        if let senderMeesgae = data[Constants.FStore.senderField] as? String, let bodyMessage = data[Constants.FStore.bodyField] as? String {
                            let newMessage = Message(sender: senderMeesgae, body: bodyMessage)
                            self.message.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
               // querySnapshot?.documents[0].data()[Constants.FStore.senderField, Cons]
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody, Constants.FStore.dateField: Date().timeIntervalSince1970]){(error) in
                if let e = error {
                    print("Gagal: ",e.localizedDescription)
                }else {
                    print("Succes")
                }
                
            }
        }
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
