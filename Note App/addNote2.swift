//
//  addNote2.swift
//  Note App
//
//  Created by Daniel Lavelle on 18/04/2017.
//  Copyright © 2017 Daniel Lavelle. All rights reserved.
//

import UIKit
import SwiftyDropbox

class addNote2: UIViewController {

    var noteTitle = ""
    var noteContent = ""
    
   
    
    @IBOutlet weak var noteInputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = noteTitle
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject){

                
        
        
        let path = "/Notes/"+noteTitle+".txt"
        
        noteContent = noteInputTextView.text
        let textContent = noteContent
        let textData:Data? = textContent.data(using: String.Encoding.utf8)
        
        
        print("sourcePath")
        let client = DropboxClientsManager.authorizedClient!
        client.files.upload(path: path, input: textData!)
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
    
            
        performSegue(withIdentifier: "SeguetoMain", sender: self)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
