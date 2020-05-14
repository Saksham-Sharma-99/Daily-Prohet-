//
//  AppBrain.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 08/05/20.
//  Copyright © 2020 sharma. All rights reserved.
import Foundation
import Firebase

//
struct AppBrain
{
    let db = Firestore.firestore()
    
    var newsPaperQuotes = ["If you don't read the newspaper, you are uninformed. If you do read the newspaper, you are misinformed.","The newspaper is in all its literalness the bible of democracy, the book out of which a people determines its conduct.","Like the newspapers used to say, if the truth isn't big enough, you print the legend.","A newspaper is a device for making the ignorant more ignorant and the crazy crazier.","A good newspaper is never nearly good enough but a lousy newspaper is a joy forever.","Journalism is popular, but it is popular mainly as fiction. Life is one world, and life seen in the newspapers another.","Let me make the newspapers, and I care not what is preached in the pulpit or what is enacted in congress.","A newspaper is not only a collective propagandist and a collective agitator, it is also a collective organiser.","The noiseless din that we have long known in dreams, booms at us in waking hours from newspaper headlines.","Newspapers which undertake to lead public sentiment generally fall into a ditch.","Newspapers always excite curiosity. No one ever lays one down without a feeling of disappointment."]
    
    //c933ae15dbce6fdd2690d11d66031779
    let siteURL = "https://newsapi.org/v2/everything?apiKey=055d9656a7434d68aa0dd5fbe89380d3"
    
    
    func fetchSearchTopic(_ searchTopic: String , _ articleNumber: Int){
        let text = searchTopic
        var newText = ""
        for x in text {
            if x == " "
            {
                newText.append("%20")
            }
            else
            {
                newText.append(x)
            }
            
        }
        
        let url = "\(siteURL)&q=\(newText)&from=\(date())"
       
        performRequest(url , articleNumber)
    }
    
    func performRequest(_ URLString : String , _ articleNumber : Int)
        {
            //Create URL
            if let url = URL(string: URLString)
            {
                //Create urlSession
                let session = URLSession(configuration: .default)
                
                //Give session a task
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print (error!)
                    }
                        
                    else {
                        let safeData = data!
                      if let news =  self.parseJSON(data: safeData , articleNumber)
                        {
                            DispatchQueue.main.async {
                                
                                self.db.collection("query of \(String(describing: (Auth.auth().currentUser?.email)!))").document("\(articleNumber)").setData([
                                    "number" : articleNumber,
                                    "author": news.author ?? "anonymous",
                                "content": news.content ?? "",
                                "description": news.description ?? "",
                                "imageURL": news.urlToImage ?? "",
                                "url": news.url,
                                "title": news.title]){ err in
                                    if let err = err {
                                        print("Error adding document: \(err)")
                                    }
                                }
                              
                            }
                        }
                    }
                }
                
                //Start the task
                task.resume()
            }
            
        }
    
   
    
    func parseJSON(data : Data , _ articleNumber: Int) -> NewsPaperModel?
    {
        let decoder = JSONDecoder()
        
        
        do
        {
        
            let decodedData = try decoder.decode(WebData.self, from: data)
            
            if articleNumber < decodedData.totalResults
            {
            let articles = decodedData.articles
            
            let article = articles[articleNumber]
            let title = article.title
            let image = article.urlToImage
            let description = article.description
            let content = article.content
            let url = article.url
            let author = article.author
            
            
            return NewsPaperModel(author: author, title: title, description: description, url: url, urlToImage: image, content: content)
            }
            else {
                return nil
            }
            
        } catch
        {
            print(error)
            print("error")
            return nil
        }
    }
    
}

extension AppBrain
{
    
    
    func date()->String{
        let currentDateTime = Date()
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        // now the components are available
        // 2016
        // 10
        // 8
        return "\(String(describing: dateTimeComponents.year!))-\(String(describing: dateTimeComponents.month!))-\(String(describing: dateTimeComponents.day!-1) )"
    }
}

