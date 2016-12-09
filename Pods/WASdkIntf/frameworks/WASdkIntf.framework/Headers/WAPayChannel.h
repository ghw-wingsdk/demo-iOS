//
//  WAPayChannel.h
//  WASdkIntfUI
//
//  Created by hank on 16/4/28.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//  支付渠道

#import <Foundation/Foundation.h>

@interface WAPayChannel : NSObject

@property (nonatomic, strong) NSString *channelProductId; // 支付渠道平台产品编号
@property (nonatomic, assign) NSInteger payChannelId;   // 支付方式编号
@property (nonatomic, strong) NSString *payChannelName; // 支付方式名称 如APPLE 、GOOGLE
@property (nonatomic, assign) NSInteger payMethod;      // 支付方式 1 native、2 webview
@property (nonatomic, assign) NSInteger status;         // 状态 -1 关闭 1 打开
@property (nonatomic, strong) NSString *logoUrl;        // 支付方式图标下载地址

@end
