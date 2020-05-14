//
//  NewsPaperModel.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 09/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import Foundation

struct NewsPaperModel : Decodable
{
   var author : String?
   var title : String
   var description : String?
   var url : String
   var urlToImage : String?
   var content : String?
    
}


