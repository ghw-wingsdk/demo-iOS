//
//  WAFBShareVideo.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAFBShareVideo
 - - -
 */
@interface WAShareVideo : NSObject
/*!
 @abstract The file URL to the video.
 @return URL that points to the location of the video on disk
 */
@property (nonatomic, copy) NSURL *videoURL;
@end
