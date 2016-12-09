//
//  GHWSdkIapProduct.h
//  GHWSdk
//
//  Created by GHW-T-01 on 15/5/28.
//  Copyright (c) 2015年 Wuyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAPayChannel.h"
/*!
 @discussion WAIapProduct 商品类
 - - -
 */
@interface WAIapProduct : NSObject
@property(nonatomic, strong) NSString *localizedDescription NS_AVAILABLE_IOS(3_0);

@property(nonatomic, strong) NSString *localizedTitle NS_AVAILABLE_IOS(3_0);

@property(nonatomic, strong) NSDecimalNumber *price NS_AVAILABLE_IOS(3_0);

@property(nonatomic, strong) NSLocale *priceLocale NS_AVAILABLE_IOS(3_0);

@property(nonatomic, strong) NSString *productIdentifier NS_AVAILABLE_IOS(3_0);

// YES if this product has content downloadable using SKDownload
@property(nonatomic) BOOL downloadable NS_AVAILABLE_IOS(6_0);

// Sizes in bytes (NSNumber [long long]) of the downloads available for this product
@property(nonatomic, strong) NSArray<NSNumber *> *downloadContentLengths NS_AVAILABLE_IOS(6_0);

// Version of the downloadable content
@property(nonatomic, strong) NSString *downloadContentVersion NS_AVAILABLE_IOS(6_0);
// payment method
@property(nonatomic, strong) NSArray<WAPayChannel *> *payChannels NS_AVAILABLE_IOS(6_0);

@end
