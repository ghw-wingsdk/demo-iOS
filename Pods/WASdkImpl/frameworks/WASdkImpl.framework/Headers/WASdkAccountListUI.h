//
//  WASDKAccountListUI.h
//  test
//
//  Created by wuyx on 16/1/12.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WACommon/WACommon.h>
#import <WASdkIntf/WASdkIntf.h>
#import "WASdkAccountMainUI.h"
@interface WASdkAccountListUI : UIView
-(instancetype)initWithFrame:(CGRect)frame andMainUI:(WASdkAccountMainUI*)mainUI;
@property(nonatomic,weak)WASdkAccountMainUI* mainUI;
@end
