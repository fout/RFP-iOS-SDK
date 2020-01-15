//
//  FeedTableViewController.swift
//  RFPDemoSwift
//
//  Created by FreakOut
//  Copyright (c) 2018 FreakOut inc.,. All rights reserved.
//

import UIKit
import ImageIO

class FeedTableViewController: UITableViewController
    , RFPInstreamAdLoaderDelegate
    , RFPExceptionDelegate
    , RFPTableViewAdCellDelegate {

    // App contents
    var contents: [AnyObject] = [
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
    ]

    // RFP data
    var infoModels: [Int: RFPInstreamInfoModel] = Dictionary.init()
    var playerControls: [IndexPath: RFPPlayerControl] = Dictionary.init()

    let adSpotId = "Set your ad spot id"
    let positions = [2, 8, 14, 20]

    let adLoader = RFPInstreamAdLoader.init()

    var topMargin: CGFloat = 0.0
    var bottomMargin: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        print("FeedTableViewController viewDidLoad")

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            UINib(nibName: "RFPContentCell", bundle: nil),
            forCellReuseIdentifier: "ContentCell"
        )

        tableView.register(
            UINib(nibName: "RFPVideoAdCell", bundle: nil),
            forCellReuseIdentifier: "VideoAdCell"
        )
        tableView.register(
            UINib(nibName: "RFPImageAdCell", bundle: nil),
            forCellReuseIdentifier: "ImageAdCell"
        )

        topMargin = UIApplication.shared.statusBarFrame.size.height
            + (navigationController?.navigationBar.frame.size.height)!
        bottomMargin = 0

        // Load RFP advertisements
        adLoader.delegate = self
        adLoader.exceptionDelegate = self
        adLoader.rfpLoadAd(
            withReturn: adSpotId,
            adCount: UInt(positions.count),
            positions: positions
        )
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        dismiss(animated: false, completion: nil)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: flag, completion: completion)

        self.playerControls.forEach { pc in
            pc.value.pause()
            pc.value.removeFromSuperview()
        }
        self.playerControls.removeAll()

        self.infoModels.removeAll()
    }

    // MARK: - RFPInstreamAdLoaderDelegate

    func rfpInstreamAdLoaderDidFinishLoadingAd(withReturn instreamAdLoader: RFPInstreamAdLoader!, instreamInfoModels: [Any]!) {
        if instreamInfoModels.count < 1 {
            NSLog("_items is invalid. Something wrong occur");
            return
        }

        for info in instreamInfoModels as! [RFPInstreamInfoModel] {
            contents.insert(info, at: info.position.intValue)
            infoModels[info.position.intValue] = info
        }
        tableView.reloadData()
    }

    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }

    func readyToPlay(with playerControl: RFPPlayerControl!) {
        playerControls.forEach { pc in
            if pc.value == playerControl {
                if let cell = self.tableView.cellForRow(at: pc.key) as? RFPVideoAdCell {
                    cell.setMargin(
                        top: topMargin,
                        bottom: bottomMargin
                    )
                    cell.startTimer()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // invalid section
        if indexPath.section != 0 {
            return UITableViewCell()
        }

        // cell
        let cell: UITableViewCell

        if !isAdCell(at: indexPath) {
            // contentCell
            return createContentCell(contents: contents[indexPath.row], indexPath: indexPath)
        }

        guard let item = contents[indexPath.row] as? RFPInstreamInfoModel else {
            return UITableViewCell.init()
        }

        if item.isVideo() {
            // videoCell
            cell = createVideoAdCell(instreamInfoModel: item, indexPath: indexPath)
        } else {
            // imageCell
            cell = createImageAdCell(instreamInfoModel: item, indexPath: indexPath)
        }

        if let rfpCell = cell as? RFPTableViewAdCell {
            rfpCell.visibilityTracker = RFPVisibilityTracker.init(startTrackingAdView: rfpCell.contentView, infoModel: item)
            rfpCell.visibilityTracker?.delegate = rfpCell
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ad
        if isAdCell(at: indexPath) {
            let item: RFPInstreamInfoModel = contents[indexPath.row] as! RFPInstreamInfoModel
            if item.isVideo() {
                // videoCell
                return RFPVideoAdCell.fixedHeight
            }
            // imageCell
            return RFPImageAdCell.fixedHeight
        }
        // contentCell
        return RFPContentCell.fixedHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at", indexPath)
    }

    // MARK: - Custom func

    func isAdCell(at indexPath: IndexPath) -> Bool {
        let item: AnyObject = contents[indexPath.row]
        if item is RFPInstreamInfoProtocol {
            return true
        }
        return false
    }

    func createContentCell(contents: AnyObject, indexPath: IndexPath) -> UITableViewCell {
        // cell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContentCell",
            for: indexPath) as? RFPContentCell else {
            return UITableViewCell.init()
        }

        // image
        let imageName = String(describing: contents)
        let imageView = UIImageView(frame: cell.bounds)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: imageName + ".jpg")
        cell.container.addSubview(imageView)

        // text
        cell.title.text = imageName

        return cell
    }

    func createVideoAdCell(instreamInfoModel: RFPInstreamInfoModel, indexPath: IndexPath) -> UITableViewCell {
        // cell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "VideoAdCell",
            for: indexPath) as? RFPVideoAdCell else {
            return UITableViewCell.init()
        }

        // layout
        cell.selectionStyle = .none
        cell.clearPlayerControl()
        cell.layoutIfNeeded()

        var pc: RFPPlayerControl
        if let p = self.playerControls[indexPath] {
            pc = p
        } else {
            if let p = adLoader.getVideoControl(
                withFrame: cell.containerView.bounds,
                infoModel: instreamInfoModel) {
                self.playerControls[indexPath] = p
                pc = p
            } else {
                return UITableViewCell.init()
            }
        }

        // settings
        cell.delegate = self
        cell.indexPath = indexPath
        cell.model = instreamInfoModel

        // text
        cell.advertiser.text = instreamInfoModel.displayedAdvertiser
        cell.title.text = instreamInfoModel.title
        cell.descript.text = instreamInfoModel.content

        // button
        if let ctaTitle = instreamInfoModel.getCtaText() {
            cell.actionButton.setTitle(ctaTitle, for: .normal)
        } else {
            cell.actionButton.setTitle("- 詳細はこちら -", for: .normal)
        }
        cell.actionButton.addTarget(
            self,
            action: #selector(actionButtonTapped),
            for: .touchUpInside
        )

        // Set tap action - https://fout.github.io/RFP-iOS-SDK/programming-guide/2_5/#infeed/video/tapped
        pc.setTapActionFullscreen()

        cell.containerView.addSubview(pc)
        cell.startTimer()

        return cell;
    }

    func createImageAdCell(instreamInfoModel: RFPInstreamInfoModel, indexPath: IndexPath) -> UITableViewCell {
        // cell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ImageAdCell",
            for: indexPath) as? RFPImageAdCell else {
            return UITableViewCell.init()
        }

        // layout
        cell.selectionStyle = .none
        cell.layoutIfNeeded()

        // settings
        cell.indexPath = indexPath
        cell.model = instreamInfoModel
        cell.delegate = self

        // text
        cell.advertiser.text = instreamInfoModel.displayedAdvertiser
        cell.title.text = instreamInfoModel.title
        cell.descript.text = instreamInfoModel.content

        // button
        cell.actionButton.addTarget(
            self,
            action: #selector(actionButtonTapped),
            for: .touchUpInside
        )

        // image
        URLSession.shared.dataTask(with: URLRequest(url: instreamInfoModel.imageURL!)) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                return
            }
            DispatchQueue.main.async(execute: {
                cell.containerView.subviews.forEach { subview in
                    subview.removeFromSuperview()
                }
                //check if image is gif
                if (response.mimeType == "image/gif") {
                    guard let imageView = self.createGifImageFromData(data: data as NSData, bounds: cell.containerView.bounds) else {return}
                    cell.indexPath = indexPath
                    cell.containerView.addSubview(imageView)
                    imageView.startAnimating()
                    cell.startTimer()
                } else {
                    let imageView = UIImageView(frame: cell.containerView.bounds)
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = UIImage(data: data)
                    cell.indexPath = indexPath
                    cell.containerView.addSubview(imageView)
                    cell.startTimer()
                }
            })
            }.resume()
        return cell;
    }

    func createGifImageFromData (data : NSData, bounds : CGRect) -> UIImageView?  {
        guard let gifImagesSource = CGImageSourceCreateWithData(data as CFData, nil) else {return nil}
        //gif image's count
        let gifImagesCount = CGImageSourceGetCount(gifImagesSource)
        var gifImagesArray = [UIImage]()
        var totalDuration : Float = 0
        let imageView = UIImageView(frame: bounds)

        for i in 0 ..< gifImagesCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(gifImagesSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            if i == 0 {
                imageView.image = image
            }
            gifImagesArray.append(image)

            // Frame default duration
            var frameDuration : Float = 0.1;
            guard let properties = CGImageSourceCopyPropertiesAtIndex(gifImagesSource, i, nil) else {
                totalDuration += frameDuration
                continue }
            guard let gifDict = (properties as NSDictionary)[kCGImagePropertyGIFDictionary] as? NSDictionary else {
                totalDuration += frameDuration
                continue }

            if let delayTimeUnclampedProp = gifDict[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber {
                frameDuration = delayTimeUnclampedProp.floatValue
            } else {
                if let delayTimeProp = gifDict[kCGImagePropertyGIFDelayTime as String] as? NSNumber {
                    frameDuration = delayTimeProp.floatValue
                }
            }
            // Make sure its not too small
            if frameDuration < 0.01 {
                frameDuration = 0.1;
            }
            totalDuration += frameDuration
        }
        imageView.animationImages = gifImagesArray
        imageView.animationDuration = TimeInterval(totalDuration)
        //loop gif
        imageView.animationRepeatCount = 0
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(data: data as Data)
        return imageView
    }

    @objc func actionButtonTapped(_ sender: UIButton, _ event: UIEvent) {
        var recursiveSearch: ((UIView) -> Void)?
        recursiveSearch = { [weak self] view in
            guard let `self` = self else {
                return
            }
            guard let superview = view.superview else {
                return
            }

            if let cell = superview as? RFPTableViewAdCell {
                self.adLoader.rfpSendClickEvent(cell.model)
            } else {
                recursiveSearch?(superview)
            }
        }
        recursiveSearch?(sender)
    }

    // MARK: - RFPTableViewCell delegate methods

    func getPlayer(_ indexPath: IndexPath) -> RFPPlayerControl? {
        if let player = self.playerControls[indexPath] {
            return player
        }
        return nil
    }
}
