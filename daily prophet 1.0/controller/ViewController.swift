//
//  ViewController.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 08/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import UIKit
import AVFoundation
import ViewAnimator
import Firebase




class ViewController: UIViewController {
    let vibrate = AnimationType.from(direction: .right, offset: 5)
    let zoomOut10 = AnimationType.zoom(scale: 10)
    let zoomOut7 = AnimationType.zoom(scale: 7)
    let moveUp = AnimationType.from(direction: .bottom, offset: 1000)
    let moveLeft = AnimationType.from(direction: .right, offset: 800)
    var player: AVAudioPlayer!
    var brain = AppBrain()
    var basic = 1
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginID: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        if basic == 1{
            playSound(x: "owl")
            
            
        }
        basic = 2
        navigationController?.isNavigationBarHidden = true
        loginID.placeholder = "Login ID"
        password.placeholder = "Password"
    }
    
    
    
    override func viewDidLoad() {
        logoImage.animate(animations: [zoomOut10,moveLeft],duration: 0.8)
        titleImage.animate(animations: [ moveUp],delay: 0.2, duration : 0.6)
        titleImage.animate(animations: [ zoomOut7],delay: 0.2, duration : 0.6)
        loginID.animate(animations: [moveLeft],delay:0.7 , duration: 0.7)
        password.animate(animations: [moveLeft],delay:0.8,duration : 0.7)
        loginButton.animate(animations: [moveLeft],delay: 0.9,duration: 0.7)
        signUpButton.animate(animations: [moveLeft],delay: 1.1,duration: 0.7)
        label.animate(animations: [moveUp],delay:1.3, duration: 0.73 )
        
        
        loginButton.layer.cornerRadius = loginButton.frame.height/6
        
        let labelValue = brain.newsPaperQuotes[Int.random(in: 0...(brain.newsPaperQuotes.count-1))]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var i = 1
        label.text = "It is well said.. "
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.416)
        {
            
            self.label.text = " "
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        let pswrd = password.text ; let id = loginID.text
        Auth.auth().signIn(withEmail: id!, password: pswrd!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let e = error{
                print(e)
                strongSelf.loginID.placeholder = "Invalid Id"
                strongSelf.password.placeholder = "Invalid Password"
                strongSelf.loginID.text = ""
                strongSelf.password.text = ""
                strongSelf.loginID.animate(animations: [strongSelf.vibrate], duration: 0.6,usingSpringWithDamping:0.1)
                strongSelf.password.animate(animations: [strongSelf.vibrate],duration: 0.6,usingSpringWithDamping:0.1)
                
            }
            else {
                strongSelf.performSegue(withIdentifier: "introToMain", sender: self)
                
            }
            // ...
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "introToRegister", sender: self)
    }
    
    
    
    func playSound(x: String){
        
        let url = Bundle.main.url (forResource: x, withExtension: "mp3" )
        player = try! AVAudioPlayer(contentsOf: url!)
        
        player.play()
    }
}

