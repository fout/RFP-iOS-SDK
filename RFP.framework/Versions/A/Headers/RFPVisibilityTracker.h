//
//  RFPVisibilityTracker.h
//  RFP-iOS-SDK
//
//  Created by guchan on 2019/10/15.
//  Copyright © 2019 FreakOut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RFPInstreamInfoModel.h"

@protocol RFPVisibilityTrackerDelegate <NSObject>

@optional
/**
 Called when  advertisment's impression is sent.
*/

- (void)rfpVisibilityTrackerDidSentImp;

/**
 Called when  failed to send advertisment's impression.
 @param error NSError instance.
*/

- (void)rfpVisibilityTrackerFailedToSendImpWithError:(NSError *)error;

@end

/**
 `RFPVisibilityTracker` is for tracking ad's impression. When the ad is satisfied the viewable impression, impression event will be sent.
*/

@interface RFPVisibilityTracker : NSObject

@property (nonatomic, weak) id<RFPVisibilityTrackerDelegate> delegate;

/**
 Initializes and returns an `RFPVisibilityTracker` instance which starts tracking ad's view.
 Do not forget to dealloc it's instance  when stop to use it.s

@param adView ad's UIView
@param infoModel  ad's RFPInstreamInfoModel

*/
- (instancetype)initWithStartTrackingAdView:(UIView *)adView infoModel:(RFPInstreamInfoModel *)infoModel NS_DESIGNATED_INITIALIZER;

- (instancetype)init __attribute__((unavailable("init not available")));

@end
