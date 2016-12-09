//
//  GHWSDKPatchInfo.h
//  GHWSdkUI
//
//  Created by wuyx on 15/10/21.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAUpdateInfo 更新包信息。
 - - -
 */
@interface WAUpdateInfo : NSObject<NSCoding,NSCopying>
@property(nonatomic)int code;
@property(nonatomic,copy)NSString* msg;
@property(nonatomic)Boolean upgrated;
@property(nonatomic)int patchId;
@property(nonatomic)int patchVersion;
@property(nonatomic,copy)NSString* patchEncrypt;
@property(nonatomic,copy)NSString* moduleId;
@property(nonatomic)Boolean isMandatory;
@property(nonatomic,strong)NSString* downloadUrl;
@property(nonatomic,copy)NSString* osign;
+(WAUpdateInfo*)parserWithDict:(NSDictionary*)dict;
@end
