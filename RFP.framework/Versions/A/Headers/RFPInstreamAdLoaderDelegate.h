//
//  RFPInstreamAdLoaderDelegate.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2014/04/18.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `RFPInstreamAdLoaderDelegate` is delegate protocol for getting loading instream advertisements result.
 */

@class RFPInstreamAdLoader;
@class RFPPlayerView;
@class RFPPlayerControl;

@protocol RFPInstreamAdLoaderDelegate <NSObject>

@optional

/**
 Tells event just starting instream advertisement.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 */

- (void)rfpInstreamAdLoaderDidStartLoadingAd:(RFPInstreamAdLoader *)instreamAdLoader;

/**
 Tells event just finishing instream advertisement.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 */

- (void)rfpInstreamAdLoaderDidFinishLoadingAd:(RFPInstreamAdLoader *)instreamAdLoader;

/**
 Tells event just finishing, and returns `RFPInstreamInfoModel` instances.
 
 @param instreamAdLoader   Object which is loading instream advertisement.
 @param instreamInfoModels Array  which contains `RFPInstreamInfoModel` instances.
 */

- (void)rfpInstreamAdLoaderDidFinishLoadingAdWithReturn:(RFPInstreamAdLoader *)instreamAdLoader
                                     instreamInfoModels:(NSArray *)instreamInfoModels;

/**
 Tells event finished displaying each advertisement cell instances.
 
 @param adIndexPath Object which is the position of the advertisement cell instance that is being viewed.
 */

- (void)rfpInstreamAdLoaderDidFinishLoadingAdImage:(NSIndexPath *)adIndexPath;

/**
 Tells event to send an impression just finishing.
  */

- (void)rfpInstreamAdLoaderDidFinishSendingAdImp;

/**
 Tells event which clicked advertisement cell instances.
  */

- (void)rfpInstreamAdLoaderDidFinishSendingAdClick;

/**
 Tells event just failed to load instream advertisement.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 @param error NSError instance.
 */

- (void)rfpInstreamAdLoader:(RFPInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error;

/**
 Tells event just failed to display instream advertisement.
 
 @param adIndexPath Object which is the position of the advertisement cell instance that is being viewed.
 */

- (void)rfpInstreamAdLoader:(NSIndexPath *)adIndexPath didFailToLoadAdImageWithError:(NSError *)error;

/**
 Tells event just failed to send an impression.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 @param error NSError instance.
 */

- (void)rfpInstreamAdLoader:(RFPInstreamAdLoader *)instreamAdLoader didFailToSendImpWithError:(NSError *)error;

/**
 Tells event just failed to send an clickinfo.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 @param error NSError instance.
 */

- (void)rfpInstreamAdLoader:(RFPInstreamAdLoader *)instreamAdLoader didFailToSendClickWithError:(NSError *)error;

/**
 * Tells viewController for ModalViewController
 *
 * @return UIViewController *
 */
- (UIViewController *)viewControllerForPresentingModalView;

/**
 * Tells AVPlayer Ready to Play.
 */
- (void)readyToPlayWithPlayerControl:(RFPPlayerControl *)playerControl;

/**
 * Tells AVPlayer Finished playing.
 */
- (void)didPlayToEndTimeWithPlayerControl:(RFPPlayerControl *)playerControl;


@end
