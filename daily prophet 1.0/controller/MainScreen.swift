//
//  MainScreen.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 08/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import UIKit
import Firebase

class MainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let db = Firestore.firestore()
    var query : String?
    var brain = AppBrain()
    var cell = TopicCell()
    @IBOutlet weak var searchField: UITextField!
    
    var topics = [CellDetail(title: "Top News", subTitle: "The most Recent Events"),CellDetail(title: "World", subTitle: "All the latest news from around the globe"), CellDetail(title: "National", subTitle: "The hot topics of your country"),CellDetail(title: "Business", subTitle: "Stocks,Finance,Economy etc. All at one stop"), CellDetail(title: "Technology", subTitle: "Advancement in machinery,softwares,computing languages etc"),CellDetail(title: "Entertainment", subTitle: "Gossips of your favourite celebrities,tv shows,movies,musicals etc"),CellDetail(title: "Science", subTitle: "Resesrch papers, Discoveries, New Theories"),CellDetail(title: "Health", subTitle: "Medical advancement, New Vaccies & medecines , Major Health issues"),CellDetail(title: "Sports", subTitle: "NBA,FIFA,NFL,Cricket,Baseball etc.")]
    
    @IBAction func searchButton(_ sender: Any) {
        performSegue(withIdentifier: "mainToNews", sender: self)
        query = searchField.text!
        searchField.endEditing(true)
    }
    
    
    @IBAction func ExitButton(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        tableView.register(UINib(nibName:"TopicCell", bundle: nil), forCellReuseIdentifier:"ReusableCell" )
        tableView.dataSource = self
        tableView.delegate = self
        query = nil
       var y = 1
        while y<15{
            db.collection("query of \(String(describing: (Auth.auth().currentUser?.email)!))").document("\(y)").setData(["number" : y,
                "author": "anonymous",
            "content":  "",
            "description": "",
            "imageURL":  "",
            "url": "",
            "title": ""])
            y+=1
        // Do any additional setup after loading the view.
    }
    }
    override func viewDidDisappear(_ animated: Bool) {
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TopicCell
        cell.title.text = topics[indexPath.row].title
        cell.itsDescription.text = topics[indexPath.row].subTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        switch (indexPath.row)
        {
            
        case 1 : query = "world" ;performSegue(withIdentifier: "mainToNews", sender: self)
        case 2 : query = "nation" ;performSegue(withIdentifier: "mainToNews", sender: self)
        case 3 : query = "business" ;performSegue(withIdentifier: "mainToNews", sender: self)
        case 4 : query = "technology" ;performSegue(withIdentifier: "mainToNews", sender: self)
        case 5 : query = "entertainment" ;performSegue(withIdentifier: "mainToNews", sender: self)
        case 6 : query = "science" ; performSegue(withIdentifier: "mainToNews", sender: self)
        case 7 : query = "health" ;performSegue(withIdentifier: "mainToNews", sender: self)
        case 8 : query = "sports" ;performSegue(withIdentifier: "mainToNews", sender: self)
        default:
            query = "headlines" ;performSegue(withIdentifier: "mainToNews", sender: self)
        }
        
    }
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//MARK:-
extension MainScreen: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end4")
        query = textField.text!
        
        
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""
        {print("end3")
            return true}
        else {
            print("end2")
            textField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("end1")
        query = textField.text!
        performSegue(withIdentifier: "mainToNews", sender: self)
        
        searchField.endEditing(true)
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToNews"
        {
            let news = segue.destination as! newsScreen
            
            news.query = query
            
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}



struct CellDetail {
    var title: String
    var subTitle : String
}




