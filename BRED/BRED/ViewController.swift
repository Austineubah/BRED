//
//  ViewController.swift
//  BRED
//
//  Created by Augustine Ubah on 7/30/19.
//  Copyright © 2019 Augustine Ubah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textMessageBox: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textMessageBox.delegate = self
        
        sendButton.layer.cornerRadius = sendButton.frame.height/4
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        send(self)
        return true
    }
    
    @IBAction func send(_ sender: Any) {
        guard let message = textMessageBox.text else {
            textMessageBox.text = ""
            return
        }
        
        print(message)
        textMessageBox.text = ""
    }

}

