//
//  GHWSDKPaymentTransaction.h
//  GHWSdkUI
//
//  Created by wuyx on 15/8/20.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
@interface WAAPPaymentTransaction : NSObject<NSCoding,NSCopying>
@property(strong,nonatomic)SKPaymentTransaction* skPaymentTransaction;
@property(nonatomic)int status;
@end
