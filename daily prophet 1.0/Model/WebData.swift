//
//  WebData.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 08/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import Foundation

struct WebData : Decodable
{
   var status : String
    var totalResults : Int
    var articles : [Articles]
}

struct Articles: Decodable
{
    var content : String?
    var author : String?
    var title : String
    var description : String?
    var url : String
    var urlToImage : String?
    var publishedAt : String
    var source : Source
}

struct Source: Decodable
{
    var id : String?
    var name : String
}
