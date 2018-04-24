//
//  RFP.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2/10/14.
//  Copyright (c) 2017 FreakOut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RFPExceptionDelegate;

/**
 `RFP` is entry point class for starting using RFP.framework.
 
 If you want use some of RFP function, write `initMedia` first of all.
 
 */

@interface RFP : NSObject

///------------------------------------
/// @name Initialize RFP task
///------------------------------------

/**
 Sets the given mediaId from administrator.
 You should describe this method in [AppDelegate -application:didFinishLaunchingWithOptions:]
 Unless you have specific requirements.
 
 @param mediaId The number which was given by administrator.
*/

+ (void)rfpInitMedia:(NSString *)mediaId;

+ (void)rfpInitMedia:(NSString *)mediaId params:(NSDictionary*)params;

/**
 * Set video cache size (MB)
 * @param size Video cache size (MB)
 */
+ (void)rfpSetVideoCacheSize:(NSInteger)cacheSize;

/**
 * Get video cache size (MB)
 * If not setted from 「rfpSetVideoCacheSize],
 * will return a RFP recommend value.
 * @return video cache size (MB)
 */
+ (NSInteger)rfpGetVideoCacheSize;

/**
 * Set http request timeout interval in seconds
 * @param timeoutInterval default interval is 15s
 */
+ (void)rfpSetHttpRequestTimeoutInterval:(CGFloat)timeoutInterval;

/**
 * Get http request timeout interval (s)
 * If not setted from 「rfpSetHttpRequestTimeoutInterval],
 * will return a RFP default value.
 * @return timeoutInterval (s)
 */
+ (CGFloat)rfpGetHttpRequestTimeoutInterval;

@end
