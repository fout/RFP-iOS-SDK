//
//  RFPContentCell.swift
//  RFPDemoSwift
//
//  Created by FreakOut
//  Copyright (c) 2018 FreakOut inc.,. All rights reserved.
//

import UIKit

class RFPContentCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var container: UIView!

    open static let fixedHeight: CGFloat = 200

    override func prepareForReuse() {
        super.prepareForReuse()

        title.text = ""
        container.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}
