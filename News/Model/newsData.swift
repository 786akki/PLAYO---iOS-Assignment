//
//  newsData.swift
//  News
//
//  Created by Akhil on 28/06/22.
//

import Foundation
struct newsData : Codable{
    var status : String?
    var articles : [newsStructFile]
}
