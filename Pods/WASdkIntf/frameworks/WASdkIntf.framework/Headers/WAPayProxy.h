//
//  WAPayProxy.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAIPay.h"
@class WAIapProduct,WAIapResult;

/*!
 @discussion 查询商品库存协议
 - - -
 */
@protocol WAInventoryDelegate <NSObject>
@required
/*!
 @abstract 查询成功
 @param Inventory 是一个数组，保存着WAIapProduct类型的实例
 @param platform 支付平台
 */
-(void)queryInventoryDidCompleteWithResult:(NSArray<WAIapProduct *>*)Inventory;
/*!
 @abstract 查询失败
 @param error 错误
 @param platform 支付平台
 */
-(void)queryInventoryDidFailWithError:(NSError*)error;
@end
/*!
 @discussion 支付协议
 - - -
 */
@protocol WAPaymentDelegate <NSObject>
/*!
 @abstract 支付成功
 @param iapResult 支付结果
 @param platform 支付平台
 */
-(void)paymentDidCompleteWithResult:(WAIapResult*)iapResult andPlatform:(NSString*)platform;
/*!
 @abstract 支付失败
 @param error 错误
 @param platform 支付平台
 */
-(void)paymentDidFailWithError:(NSError*)error andPlatform:(NSString*)platform;
@end

/*!
 @discussion WAPayProxy 是支付模块的代理类。
 - - -
 */
@interface WAPayProxy : NSObject
/*!
 @abstract 应用内支付初始化
 @param platform 支付平台
 */
+(void)init4Iap;
/*!
 @abstract 查询商品列表调用方法
 @param platform 支付平台
 */
+(void)queryInventoryWithDelegate:(id<WAInventoryDelegate>)delegate;
/*!
 @abstract 支付某个商品
 @param productId 商品id
 @param platform 支付平台
 @param extInfo 扩展信息
 */
+(void)payWithProductId:(NSString*)productId extInfo:(NSString*)extInfo delegate:(id<WAPaymentDelegate>)delegate;
/*!
 @abstract 查询是否某个支付平台
 @param platform 支付平台
 @return bool 是否支持某个支付平台
 */
+(BOOL)isPayServiceAvailableWithPlatform:(NSString *const)platform;

@end
