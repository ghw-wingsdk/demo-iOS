//
//  APLoginInfo.h
//  WAApImplUI
//
//  Created by wuyx on 16/3/7.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAAPLoginInfo : NSObject<NSCoding,NSCopying>
@property(nonatomic,strong)NSURL* publicKeyUrl;
@property(nonatomic,strong)NSData* signature;
@property(nonatomic,strong)NSData* salt;
@property(nonatomic)uint64_t timestamp;
@end
