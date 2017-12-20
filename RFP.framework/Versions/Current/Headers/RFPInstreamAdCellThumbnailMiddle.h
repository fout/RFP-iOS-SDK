//
//  RFPInstreamSample1Cell.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2014/04/17.
//  Copyright (c) 2017年 FreakOut Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFPInstreamAdCellProtocol.h"

@class RFPInstreamInfoModel;

/**
 @see `RFPInstreamAdCellProtocol`
 */

@interface RFPInstreamAdCellThumbnailMiddle : UITableViewCell<RFPInstreamAdCellProtocol>
+ (CGFloat)rfpHeightForCell;
- (void)rfpUpdateCell:(RFPInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end
