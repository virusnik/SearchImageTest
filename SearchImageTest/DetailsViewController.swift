//
//  DetailsViewController.swift
//  SearchImageTest
//
//  Created by Sergio Veliz on 10/24/17.
//  Copyright © 2017 Sergio Veliz. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var item: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        // Do any additional setup after loading the view.
    }

    func configureView() {
        if let item = item {
            imageView.sd_setImage(with: item.getLinkImage(), completed: nil)
            self.title = item.title
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
