//
//  GHWSDKShareError.h
//  GHWSdkUI
//
//  Created by wuyx on 15/6/12.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAErrorCode.h"

@interface WAError : NSObject
+ (NSString *)errorDomain;

+ (BOOL)errorIsNetworkError:(NSError *)error;

+ (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message;
+ (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message underlyingError:(NSError *)underlyingError;
+ (NSError *)errorWithCode:(NSInteger)code
                  userInfo:(NSDictionary *)userInfo
                   message:(NSString *)message
           underlyingError:(NSError *)underlyingError;

+ (NSError *)invalidArgumentErrorWithName:(NSString *)name value:(id)value message:(NSString *)message;
+ (NSError *)invalidArgumentErrorWithName:(NSString *)name
                                    value:(id)value
                                  message:(NSString *)message
                          underlyingError:(NSError *)underlyingError;
+ (NSError *)invalidCollectionErrorWithName:(NSString *)name
                                 collection:(id<NSFastEnumeration>)collection
                                       item:(id)item
                                    message:(NSString *)message;
+ (NSError *)invalidCollectionErrorWithName:(NSString *)name
                                 collection:(id<NSFastEnumeration>)collection
                                       item:(id)item
                                    message:(NSString *)message
                            underlyingError:(NSError *)underlyingError;

+ (NSError *)requiredArgumentErrorWithName:(NSString *)name message:(NSString *)message;
+ (NSError *)requiredArgumentErrorWithName:(NSString *)name
                                   message:(NSString *)message
                           underlyingError:(NSError *)underlyingError;

+ (NSError *)unknownErrorWithMessage:(NSString *)message;
@end
