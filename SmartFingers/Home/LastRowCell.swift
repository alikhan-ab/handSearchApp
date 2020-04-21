//
//  LastRowCell.swift
//  SmartFingers
//
//  Created by Alikhan Abutalipov on 4/21/20.
//  Copyright © 2020 Aigerim Janaliyeva. All rights reserved.
//

import UIKit
protocol LastRowButtonsDelegate {
    func lastRowButtonTapped(_ button: Int)
}

class LastRowCell: UITableViewCell {

    var delegate: LastRowButtonsDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func createCell() -> LastRowCell? {
        let nib = UINib(nibName: "LastRowCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as? LastRowCell
        return cell
    }
    
    @IBAction func starTapped(_ sender: UIButton) {
        self.delegate?.lastRowButtonTapped(1)
    }
    
    @IBAction func languageTapped(_ sender: UIButton) {
        self.delegate?.lastRowButtonTapped(2)
    }
}
