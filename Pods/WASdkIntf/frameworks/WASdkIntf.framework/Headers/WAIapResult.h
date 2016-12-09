//
//  GhwSdkIapResult.h
//  GHWSdk
//
//  Created by GHW-T-01 on 15/5/25.
//  Copyright (c) 2015年 Wuyx. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAIapResult 支付结果类
 - - -
 */
@interface WAIapResult : NSObject
/*!
 @abstract Only set if state is SKPaymentTransactionFailed
 
 Available downloads (SKDownload) for this transaction
 */
@property(nonatomic) NSArray *downloads;
/*!
 @abstract The date when the transaction was added to the server queue.  Only valid if state is SKPaymentTransactionStatePurchased or SKPaymentTransactionStateRestored.
 */
@property(nonatomic) NSDate *transactionDate;
/*!
 @abstract The unique server-provided identifier.  Only valid if state is SKPaymentTransactionStatePurchased or SKPaymentTransactionStateRestored.
 */
@property(nonatomic) NSString *transactionIdentifier;
/*!
 @abstract Only valid if state is SKPaymentTransactionStatePurchased.
 */
@property(nonatomic) NSData *transactionReceipt;
/*!
 @abstract Identifier agreed upon with the store.  Required.
 */
@property(nonatomic) NSString *productIdentifier;
/*!
 @abstract Payment request data agreed upon with the store.  Optional.
 */
@property(nonatomic) NSData *requestData;
/*!
 @abstract default: 1.  Must be at least 1.
 */
@property(nonatomic) NSInteger quantity;
/*!
 @abstract 基准支付金额
 */
@property(nonatomic) NSString* defaultAmountMicro;
/*!
 @abstract 基准支付币种
 */
@property(nonatomic) NSString* defaultCurrency;
/*!
 @abstract 平台服务器自动生成的订单id
 */
@property(nonatomic) NSString* orderId;
/*!
 @abstract 支付结果
 */
@property(nonatomic) long resultCode;

@end
