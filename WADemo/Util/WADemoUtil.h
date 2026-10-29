//
//  GHWUtil.h
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WADemoUtil : NSObject
+(UIViewController *)getCurrentVC;
// Scene 生命周期下 UIApplication 的 keyWindow/statusBarFrame/statusBarOrientation 均已废弃，
// 统一改用下面三个基于前台 UIWindowScene 的方法。
+(UIWindow *)currentWindow;
+(CGRect)statusBarFrame;
+(UIInterfaceOrientation)interfaceOrientation;
+(void)addOrientationNotification:(id)observer selector:(SEL)selector object:(id)object;
+(void)removeOrientationNotification:(id)observer object:(id)object;
+(id)toArrayOrNSDictionary:(NSString *)jsonString;
+(NSString*)toJSONStringFromDictionary:(NSDictionary*)dict;
@end
