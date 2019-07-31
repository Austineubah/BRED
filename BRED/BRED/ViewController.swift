//
//  ViewController.swift
//  BRED
//
//  Created by Augustine Ubah on 7/30/19.
//  Copyright © 2019 Augustine Ubah. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textMessageBox: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // allows you to listen and fetch data from text box
        textMessageBox.delegate = self
        
        sendButton.layer.cornerRadius = sendButton.frame.height/4
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        messages = []
        
        observeMessages()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        send(self)
        return true
    }
    
    @IBAction func send(_ sender: Any) {
        
        guard let message = textMessageBox.text else { return }
                
        if message != "" {
            let ref = Database.database().reference(fromURL: "https://bred-e8d96.firebaseio.com/")
            
            let usersReference = ref.child("messages")
            
            let messageID = usersReference.childByAutoId().key
            
            let textMessage = [messageID: message]
            
            //usersReference.updateChildValues(textMessage)
            
            usersReference.updateChildValues(textMessage, withCompletionBlock: { (err, ref) in
                
                // check for error with uploading email and name to Firebase Database
                if err != nil {
                    
                    print(err!)
                    return
                }
                
            })
            
            textMessageBox.text = ""
            
        }
    
    }
    
    func observeMessages() {
        
        let ref = Database.database().reference(fromURL: "https://bred-e8d96.firebaseio.com/")
        
        let usersReference = ref.child("messages")
        
        usersReference.observe(.childAdded, with: { (snapshot) in
            guard let message = snapshot.value as? String else { return }
            self.messages.append(message)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }

}

