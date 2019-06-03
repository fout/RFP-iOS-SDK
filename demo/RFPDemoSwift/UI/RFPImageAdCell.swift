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

    override func tick() {
        if let tableView = self.getTableView() {

            if self.indexPath != nil && tableView.superview != nil {

                // current cell rect
                let cellRect = tableView.convert(
                    tableView.rectForRow(at: self.indexPath!),
                    to: tableView.superview!
                )

                // check viewability
                if self.viewableRect.intersects(cellRect) {
                    // viewable
                    if self.startTime == 0 {
                        // start timer
                        self.startTime = Date().timeIntervalSince1970
                    } else {
                        if self.elapsed <= (Date().timeIntervalSince1970 - self.startTime) {
                            // time has come
                            if self.completion != nil {
                                self.completion!(self.indexPath!)
                                self.startTime = Double.infinity
                            }
                        }
                    }
                } else {
                    // unviewable
                    if self.startTime != Double.infinity {
                        self.startTime = 0
                    }
                }
            }
        }
    }
}
