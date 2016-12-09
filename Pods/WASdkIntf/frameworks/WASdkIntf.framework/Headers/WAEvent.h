//
//  WAEvent.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/4/14.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAEvent 该类用来做数据收集
 - - -
 */
@interface WAEvent : NSObject
/*!
 @abstract 默认事件名称
 */
@property(nonatomic,strong)NSString* defaultEventName;
/*!
 @abstract 默认累加值
 */
@property(nonatomic)double defaultValue;
/*!
 @abstract 默认参数字典
 */
@property(nonatomic,strong)NSDictionary* defaultParamValues;
/*!
 @abstract 数据收集渠道开关
 */
@property(nonatomic,strong)NSDictionary* channelSwitcherDict;
/*!
 @abstract 各个渠道事件名称
 */
@property(nonatomic,strong)NSDictionary* eventNameDict;
/*!
 @abstract 各个渠道累加值
 */
@property(nonatomic,strong)NSDictionary* valueDict;
/*!
 @abstract 各个渠道参数字典
 */
@property(nonatomic,strong)NSDictionary* paramValuesDict;
/*!
 @discussion 构建一个WAIEvent实例，调用该方法可以将数据发送到各个渠道。
 */
-(void)trackEvent;
@end
