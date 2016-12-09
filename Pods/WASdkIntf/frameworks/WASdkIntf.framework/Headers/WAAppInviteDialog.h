//
//  WAFBAppInviteDialog.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAAppInviteContent.h"
@class WAAppInviteDialog;
/*!
 @discussion 应用邀请协议
 - - -
 */
@protocol WAAppInviteDialogDelegate <NSObject>

/*!
 @abstract Sent to the delegate when the app invite completes without error.
 @param appInviteDialog The WAFBAppInviteDialog that completed.
 @param platform The platform from  the app invite .
 @param results The results from the dialog.  This may be nil or empty.
 */
- (void)appInviteDialog:(WAAppInviteDialog *)appInviteDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results;

/*!
 @abstract Sent to the delegate when the app invite encounters an error.
 @param appInviteDialog The WAFBAppInviteDialog that completed.
 @param platform The platform from  the app invite .
 @param error The error.
 */
- (void)appInviteDialog:(WAAppInviteDialog *)appInviteDialog platform:(NSString *const)platform didFailWithError:(NSError *)error;

@end

/*!
 @discussion WAAppInviteDialog
 - - -
 */
@interface WAAppInviteDialog : NSObject
/*!
 @abstract The receiver's delegate or nil if it doesn't have a delegate.
 */
@property (nonatomic, weak) NSObject<WAAppInviteDialogDelegate>* delegate;

/*!
 @abstract The content for app invite.
 */
@property (nonatomic, strong) WAAppInviteContent *content;
@end
