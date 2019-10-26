//
//  DetailViewController.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var nameSTR : String?
    var imageURL : String?
    var emailSTR : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        name.text = "Name: \(nameSTR ?? "")"
        email.text = "Email: \(emailSTR ?? "")"
        userImageView.imageFromServerURL(urlString: imageURL ?? "")
        
    }

}
