//
//  WAIPay.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol WAInventoryDelegate,WAPaymentDelegate;
@interface WAIPay : NSObject
-(void)init4Iap;
-(void)queryInventory:(id<WAInventoryDelegate>)delegate;
-(void)payWithProductId:(NSString *)productId extInfo:(NSString *)extInfo delegate:(id<WAPaymentDelegate>)delegate;
-(BOOL)isPayServiceAvailable;
-(void)fetchProductInformations:(NSDictionary *)waProductIds inventoryDelegate:(id<WAInventoryDelegate>)delegate;
-(SKProduct*)getCurrentProduct;
-(NSData*)getCurrentReceipt;
-(float)getReorderLimitTime;
@end
