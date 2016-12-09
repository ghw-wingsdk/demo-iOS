//
//  WAFBGameRequestContent.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @typedef NS_ENUM(NSUInteger, WAFBGameRequestActionType)
 @abstract Additional context about the nature of the request.
 */
typedef NS_ENUM(NSUInteger, WAGameRequestActionType)
{
    /*! No action type */
    WAGameRequestActionTypeNone = 0,
    /*! Send action type: The user is sending an object to the friends. */
    WAGameRequestActionTypeSend,
    /*! Ask For action type: The user is asking for an object from friends. */
    WAGameRequestActionTypeAskFor,
    /*! Turn action type: It is the turn of the friends to play against the user in a match. (no object) */
    WAGameRequestActionTypeTurn,
    
    WAGameRequestActionInvite,
    
    WAGameRequestActionRequest
};

@interface WAGameRequestContent : NSObject
/*!
 @abstract Used when defining additional context about the nature of the request.
 @discussion The parameter 'objectID' is required if the action type is either
 'WAFBGameRequestActionTypeSend' or 'WAFBGameRequestActionTypeAskFor'.
 @seealso objectID
 */
@property (nonatomic, assign) WAGameRequestActionType actionType;

/*!
 @abstract Additional freeform data you may pass for tracking. This will be stored as part of
 the request objects created. The maximum length is 255 characters.
 */
@property (nonatomic, copy) NSString *data;

/*!
 @abstract This controls the set of friends someone sees if a multi-friend selector is shown.
 It is FBSDKGameRequestNoFilter by default, meaning that all friends can be shown.
 If specify as FBSDKGameRequestAppUsersFilter, only friends who use the app will be shown.
 On the other hands, use FBSDKGameRequestAppNonUsersFilter to filter only friends who do not use the app.
 @discussion The parameter name is preserved to be consistent with the counter part on desktop.
 */
//@property (nonatomic, assign) FBSDKGameRequestFilter filters;

/*!
 @abstract A plain-text message to be sent as part of the request. This text will surface in the App Center view
 of the request, but not on the notification jewel. Required parameter.
 */
@property (nonatomic, copy) NSString *message;

/*!
 @abstract The Open Graph object ID of the object being sent.
 @seealso actionType
 */
@property (nonatomic, copy) NSString *objectID;

/*!
 @abstract An array of user IDs, usernames or invite tokens (NSString) of people to send request.
 @discussion These may or may not be a friend of the sender. If this is specified by the app,
 the sender will not have a choice of recipients. If not, the sender will see a multi-friend selector
 
 This is equivalent to the "to" parameter when using the web game request dialog.
 */
@property (nonatomic, copy) NSArray *recipients;

/*!
 @abstract An array of user IDs that will be included in the dialog as the first suggested friends.
 Cannot be used together with filters.
 @discussion This is equivalent to the "suggestions" parameter when using the web game request dialog.
 */
@property (nonatomic, copy) NSArray *recipientSuggestions;

/*!
 @abstract The title for the dialog.
 */
@property (nonatomic, copy) NSString *title;


@end
