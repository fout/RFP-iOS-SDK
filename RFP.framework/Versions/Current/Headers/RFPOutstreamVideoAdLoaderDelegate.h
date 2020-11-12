//
//  RFPOutstreamVideoAdLoaderDelegate.h
//  RFP-iOS-SDK
//
//  Created by FreakOut on 2020/09/08.
//  Copyright © 2020 FreakOut. All rights reserved.
//

@class RFPOutstreamVideoAdLoader;
@class RFPPlayerView;
@class RFPOutstreamInfoModel;
@class RFPPlayerControl;

@protocol RFPOutstreamVideoAdLoaderDelegate <NSObject>

@optional

- (void)didStartLoadingAd:(RFPOutstreamVideoAdLoader *)outstreamAdLoader;

- (void)didFinishLoadingAd:(RFPOutstreamVideoAdLoader *)outstreamAdLoader;

- (void)didFailLoadingAd:(RFPOutstreamVideoAdLoader *)outstreamAdLoader
              withError:(NSError *)error;

- (void)readyToPlayWithPlayerControl:(RFPPlayerControl *)playerControl;

- (void)didPlayToEndTimeWithPlayerControl:(RFPPlayerControl *)playerControl;

@end

