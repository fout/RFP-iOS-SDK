//
//  OutstreamVideoViewController.swift
//  RFPDemoSwift
//
//  Created by FreakOut on 2020/10/30.
//  Copyright © 2020 FreakOut inc.,. All rights reserved.
//

import Foundation

class OutstreamVideoViewController: ViewController
    , RFPExceptionDelegate
    , RFPOutstreamVideoAdLoaderDelegate {

    @IBOutlet weak var videoView: UIView!

    private var videoPlayerControl: RFPPlayerControl!

    let adspotID: String = "ODQwOjEyNzQ5"
    let mediaID: String = "4150"
    let loader = RFPOutstreamVideoAdLoader.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        RFP.rfpInitMedia(self.mediaID)
        if (self.videoPlayerControl == nil) {
            loader.delegate = self
            loader.exceptionDelegate = self
            loader.loadAd(withAdspotID: adspotID,
                frame: self.videoView.bounds)
        }
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: flag, completion: completion)
        self.videoPlayerControl.pause()
        self.videoPlayerControl.removeFromSuperview()
    }

    // MARK: - RFPExceptionDelegate

    func exceptionOccurred(_ error: Error!) {
        print("exceptionOccurred=[\(String(describing: error))]")
    }

    // MARK: RFPOutstreamVideoAdLoaderDelegate

    open func didStartLoadingAd(_ loader: RFPOutstreamVideoAdLoader!) {
        print("didStartLoadingAd")
    }

    open func didFinishLoadingAd(_ outstreamAdLoader: RFPOutstreamVideoAdLoader!) {
        print("didFinishLoadingAd")
    }

    open func didFailLoadingAd(_ outstreamAdLoader: RFPOutstreamVideoAdLoader!, withError error:Error!) {
        print("didFailLoadingAd:\(String(describing: error))")
    }

    open func readyToPlay(with playerControl: RFPPlayerControl!) {
        print("readyToPlay")
        self.videoPlayerControl = playerControl;
        self.videoView.addSubview(self.videoPlayerControl)
        self.videoView.sizeToFit()
        self.videoPlayerControl.play()
    }

    open func didPlayToEndTime(with playerControl: RFPPlayerControl!) {
        print("didPlayToEndTime")
    }
}
