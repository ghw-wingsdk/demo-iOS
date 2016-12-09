//
//  GHWEventData.h
//  GHWSDKUI
//
//  Created by wuyx on 16/2/22.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WADemoEventData : NSObject
@property(nonatomic,copy)NSString* eventName;
@property(nonatomic,copy)NSMutableArray* params;
//@property(nonatomic,copy)NSMutableArray* eventData;
@property(nonatomic,copy)NSString* value;
@property(nonatomic)BOOL on;
@property(nonatomic)BOOL eventNameOn;
@property(nonatomic)BOOL paramDictOn;
+(WADemoEventData*)getEventDataWithEventName:(NSString*)eventName;
@end
