//
//  WAFBAppInviteContent.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAAppInviteContent
 - - -
 */
@interface WAAppInviteContent : NSObject
/*!
 @abstract A URL to a preview image that will be displayed with the app invite
 
 @discussion This is optional.  If you don't include it a fallback image will be used.
 */
@property (nonatomic, strong) NSURL *appInvitePreviewImageURL;

/*!
 @abstract An app link target that will be used as a target when the user accept the invite.
 
 @discussion This is a requirement.
 */
@property (nonatomic, strong) NSURL *appLinkURL;
@end
