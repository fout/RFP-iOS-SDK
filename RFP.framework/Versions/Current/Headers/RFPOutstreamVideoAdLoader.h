//
//  RFPOutstreamVideoAdLoader.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2020/09/08.
//  Copyright © 2020 FreakOut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFPOutstreamVideoAdLoaderDelegate.h"

@protocol RFPExceptionDelegate;

@interface RFPOutstreamVideoAdLoader : NSObject

@property(nonatomic, weak) id <RFPOutstreamVideoAdLoaderDelegate> delegate;
@property(nonatomic, weak) id <RFPExceptionDelegate> exceptionDelegate;

- (void)loadAdWithAdspotID:(NSString *)adSpotId frame:(CGRect)frame;

@end
