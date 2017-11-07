//
//  showNote.swift
//  Note App
//
//  Created by Daniel Lavelle on 19/04/2017.
//  Copyright © 2017 Daniel Lavelle. All rights reserved.
//

import UIKit
import SwiftyDropbox

class showNote: UIViewController {

    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    var edtble = false
    var path = ""
    var noteTitle = ""
    var noteContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = noteTitle
        
        self.path = "/Notes/"+noteTitle+".txt"
        
        if let client = DropboxClientsManager.authorizedClient{
        
        
         
        
        client.files.download(path: path)
                .response { response, error in
                    if let response = response {
                        let responseMetadata = response.0
                        print(responseMetadata)
                        let fileContents = response.1
                        self.noteContentTextView.text = String(data: fileContents, encoding: String.Encoding.utf8) as String!
                    } else if let error = error {
                        print(error)
                    }
                }
                .progress { progressData in
                    print(progressData)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func mainButtonPressed(){
        
       
        performSegue(withIdentifier: "SegueFromShowNoteToMain", sender: self)
    }
    
    @IBAction func editButtonPressed(){
        self.edtble = true
        noteContentTextView.isEditable = true
        editButton.setTitle("Click on the note to edit it!", for: UIControlState.normal )
    }
    
    @IBAction func deleteButtonPressed(){
        let client = DropboxClientsManager.authorizedClient
        
        client?.files.deleteV2(path: self.path).response { response, error in
            if let response = response {
                print(response)
                
            }
            
                  
        }
        performSegue(withIdentifier: "SegueFromShowNoteToMain", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueFromShowNoteToMain"
        {
            if edtble == true
            {
                
                let textContent = noteContentTextView.text
                let textData:Data? = textContent?.data(using: String.Encoding.utf8)
                let client = DropboxClientsManager.authorizedClient!
                client.files.deleteV2(path: self.path).response { response, error in
                    if let response = response {
                        print(response)
                        
                    }
                }
                client.files.upload(path: self.path, input: textData!)
                    .response { response, error in
                        if let response = response {
                            print(response)
                        } else if let error = error {
                            print(error)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                }
            
            }
            
                
        }
    
    }
    

}
