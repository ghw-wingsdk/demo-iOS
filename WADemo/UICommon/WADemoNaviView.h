//
//  GHWNaviView.h
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WADemoScrollView.h"
@interface WADemoNaviView : UIView
@property(nonatomic,strong)NSMutableArray* btns;
@property(nonatomic,strong)NSMutableArray* btnLayout;
@property(nonatomic)float naviHeight;
@property(nonatomic,strong)NSString* title;
@property(nonatomic)BOOL hasBackBtn;
@property(nonatomic)BOOL animated;
@property(nonatomic,strong)WADemoScrollView* scrollView;
-(instancetype)initWithBtns:(NSMutableArray *)btns btnLayout:(NSMutableArray *)btnLayout;
-(void)initUI;
-(void)deviceOrientationDidChange;
-(void)moveIn:(void (^)(void))finishedBlock;
-(void)removeView;
@end
