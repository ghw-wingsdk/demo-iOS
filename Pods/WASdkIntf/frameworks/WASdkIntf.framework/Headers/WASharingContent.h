//
//  WAFBShareContent.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/15.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol WASharingContent

/*!
 @abstract URL for the content being shared.
 @discussion This URL will be checked for all link meta tags for linking in platform specific ways.  See documentation
 for App Links (https://developers.facebook.com/docs/applinks/)
 @return URL representation of the content link
 */
@property (nonatomic, strong) NSURL *contentURL;

/*!
 @abstract List of IDs for taggable people to tag with this content.
 @description See documentation for Taggable Friends
 (https://developers.facebook.com/docs/graph-api/reference/user/taggable_friends)
 @return Array of IDs for people to tag (NSString)
 */
@property (nonatomic, strong) NSArray *peopleIDs;

/*!
 @abstract The ID for a place to tag with this content.
 @return The ID for the place to tag
 */
@property (nonatomic, strong) NSString *placeID;

/*!
 @abstract A value to be added to the referrer URL when a person follows a link from this shared content on feed.
 @return The ref for the content.
 */
@property (nonatomic, strong) NSString *ref;

@end

