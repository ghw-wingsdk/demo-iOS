//
//  LocalizedStringUtil.h
//  WACommonUI
//
//  Created by hank on 16/5/12.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//  多语言工具类

#import <Foundation/Foundation.h>

@interface LocalizedStringUtil : NSObject

/** 通过key获取多语言文本 */
+ (NSString *)getLocalizedStringByKey:(NSString *)key value:(NSString *)value;

@end

#define WALocalizedString(key, comment) \
[LocalizedStringUtil getLocalizedStringByKey:(key) value:(comment)]
