//
//  WAVKCommunity.h
//  WAVkImplUI
//
//  Created by wuyx on 16/7/7.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAGroup : NSObject
@property(nonatomic,copy)NSString* gid;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* screen_name;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* photo;
@property(nonatomic,copy)NSString* photo_medium;
@property(nonatomic,copy)NSString* photo_big;
@property(nonatomic,copy)NSString* desc;
@property(nonatomic,copy)NSString* members_count;
@property(nonatomic,copy)NSString* status;
@property(nonatomic,copy)NSString* schemeUrl;
@property(nonatomic,copy)NSString* pageUrl;
@property(nonatomic)int is_closed;
@property(nonatomic)BOOL is_member;
+(NSArray*)parseWithDict:(NSDictionary*)dict;
+(NSArray*)parseWithArray:(NSArray*)arr;
@end
