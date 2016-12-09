//
//  GHWSDKPaymentTransactionHandler.h
//  GHWSdkUI
//
//  Created by wuyx on 15/8/19.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

extern NSString *CACHE_KEY_PAYMENT_TRANSACTION;

@interface WAAPPaymentTransactionHandler : NSObject
@property(strong,nonatomic)NSMutableDictionary* unConsumeOrderList;
/**
 *  将上报失败的订单保存到缓存中
 *
 *  @param skPaymentTransaction
 *  @param status
 */
+(void)saveCacheWithPaymentTransaction:(SKPaymentTransaction*)skPaymentTransaction andStatus:(int)status;


/**
 *  通过skProduct 获取未消耗订单列表
 *
 *  @param skProduct
 *
 *  @return NSMutableArray
 */
+(NSMutableArray*)getUnconsumeOrderListWithProduct:(SKProduct*)skProduct;

/**
 *  处理未消耗订单
 *
 *  @param unComsumeList 未消耗订单列表
 */
+(void)handleWithUnComsumeList:(NSArray*)unComsumeList;

/**
 *  重试成功,移除未消耗订单
 *
 *  @param skPaymentTransaction
 */
+(void)removeUncomsumeListWithPaymentTransaction:(SKPaymentTransaction *)skPaymentTransaction;
@end
