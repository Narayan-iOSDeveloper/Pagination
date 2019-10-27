//
//  ViewController.swift
//  PaginationAPP
//
//  Created by Narayan Bandwalkar on 24/10/19.
//  Copyright © 2019 Narayan Bandwalkar. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var listingTableview: UITableView!
    var isNewDataLoading = false
    private var currentPage = 1
    var userArray : [MainDataArray]?{
        didSet{
        }
    }
    
  //  var userMainArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        userArray = []
        self.listingTableview.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        self.listingTableview.delegate = self
        self.listingTableview.tableFooterView = UIView()
        self.indicator.startAnimating()
        
        fetch_User_Listing(pageNo: 1)
    }

    
    func fetch_User_Listing(pageNo:Int){
        let services = Services()
        services.getUserList(page: pageNo) { (result) in
            
            if (self.userArray?.isEmpty ?? false){
                self.userArray = result?.dataArray
            }
            else{
                for i in result?.dataArray ?? []{
                    self.userArray?.append(i)
                }
            }
            self.listingTableview.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.userArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.listingTableview.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
        cell?.userImageView.imageFromServerURL(urlString: self.userArray?[indexPath.row].avatar ?? "")
        cell?.name.text = String(format:"%@ %@",self.userArray?[indexPath.row].first_name ?? "",self.userArray?[indexPath.row].last_name ?? "")
        cell?.email.text = self.userArray?[indexPath.row].email
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let details = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        details.nameSTR = String(format:"%@ %@",self.userArray?[indexPath.row].first_name ?? "",self.userArray?[indexPath.row].last_name ?? "")
        details.emailSTR = self.userArray?[indexPath.row].email ?? ""
        details.imageURL = self.userArray?[indexPath.row].avatar ?? ""
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        do {
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animate(withDuration:0.3, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            },completion: { finished in
            })
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        
        if scrollView == listingTableview{
        
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if !isNewDataLoading{
                isNewDataLoading = true
    		currentPage += 1
                self.indicator.startAnimating()
                self.fetch_User_Listing(pageNo: currentPage)
            }
        }
    }
}
    
    
    
    
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}


