//
//  WASDKSandboxHelper.h
//  WASDKUI
//
//  Created by wuyx on 15/9/1.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASdkSandboxHelper : NSObject
+ (NSString *)homePath;     // 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)appPath;        // 程序目录，不能存任何东西
+ (NSString *)docPath;        // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)libPrefPath;    // 配置目录，配置文件存这里
+ (NSString *)libCachePath;    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;        // 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (BOOL)hasLive:(NSString *)path; //判断目录是否存在，不存在则创建
+ (BOOL)isFileExistWithPath:(NSString*)path;//判断文件是否存在
+ (BOOL)isFileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory;
+(BOOL)createFileWithPath:(NSString*)path;//创建文件夹
+ (BOOL)removeItemAtPath:(NSString*)path andError:(NSError **)error;
+(NSString*)getSDKMainDirPath;//SDK主目录
+(NSString*)getSDKPatchPath;//SDK patch文件夹
+(NSString*)getSDKTempPath;//SDK temp 文件夹
+(NSString*)getSDKPatchTempPath;//SDK patchTemp文件夹
+(NSString*)getSDKPatchOldPath;//SDK patchOld 文件夹
+(NSString*)getSDKAppWallImgCachePath;//SDK应用墙缓存图片路径
+(NSString*)getSDKCrashLogPath;//SDK闪退日志保存路径
+(NSString*)getSDKDatabasePath;//SDK数据库文件目录
@end
