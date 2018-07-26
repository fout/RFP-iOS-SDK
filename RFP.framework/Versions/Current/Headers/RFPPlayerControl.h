//
//  RFPPlayerControl_Public.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2017/08/21.
//  Copyright © 2017年 FreakOut. All rights reserved.
//

@interface RFPPlayerControl : UIView

- (void)play;

- (void)pause;

- (void)setTapActionFullscreen;

- (void)setTapActionAdClick;

- (void)replaceTapAction:(void (^)(void))handler;

@end
