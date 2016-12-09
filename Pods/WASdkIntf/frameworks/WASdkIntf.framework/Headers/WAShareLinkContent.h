//
//  GHWSDKFBShareLinkContent.h
//  GHWSdkUI
//
//  Created by wuyx on 15/6/15.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASharingContent.h"
/*!
 @discussion WAFBShareLinkContent
 - - -
 */
@interface WAShareLinkContent : NSObject<WASharingContent>
/*!
 @abstract The description of the link.
 @discussion If not specified, this field is automatically populated by information scraped from the contentURL,
 typically the title of the page.  This value may be discarded for specially handled links (ex: iTunes URLs).
 @return The description of the link
 */
@property (nonatomic, copy) NSString *contentDescription;

/*!
 @abstract The title to display for this link.
 @discussion This value may be discarded for specially handled links (ex: iTunes URLs).
 @return The link title
 */
@property (nonatomic, copy) NSString *contentTitle;

/*!
 @abstract The URL of a picture to attach to this content.
 @return The network URL of an image
 */
@property (nonatomic, copy) NSURL *imageURL;
@end
