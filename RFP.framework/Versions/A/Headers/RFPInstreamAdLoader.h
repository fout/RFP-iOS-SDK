//
//  RFPInstreamAdLoader.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2014/04/17.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFPInstreamAdLoaderDelegate.h"

@protocol RFPInstreamInfoProtocol;
@protocol RFPExceptionDelegate;

/**
 `RFPInstreamAdLoader` is for loading instream type advertisements.
 if you want to do so,
 
 2 ways to be prepared by our sdk to load advertisements.
 
 1) full control by sdk
  1. instantiate this class.
  2. call - RFPbindToTableView
  3. call - RFPloadAd or RFPloadAd:adCount:positions
  4. call when your tableview is reloaded - RFPreloadData
 
 2) some control by sdk
  1. instantiate this class.
  2. call - RFPloadAdWithReturn:adCount:positions
  3. call when an advertisement is displayed - RFPmeasureImp
  4. call when an advertisement is clicked   - RFPsendClickEvent
 
 That's it!
 */

@interface RFPInstreamAdLoader : NSObject
/**
 This delegate tells loading instream advertisement results.
 
 @see RFPInstreamAdLoaderDelegate.h
 */
@property(nonatomic, weak) id <RFPInstreamAdLoaderDelegate> delegate;

/**
 This exceptionDelegate tells an exception.

 @see RFPExceptionDelegate.h
 */
@property(nonatomic, weak) id <RFPExceptionDelegate> exceptionDelegate;

/**
 binds this loader to your table view.
 
 @param tableView tableView to be binded by this loader
 @param adSpotId  adSpotId to be registered in advance
 
 */

- (void)rfpBindToTableView:(UITableView *)tableView adSpotId:(NSString *)adSpotId;

/**
 starts loading advertisements for inserting cells to binded tableview and then reload your tableview
 Use it if you want to use parameters registered at the management webpage in advance.
 */

- (void)rfpLoadAd;

/**
 starts loading advertisements for inserting limited cells to binded tableview and then reload your tableview,
 if you want to do so.
 
 @param adCount   advertisement cell count to be put in tableView. If 0 is given, registered is selected.
 @param positions each advertisement cell are put at the position in tableView. If nil is given, registered is selected.
 */

- (void)rfpLoadAd:(NSUInteger)adCount positions:(NSArray *)positions;

/**
 starts loading advertisements for receiving advertisement informations,
 if you want to do so.
 
 @param adSpotId  adSpotId to be registered in advance
 @param adCount   advertisement information count to be received in the callback. If 0 is given, registered is selected.
 @param positions each position to be added into `RFPInstreamInfoModel` in order to control ad position. If nil is given, registered is selected.
 
 ex. [self.instreamAdLoader loadAdWithReturn:6 adCount:5 positions:@[@3,@6,@9,@12,@15]];
 */

- (void)rfpLoadAdWithReturn:(NSString *)adSpotId adCount:(NSUInteger)adCount positions:(NSArray *)positions;

/**
 starts loading advertisements for receiving advertisement informations,
 if you want to do so.
 @param adSpotId  adSpotId to be registered in advance
 @param adCount   advertisement information count to be received in the callback. If 0 is given, registered is selected.
 @param positions each position to be added into `RFPInstreamInfoModel` in order to control ad position. If nil is given, registered is selected.
 @param custom custom parameters

 ex. [self.instreamAdLoader loadAdWithReturn:6 adCount:5 positions:@[@3,@6,@9,@12,@15] data:@{@"key": @"val1", @"key": @"val2"}];
 */
- (void)rfpLoadAdWithReturn:(NSString *)adSpotId adCount:(NSUInteger)adCount positions:(NSArray *)positions customs:(NSDictionary *)customParams;

/**
 send an impression record to log advertising performance.

 @param instreamInfoModel advertisement information model to be received in RFPloadAd:adCount:positions
 */

- (void)rfpMeasureImp:(id <RFPInstreamInfoProtocol>)instreamInfoProtocol;

/**
 send an click record to log advertising performance.
 
 @param instreamInfoModel advertisement information model to be received in loadAd:adCount:positions
 */

- (void)rfpSendClickEvent:(id <RFPInstreamInfoProtocol>)instreamInfoProtocol;

/**
 reload data in your binded tableview.
 if you used `bindToTableView:adSpotId:`, invoke this method instead of [your_table_view reloadData].
 
 loadAd and loadAd:adCount:positions methods invoke this method internally, so you don't have to invoke 
 this method explicitly in normal use case.
 
 */
- (void)rfpReloadData;

/**
 sets an adSpotId.
 if you change an adSpotId dynamically, you can use it.
 
 @param adSpotId  adSpotId to be registered in advance
 
 */
- (void)rfpSetAdSpotId:(NSString *)adSpotId;

/**
 * get RFPPlayerControl
 * @param frame
 * @param instreamInfoProtocol
 * @return RFPPlayerControl *
 */
- (RFPPlayerControl *)getVideoControlWithFrame:(CGRect)frame
                                     infoModel:(id <RFPInstreamInfoProtocol>)instreamInfoProtocol;

@end
