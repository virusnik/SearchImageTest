//
//  ResultTableViewCell.swift
//  SearchImageTest
//
//  Created by Sergio Veliz on 10/30/17.
//  Copyright © 2017 Sergio Veliz. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet  weak var searchImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    fileprivate let defaultImage = UIImage(named: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        searchImageView.image = defaultImage
        
    }
    
    func setData(item: Items) {
        searchImageView.sd_setImage(with: item.getThumbnailUrl(), completed: nil)
        titleLabel.text = item.title
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
