//
//  WAFBShareVideoContent.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASharingContent.h"
#import "WASharePhoto.h"
#import "WAShareVideo.h"
/*!
 @discussion WAFBShareVideoContent
 - - -
 */
@interface WAShareVideoContent : NSObject<WASharingContent>
/*!
 @abstract The photo that represents the video.
 @return The photo
 */
@property (nonatomic, strong) WASharePhoto *previewPhoto;

/*!
 @abstract The video to be shared.
 @return The video
 */
@property (nonatomic, strong) WAShareVideo *video;
@end
