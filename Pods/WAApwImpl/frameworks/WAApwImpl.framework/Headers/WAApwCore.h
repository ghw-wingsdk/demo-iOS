//
//  WAApwCore.h
//  WAApwImplUI
//
//  Created by hank on 2017/3/21.
//  Copyright © 2017年 hank. All rights reserved.
//

#import <WASdkIntf/WASdkIntf.h>

@class WACoreProxy;
@class WAApwCore;
#define WAApwLog(fmt,...) {\
if([WACoreProxy isDebugMode]){\
NSLog((@"WAApw LOG [(version %@) %s ]:" fmt), [WAApwCore getVersion],__FUNCTION__, ##__VA_ARGS__);\
[WACoreProxy addLogWithString:[NSString stringWithFormat:(@"(version %@) %s ]:" fmt),[WAApwCore getVersion],__FUNCTION__, ##__VA_ARGS__]];\
}\
}

@interface WAApwCore : WACore

+(NSString*)getVersion;

@end
