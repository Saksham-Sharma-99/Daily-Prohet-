//
//  RegisterScreen.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 08/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import UIKit
import ViewAnimator
import Firebase




class RegisterScreen: UIViewController , UITextFieldDelegate {
    let vibrate = AnimationType.from(direction: .right, offset: 5)
    let zoomIn = AnimationType.zoom(scale: 0.11)
    let moveRight = AnimationType.from(direction: .left, offset: 1700)
    let moveLeft = AnimationType.from(direction: .right, offset: 120)
    
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    
    override func viewDidLoad() {
        logo.animate(animations: [moveRight],duration: 0.9)
        logo.animate(animations: [zoomIn],duration: 0.9)
        email.animate(animations: [moveLeft],delay: 1.2,duration: 0.8)
        password.animate(animations: [moveLeft],delay: 1.4,duration: 0.8)
        registerButton.animate(animations: [moveLeft],delay: 1.6,duration: 0.7)
        
        password.delegate = self
        email.delegate = self
        
        let labelValue = "The modern Newspaper"
        var i = 1
        super.viewDidLoad()
        registerButton.layer.cornerRadius = registerButton.frame.height/6
        // Do any additional setup after loading the view.
        label.text = " "
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
        {
        repeat
        {
        for x in labelValue
        {
            Timer.scheduledTimer(withTimeInterval: 0.018*Double(i), repeats: false) { (timer) in
                self.label.text?.append(x)
            }
            i+=1
        }
            
        }while(i < labelValue.count)
        
        }
        
    }
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButton(_ sender: UIButton) {
        let id = email.text; let pswrd = password.text
        
        Auth.auth().createUser(withEmail: id!, password: pswrd!) { (authResult, error) in
            if let e = error
            {
                print(e)
                self.email.placeholder = "Invalid Id Type"
                self.email.text = ""
                self.password.text = ""
                self.email.animate(animations: [self.vibrate], duration: 0.6,usingSpringWithDamping:0.1)
                self.password.animate(animations: [self.vibrate],duration: 0.6,usingSpringWithDamping:0.1)
            }
            else{
                self.performSegue(withIdentifier: "registerToMain", sender: self)
                
            }
        }
        
        
        
    }
 
    
}
