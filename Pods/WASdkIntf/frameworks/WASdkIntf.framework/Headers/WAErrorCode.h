//
//  WAShareConstants.h
//  WAUI
//
//  Created by wuyx on 15/6/12.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum WAErrorCode
{
    /*!
     @abstract Reserved.
     */
    WAReservedErrorCode = 0,
    
    /*!
     @abstract The error code for errors from invalid encryption on incoming encryption URLs.
     */
    WAEncryptionErrorCode,
    
    /*!
     @abstract The error code for errors from invalid arguments to SDK methods.
     */
    WAInvalidArgumentErrorCode,
    
    /*!
     @abstract The error code for unknown errors.
     */
    WAUnknownErrorCode,
    
    /*!
     @abstract A request failed due to a network error. Use NSUnderlyingErrorKey to retrieve
     the error object from the NSURLConnection for more information.
     */
    WANetworkErrorCode,
    
    /*!
     @abstract The error code for errors encounted during an App Events flush.
     */
    WAAppEventsFlushErrorCode,
    
    /*!
     @abstract An endpoint that returns a binary response was used with FBSDKGraphRequestConnection.
     @discussion Endpoints that return image/jpg, etc. should be accessed using NSURLRequest
     */
    WAGraphRequestNonTextMimeTypeReturnedErrorCode,
    
    /*!
     @abstract The operation failed because the server returned an unexpected response.
     @discussion You can get this error if you are not using the most recent SDK, or you are accessing a version of the
     Graph API incompatible with the current SDK.
     */
    WAGraphRequestProtocolMismatchErrorCode,
    
    /*!
     @abstract The Graph API returned an error.
     @discussion See below for useful userInfo keys (beginning with FBSDKGraphRequestError*)
     */
    WAGraphRequestGraphAPIErrorCode,
    
    /*!
     @abstract The specified dialog configuration is not available.
     @discussion This error may signify that the configuration for the dialogs has not yet been downloaded from the server
     or that the dialog is unavailable.  Subsequent attempts to use the dialog may succeed as the configuration is loaded.
     */
    WADialogUnavailableErrorCode,
}WAErrorCode;



extern NSString *const WAErrorDomain;

extern NSString *const WAErrorArgumentCollectionKey;

/*!
 @abstract The userInfo key for the invalid argument name for errors with FBSDKInvalidArgumentErrorCode.
 */
extern NSString *const WAErrorArgumentNameKey;

/*!
 @abstract The userInfo key for the invalid argument value for errors with FBSDKInvalidArgumentErrorCode.
 */
extern NSString *const WAErrorArgumentValueKey;

/*!
 @abstract The userInfo key for the message for developers in NSErrors that originate from the SDK.
 @discussion The developer message will not be localized and is not intended to be presented within the app.
 */
extern NSString *const WAErrorDeveloperMessageKey;

/*!
 @abstract The userInfo key describing a localized description that can be presented to the user.
 */
extern NSString *const WAErrorLocalizedDescriptionKey;

/*!
 @abstract The userInfo key describing a localized title that can be presented to the user, used with `FBSDKLocalizedErrorDescriptionKey`.
 */
extern NSString *const WAErrorLocalizedTitleKey;

