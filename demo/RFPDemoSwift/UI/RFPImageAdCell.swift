//
//  RFPImageAdCell.swift
//  RFPDemoSwift
//
//  Created by FreakOut
//  Copyright (c) 2018 FreakOut inc.,. All rights reserved.
//

import UIKit

class RFPImageAdCell: RFPTableViewAdCell {

    @IBOutlet weak var advertiser: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var containerView: UIImageView!

    public static let fixedHeight: CGFloat = 320

    override func awakeFromNib() {
        super.awakeFromNib()

        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .lightGray
    }

    override func initProperties() {
        self.containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        self.actionButton.removeTarget(nil, action: nil, for: .allEvents)
        super.initProperties()
    }
}
