//
//  newsScreen.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 10/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import UIKit
import Foundation
import Firebase


class newsScreen: UIViewController  , UITableViewDataSource{
    
    var image : UIImage = #imageLiteral(resourceName: "Daily Prophet Logo")
    let db = Firestore.firestore()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NewsCell
        let docRef = db.collection("query of \(String(describing: (Auth.auth().currentUser?.email)!))").document("\(x)")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data()
                {
                    cell.title.text = data["title"] as? String
                    cell.author.text = data["author"] as? String
                    cell.Description.text = data["description"] as? String
                    cell.content.text = data["content"] as? String
                    let imageURL = data["imageURL"] as? String
                    cell.imageContent.image = self.GetImage(imageURL ?? "none")
                }
            } else {
                print("Document does not exist")
            }
        }
        /**/
        x+=1
        print(x)
        return cell
    }
    
    
    
    var query : String?
    var x = 1
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var brain = AppBrain()
    
    
    override func viewDidLoad() {
        var x = 1
        super.viewDidLoad()
        tableView.register(UINib(nibName:"NewsCell", bundle: nil), forCellReuseIdentifier:"ReusableCell" )
        tableView.dataSource = self
        while x<15{
            brain.fetchSearchTopic(query ?? "none", x)
            x+=1
        }
    }
    
    /*override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
       
    }*/
    override func viewWillDisappear(_ animated: Bool) {
         var y = 1
               while y<15{
                   db.collection("query of \(String(describing: (Auth.auth().currentUser?.email)!))").document("\(y)").delete()
                   y+=1
               }
    }
    // MARK: - Nav
    //test
    
    func GetImage (_ url : String)->UIImage
    {
        if let urlString = URL(string: url)
        {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlString) { (data, urlResponse, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                if let res = urlResponse as? HTTPURLResponse {
                        print("Downloaded the picture with response code \(res.statusCode)")
                        if let imageData = data {
                            // Finally convert that Data into an image and do what you wish with it.
                            self.image = UIImage(data: imageData) ?? #imageLiteral(resourceName: "Daily Prophet Logo")
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }
        task.resume()
        
        }
        return image
    }
   
}
    

