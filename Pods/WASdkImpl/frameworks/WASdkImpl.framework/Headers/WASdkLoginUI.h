//
//  WASDKLoginUI.h
//  WASDKUI
//
//  Created by wuyx on 16/1/11.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>
@interface WASdkLoginUI : UIControl
@property(nonatomic,strong)NSArray* loginWays;
-(instancetype)initWithCacheEnabled:(BOOL)cacheEnabled;
-(void)login:(id<WALoginViewDelegate>)delegate;
-(void)hide;
@end
