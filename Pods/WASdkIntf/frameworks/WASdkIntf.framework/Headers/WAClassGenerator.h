//
//  WAClassGenerator.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/3.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAClassGenerator : NSObject
+(NSArray*)getCompsWithModule:(NSString *const)module;
//根据module生成实例数组
+(NSMutableArray*)generatorWithModule:(NSString *const)module;
//根据module和父类class生成实例数组
+(NSMutableArray*)generatorWithModule:(NSString *const)module superClass:(Class)superClass;
//根据module和platform生成实例并回调
+(void)generatorWithModule:(NSString *const)module platform:(NSString *const)platform block:(void (^)(NSObject* obj,NSError* error))block;
//根据module和platform生成实例
+(NSObject*)generatorWithModule:(NSString *const)module platform:(NSString *const)platform;
//根据module,platform和父类class生成实例
+(NSObject*)generatorWithModule:(NSString *const)module platform:(NSString *const)platform superClass:(Class)superClass;
//判断模块是否存在
+(BOOL)isExistWithModule:(NSString*)module;
//判断某个模块的某个渠道是否存在
+(BOOL)isExistWithPlatform:(NSString*)platform module:(NSString*)module;
@end
