//
//  RFPInstreamAdCellTextOnly.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2014/05/27.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFPInstreamAdCellProtocol.h"

@class RFPInstreamInfoModel;

/**
 @see `RFPInstreamAdCellProtocol`
 */

@interface RFPInstreamAdCellTextOnly : UITableViewCell<RFPInstreamAdCellProtocol>
+ (CGFloat)rfpHeightForCell;
- (void)rfpUpdateCell:(RFPInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end
