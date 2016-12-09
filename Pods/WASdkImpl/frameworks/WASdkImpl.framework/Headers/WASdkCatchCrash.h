//
//  GHWCatchCrash.h
//  TEST
//
//  Created by wuyx on 15/8/17.
//  Copyright (c) 2015年 GHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WACommon/WACommon.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WASdkCatchCrash : NSObject
+(void)postCrashReport;
void ghwUncaughtExceptionHandler(NSException *exception);
@end
