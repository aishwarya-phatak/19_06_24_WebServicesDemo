//
//  UserDefaultsViewController.swift
//  19_06_24_WebServicesDemo
//
//  Created by Vishal Jagtap on 30/07/24.
//

import UIKit

//UserDefaults
class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneNumbertextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retriveDataFromUserDefaults()       
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        let extractedusername = self.usernameTextField.text
        let extractedPhoneNumber = self.phoneNumbertextField.text
        let extractedPassword = self.passwordTextField.text
        
        //to save data to user defaults
        userDefaults.setValue(extractedusername, forKey: "username")
        userDefaults.setValue(extractedPhoneNumber, forKey: "phonenumber")
        userDefaults.setValue(extractedPassword, forKey: "password")
        
    }
    
    private func retriveDataFromUserDefaults(){
        
        //you can use datatype sepcific method to extract data from userdefaults
        print(self.userDefaults.string(forKey: "username")!)
        print(self.userDefaults.string(forKey: "phonenumber")!)
        print(self.userDefaults.string(forKey: "password")!)
        
        
        //you can use value method to extract data from userdefaults
        
        print(self.userDefaults.value(forKey: "username")!)
    }
}
