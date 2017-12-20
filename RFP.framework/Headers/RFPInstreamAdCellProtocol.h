//
//  RFPInstreamAdCellProtocol.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2014/04/21.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RFPInstreamInfoModel;

/**
 `RFPInstreamAdCellInternalProtocol` is a protocol to be used by sdk internal
 Ignore it.
 */

@protocol RFPInstreamAdCellInternalProtocol <NSObject>
@end

/**
 `RFPInstreamAdCellProtocol` is a protocol to be conformed by sdk's defalut advertisement cell format objects.
 Use it, if you want to do so.
 */

@protocol RFPInstreamAdCellProtocol <RFPInstreamAdCellInternalProtocol>

/**
 required height for the advertisement cell format to be displayed
 */

+ (CGFloat)rfpHeightForCell;

/**
 update the advertisement cell object with using `RFPInstreamInfoModel` instance.
 
 @param infoModel   `RFPInstreamInfoModel` instance to be used
 @param completion  callback block to inform an error and the completion event. If the error is nil, invoke measureImp API.
 
 @see RFPInstreamAdLoader.h
 */

- (void)rfpUpdateCell:(RFPInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end
