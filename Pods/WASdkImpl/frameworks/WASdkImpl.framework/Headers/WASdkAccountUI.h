//
//  WASDKAccountUI.h
//  test
//
//  Created by wuyx on 16/1/12.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WACommon/WACommon.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WASdkAccountUI : UIView
@property(nonatomic,strong)NSString* platform;
@property(nonatomic,strong)UILabel* accTypeLab;
@property(nonatomic,strong)UILabel* accLab;
@property(nonatomic,strong)WAAccount* account;
@property(nonatomic,strong)UIButton* actBtn;
@property(nonatomic,strong)UIColor* actBtnColor;
@property(nonatomic)BOOL hadBound;
@property(nonatomic)int borderWidth;
@end
