//
//  NewsContent.swift
//  News
//
//  Created by Akhil on 28/06/22.
//

import UIKit

class NewsContent: UIViewController {

    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tileLabel: UILabel!
    var newsContent:newsStructFile = newsStructFile(author: "", title: "", urlToImage: "", description: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tileLabel.text = newsContent.title
        if newsContent.urlToImage != nil{
            let url = URL(string: newsContent.urlToImage!)
            imageView.downloadImageView(from: url!)
            imageView.contentMode = .scaleToFill
        }
        else {
            //
        }
        newsDescriptionLabel.text = newsContent.description
        // Do any additional setup after loading the view.
    }
   
    



}
