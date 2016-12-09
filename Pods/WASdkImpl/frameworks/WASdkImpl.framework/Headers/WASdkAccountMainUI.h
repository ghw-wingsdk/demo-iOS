//
//  WASDKAccountUI.h
//  test
//
//  Created by wuyx on 16/1/12.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>
@interface WASdkAccountMainUI : UIControl
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UIView* separator;
@property(nonatomic,strong)UIView* contentView;
@property(nonatomic,strong)UIButton* backBtn;
@property(nonatomic,strong)NSMutableArray* views;
@property(nonatomic,weak)id<WAAcctManagerDelegate>acctDelegate;
-(instancetype)initWithViewController:(id<WAAcctManagerDelegate>)viewController;
+(void)showAccountManager:(id<WAAcctManagerDelegate>)viewController;
-(void)newAcctDidCompleteWithResult:(WALoginResult*)result;
-(void)switchAcctDidCompleteWithResult:(WALoginResult*)result;
-(void)addMaskLayer:(BOOL)canRemove;
-(void)removeMaskLayer;
@end
