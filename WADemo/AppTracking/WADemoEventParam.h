//
//  GHWEventParam_.h
//  GHWSDKUI
//
//  Created by wuyx on 16/2/22.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum GHWParamType{
    GHWParamTypeInt,
    GHWParamTypeString,
    GHWParamTypeBool,
    GHWParamTypeDouble
}GHWParamType;
@interface WADemoEventParam : NSObject
@property(nonatomic,copy)NSString* paramName;
@property(nonatomic,copy)NSString* paramDesc;
@property(nonatomic)GHWParamType paramType;
@property(nonatomic,copy)NSString* paramDefValue;
@end
