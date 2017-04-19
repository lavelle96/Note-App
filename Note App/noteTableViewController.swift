//
//  noteTableViewController.swift
//  Note App
//
//  Created by Daniel Lavelle on 19/04/2017.
//  Copyright © 2017 Daniel Lavelle. All rights reserved.
//

import UIKit
import SwiftyDropbox

class noteTableViewController: UITableViewController {

    var noteTitles = [String]()
    
    var noteTitleInQuestion = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateArray()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return noteTitles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "noteTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? noteTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let noteTitle = noteTitles[indexPath.row]
        cell.noteTitle.text = noteTitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        self.noteTitleInQuestion = noteTitles[indexPath.row]
        
        self.performSegue(withIdentifier: "SegueToShowNote", sender: self)
    }


    
    func updateArray() {
        let path = "/Notes"
        self.noteTitles = [String]()
        self.tableView.beginUpdates()
        if let client = DropboxClientsManager.authorizedClient {
            client.files.listFolder(path: path).response { response, error in
                if let result = response {
                    
                    for entry in result.entries {
                        
                        
                        let fileName = entry.name
                        
                        let endIndex = fileName.index(fileName.endIndex, offsetBy: -4)
                        
                        
                        let noteName = fileName.substring(to: endIndex)
                        
                        self.noteTitles.append(noteName)
                        self.tableView.insertRows(at: [IndexPath(row: self.noteTitles.count-1, section: 0)], with: .automatic)
                        
                        
                    }
                    
                    self.tableView.endUpdates()
                    print("Array updates grand")
                    
                    
                }
                
            }
            
        }
    }
    
    
    
    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        super.prepare(for: segue, sender: sender)
 
        if segue.identifier == "SegueToShowNote"
        {
            let vc = segue.destination as? showNote
 
 
            vc?.noteTitle = noteTitleInQuestion
        }
 }

}
