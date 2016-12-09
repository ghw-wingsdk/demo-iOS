//
//  WAFBSharePhotoContent.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASharingContent.h"
/*!
 @discussion WAFBSharePhotoContent
 - - -
 */
@interface WASharePhotoContent : NSObject<WASharingContent>
/*!
 @abstract Photos to be shared.
 @return Array of the photos (WAFBSharePhoto)
 */
@property (nonatomic, copy) NSArray *photos;
@end
