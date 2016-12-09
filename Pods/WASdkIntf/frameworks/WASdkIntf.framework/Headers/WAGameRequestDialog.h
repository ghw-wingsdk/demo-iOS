//
//  WAFBGameRequestDialog.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WAGameRequestDialog,WAGameRequestContent;
/*!
 @abstract A delegate for WAFBGameRequestDialog.
 @discussion The delegate is notified with the results of the game request as long as the application has permissions to
 receive the information.  For example, if the person is not signed into the containing app, the shower may not be able
 to distinguish between completion of a game request and cancellation.
 */
@protocol WAGameRequestDialogDelegate <NSObject>

/*!
 @abstract Sent to the delegate when the game request completes without error.
 @param gameRequestDialog The WAFBGameRequestDialog that completed.
 @param platform The platform from the dialog .
 @param results The results from the dialog.  This may be nil or empty.
 */
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results;

/*!
 @abstract Sent to the delegate when the game request encounters an error.
 @param gameRequestDialog The WAFBGameRequestDialog that completed.
 @param platform The platform from the dialog .
 @param error The error.
 */
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error;

/*!
 @abstract Sent to the delegate when the game request dialog is cancelled.
 @param gameRequestDialog The WAFBGameRequestDialog that completed.
 @param platform The platform from the dialog .
 */
- (void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform;

@end

@interface WAGameRequestDialog : NSObject
/*!
 @abstract The receiver's delegate or nil if it doesn't have a delegate.
 */
@property (nonatomic, weak) id<WAGameRequestDialogDelegate> delegate;

/*!
 @abstract The content for game request.
 */
@property (nonatomic, strong) WAGameRequestContent *content;
@end
