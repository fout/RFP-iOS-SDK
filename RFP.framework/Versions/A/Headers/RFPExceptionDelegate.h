//
//  RFPExceptionDelegate.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2017/09/21.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `RFPExceptionDelegate` is delegate protocol for getting info about an exception.
 */

@protocol RFPExceptionDelegate <NSObject>

@optional

/**
 Tells event just occuring an exception.

 @param error NSError instance
 */

- (void)exceptionOccurred:(NSError *)error;

@end