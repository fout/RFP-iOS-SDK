//
//  RFPTableViewAdCell.swift
//  RFPDemoSwift
//
//  Created by FreakOut
//  Copyright (c) 2018 FreakOut inc.,. All rights reserved.
//

protocol RFPTableViewAdCellProtocol {

    func startTimer()

    func startTimer(interval: TimeInterval)

    func tick()

    func getTableView() -> UITableView?

}

protocol RFPTableViewAdCellDelegate {
    func getPlayer(_ indexPath: IndexPath) -> RFPPlayerControl?
}

class RFPTableViewAdCell: UITableViewCell, RFPTableViewAdCellProtocol {

    var delegate: RFPTableViewAdCellDelegate?

    weak var model: RFPInstreamInfoModel?
    var indexPath: IndexPath?

    var timer: Timer?
    var interval: TimeInterval = 0.1

    var startTime: Double = 0

    var topMargin: CGFloat = 0
    var bottomMargin: CGFloat = 0
    var viewableRect: CGRect = CGRect.init()
    var viewableRate: CGFloat = 0.5

    var visibilityTracker: RFPVisibilityTracker?

    override func prepareForReuse() {
        super.prepareForReuse()

        self.startTime = 0
        self.model = nil
        self.indexPath = nil
    }

    func initProperties() {
        self.stopTimer()

        self.delegate = nil
        self.model = nil
        self.indexPath = nil
        self.startTime = 0
        self.viewableRect = CGRect.init()
    }

    func startTimer() {
        self.startTimer(interval: self.interval)
    }

    func startTimer(interval: TimeInterval) {
        self.interval = interval
        self.prepare()

        self.stopTimer()

        self.timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(
            self.timer!,
            forMode: RunLoop.Mode.common
        )
    }

    func stopTimer() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }

    func prepare() {
        if let tableView = self.getTableView() {
            let viewableRateMargin = self.bounds.size.height * self.viewableRate
            let topMargin = self.topMargin + viewableRateMargin

            // set viewable rect
            self.viewableRect = CGRect.init(
                origin: CGPoint.init(
                    x: tableView.bounds.origin.x,
                    y: topMargin),
                size: CGSize.init(
                    width: tableView.bounds.size.width,
                    height: tableView.bounds.size.height - (topMargin) - viewableRateMargin - self.bottomMargin)
            )
        }
    }

    func setMargin(top: CGFloat, bottom: CGFloat) {
        self.topMargin = top
        self.bottomMargin = bottom
    }

    @objc func tick() {
        // override

        // See "MRC Viewable Impression Guidelines"
        //   - https://www.iab.com/guidelines/iab-measurement-guidelines/#mrcviewable

        // (Japanese language) JIAA ビューアブルインプレッション測定ガイダンス
        //   - http://www.jiaa.org/html/topics/viewable_guidance.html
    }

    func getTableView() -> UITableView? {
        var tableView = self.superview as? UITableView
        if (tableView == nil) {
            tableView = self.superview?.superview as? UITableView
        }
        return tableView
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.initProperties()
    }

    deinit {
        print("[deinit]", self)
        self.visibilityTracker = nil
    }
}

// MARK: RFPInstreamAdLoaderDelegate
extension RFPTableViewAdCell: RFPVisibilityTrackerDelegate {
    public func rfpVisibilityTrackerDidSentImp() {
        print("rfpVisibilityTrackerDidSentImp", self.indexPath ?? "no ad info")
    }

    public func rfpVisibilityTrackerFailedToSendImpWithError(_ error: Error!) {
        print("rfpVisibilityTrackerDidFailToSendImpWithError", error ?? "error is null")
    }
}
