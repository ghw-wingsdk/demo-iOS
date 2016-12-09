//
//  GHWTestModeLogView.h
//  WASDKUI
//
//  Created by wuyx on 15/8/26.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WACommon/WACommon.h>
@interface WASdkTestModeLogView : NSObject

+(id)shareInstance;
+(void)addLogWithString:(NSString*)string;
+(void)addLogWithoutBtn:(NSString*)string;
+(void)addEventContentWithString:(NSString*)string;
+(void)removeSuspBtn;
+(void)eventLog:(NSDictionary*)attributeDict str:(NSString *)format, ...;
+(void)eventLog:(UIColor*)color format:(NSString *)format, ...;
+(void)eventLog:(NSString *)format, ...;
@property(nonatomic,strong)NSString* log;
@end
