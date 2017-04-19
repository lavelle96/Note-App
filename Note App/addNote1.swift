//
//  addNote1.swift
//  Note App
//
//  Created by Daniel Lavelle on 18/04/2017.
//  Copyright © 2017 Daniel Lavelle. All rights reserved.
//

import UIKit

class addNote1: UIViewController {

    
    var noteTitle = ""
    @IBOutlet weak var textFieldTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func titleInput(_ sender: AnyObject){
        noteTitle = textFieldTitle.text!
        self.performSegue(withIdentifier: "SegueToAddNote2", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToAddNote2"
        {
            let vc = segue.destination as! addNote2
            vc.noteTitle = noteTitle
        }
    }
    
}
