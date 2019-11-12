//
//  RFPVideoAdCell.swift
//  RFPDemoSwift
//
//  Created by FreakOut
//  Copyright (c) 2018 FreakOut inc.,. All rights reserved.
//

import UIKit

class RFPVideoAdCell: RFPTableViewAdCell {

    @IBOutlet weak var advertiser: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    @IBOutlet weak var containerView: UIView!

    public static let fixedHeight: CGFloat = 320

    enum PlayerStatus: Int {
        case ready
        case played
    }

    private var playerStatus: PlayerStatus = .ready

    override func awakeFromNib() {
        super.awakeFromNib()

        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .lightGray
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.clearPlayerControl()
    }

    override func initProperties() {
        self.clearPlayerControl()
        self.playerStatus = .ready
        actionButton.removeTarget(nil, action: nil, for: .allEvents)
        super.initProperties()
    }

    func clearPlayerControl() {
        self.containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    override func tick() {
        if let tableView = self.getTableView() {

            if self.delegate != nil && self.indexPath != nil {

                // current cell rect
                let cellRect = tableView.convert(
                    tableView.rectForRow(at: self.indexPath!),
                    to: tableView.superview!
                )

                if self.viewableRect.intersects(cellRect) {
                    if self.playerStatus == .ready {
                        self.playerStatus = .played
                        if let player = self.delegate!.getPlayer(self.indexPath!) {
                            player.play()
                        }
                    }
                } else {
                    if self.playerStatus == .played {
                        self.playerStatus = .ready
                        if let player = self.delegate!.getPlayer(self.indexPath!) {
                            player.pause()
                        }
                    }
                }
            }
        }
    }
}
