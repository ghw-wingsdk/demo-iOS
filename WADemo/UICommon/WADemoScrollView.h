//
//  GHWMainScrollView.h
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/23.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WADemoScrollView : UIScrollView
@property(nonatomic)float top;
@property(nonatomic)float bottom;
@property(nonatomic)float left;
@property(nonatomic)float right;
@property(nonatomic)float mid_space_h;
@property(nonatomic)float mid_space_v;
@property(nonatomic)float btnHeight;
//@property(nonatomic)float naviHeight;
@property(nonatomic,strong)NSMutableArray* btns;
@property(nonatomic,strong)NSMutableArray* btnLayout;
-(instancetype)initWithFrame:(CGRect)frame btns:(NSMutableArray*)btns btnLayout:(NSMutableArray*)btnLayout;
//-(instancetype)initWithFrame:(CGRect)frame btns:(NSMutableArray*)btns btnLayout:(NSMutableArray*)btnLayout naviHeight:(float)naviHeight;
-(void)deviceOrientationDidChange;
@end
