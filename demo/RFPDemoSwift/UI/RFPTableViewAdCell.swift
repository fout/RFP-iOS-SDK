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

    func setTimerCompletion(_ completion: @escaping ((_ indexPath: IndexPath) -> Void))

    func tick()

    func getTableView() -> UITableView?

}

protocol RFPTableViewAdCellDelegate {
    func getPlayer(_ indexPath: IndexPath) -> RFPPlayerControl?
}

class RFPTableViewAdCell: UITableViewCell, RFPTableViewAdCellProtocol {

    var elapsed: Double = 2
    var completion: ((IndexPath) -> Void)?
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

    override func prepareForReuse() {
        super.prepareForReuse()

        self.startTime = 0
        self.model = nil
        self.indexPath = nil
        self.completion = nil
    }

    func initProperties() {
        self.stopTimer()

        self.completion = nil
        self.delegate = nil
        self.completion = nil
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
            forMode: RunLoopMode.commonModes
        )
    }

    func stopTimer() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }

    func setTimerCompletion(_ completion: @escaping ((IndexPath) -> Void)) {
        self.completion = completion
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
    }
}
