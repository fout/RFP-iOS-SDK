//
//  ARFPInstreamInfoModel.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2014/04/17.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef RFP_INSTREAMINFO_PROTOCOL_H
#define RFP_INSTREAMINFO_PROTOCOL_H
@protocol RFPInstreamInfoProtocol <NSObject>
@property (nonatomic, readonly) NSNumber *position;
@end
#endif

/**
 `RFPInstreamInfoModel` is a container to be stored instream advertisement information.
 */

@interface RFPInstreamInfoModel : NSObject<RFPInstreamInfoProtocol>

/**
 advertisement title to be consisted of ~20 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *title;

/**
 advertisement text to be consisted of 40~70 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *content;

/**
 advertisement position to be put in the tableView.
 it is used by advertising performance analysis.
 */
@property (nonatomic, readonly) NSNumber *position;

/**
 advertiser name to be put in the tableView.
 it is used to show that this content is provided for PR.
 */
@property (nonatomic, readonly) NSString *displayedAdvertiser;

/**
 advertisement icon image url to be loaded in the tableView.
 you can use it directly instead of using loadIconImage
 */
@property (nonatomic, readonly) NSURL *iconImageURL;

/**
 advertisement main image url to be loaded in the tableView.
 you can use it directly instead of using loadImage
 */
@property (nonatomic, readonly) NSURL *imageURL;

/**
 starts loading advertisement icon image for assigning a UIImage to the iconImageView,
 if you want to do so.
 
 @param iconImageView  `UIImageView` instance to be assigned the icon image
 @param completion     callback block to inform an error. If the error is nil and loadImage:completion is also completed, invoke measureImp API.
 
 @see RFPInstreamAdLoader.h
 */

- (void)rfpLoadIconImage:(UIImageView*)iconImageView completion:(void (^)(NSError *error)) completion;

/**
 starts loading advertisement main image for assigning a UIImage to the imageView,
 if you want to do so.
 
 @param imageView   `UIImageView` instance to be assigned the main image
 @param completion  callback block to inform an error. If the error is nil and loadIconImage:completion is also completed, invoke measureImp API.
 
 @see RFPInstreamAdLoader.h
 */

- (void)rfpLoadImage:(UIImageView*)imageView completion:(void (^)(NSError *error)) completion;

/**
 *
 * @return BOOL
 */
- (BOOL)isVideo;

/**
 *
 * @return NSString*
 */
- (NSString *)getCtaText;


/**
 * Call this function after loads ads to get ad's cpc.
 * Cpc`s default value is 0.0
 * @return double estimated cpc
 */
- (double)getEstimatedCpc;

/**
 * Call this function after loads ads to get ad's id.
 * AdId's default value is nil
 * @return NSString* adId
 */
- (NSString *)getAdId;

@end
