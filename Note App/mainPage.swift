//
//  ViewController.swift
//  Note App
//
//  Created by Daniel Lavelle on 17/04/2017.
//  Copyright © 2017 Daniel Lavelle. All rights reserved.
//

import UIKit
import SwiftyDropbox


class mainPage: UIViewController {
    
    var canLeave = false
    var noteTitles = [String]()
    //MARK: Properties
    @IBOutlet weak var dbSignInButton: UIButton!
    @IBOutlet weak var dbSignOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let client = DropboxClientsManager.authorizedClient
        
        if client != nil
        {
            client?.users.getCurrentAccount().response { response, error in
                
                if let account = response {
                    self.dbSignInButton.setTitle("Hello "+account.name.givenName, for: UIControlState.normal)
                } else {
                    print(error!)
                }
            }
            
            //Change the label value of the Dropbox sign in button to the user id
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func addButtonPressed(_ sender: AnyObject){
        self.performSegue(withIdentifier: "SegueToAddNote1", sender: self)
    }
    
    @IBAction func linkButtonPressed(_ sender: AnyObject){
        DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: self, openURL: {(url: URL) -> Void in UIApplication.shared.open(url, options:[:], completionHandler: nil)})
        
        let client = DropboxClientsManager.authorizedClient
        client?.users.getCurrentAccount().response { response, error in
            
            if let account = response {
                self.dbSignInButton.setTitle("Hello "+account.name.givenName, for: UIControlState.normal)
            } else {
                print(error!)
            }
        }
        
    }
    @IBAction func showNotesButtonPressed(_ sender: AnyObject){

        performSegue(withIdentifier: "SegueToTableView", sender: self)
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: AnyObject){
        
        DropboxClientsManager.unlinkClients()
        dbSignInButton.setTitle("Sign In!", for: UIControlState.normal)
     
    }

    //MARK: Actions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}

