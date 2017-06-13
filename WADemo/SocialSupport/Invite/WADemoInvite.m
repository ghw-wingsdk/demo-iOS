//
//  WADemoInvite.m
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoInvite.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import "WADemoFBInviteView.h"
#import "WADemoVKInviteView.h"

@interface WADemoInvite ()

@property (nonatomic, strong) WADemoFBInviteView* fbInviteView;
@property (nonatomic, strong) WADemoVKInviteView* vkInviteView;

@end

@implementation WADemoInvite
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBtnAndLayout];
    }
    return self;
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    WADemoButtonMain* btn1 = [[WADemoButtonMain alloc]init];
    [btn1 setTitle:@"FB" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(fb) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"VK" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(vk) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1]];
    //
    self.title = @"邀请";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)fb{
    
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _fbInviteView = [[WADemoFBInviteView alloc]initWithFrame:self.bounds];
    self.fbInviteView.hasBackBtn = YES;
    [vc.view addSubview:self.fbInviteView];
    [self.fbInviteView moveIn:nil];
}

-(void)vk{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _vkInviteView = [[WADemoVKInviteView alloc]initWithFrame:self.bounds];
    self.vkInviteView.hasBackBtn = YES;
    [vc.view addSubview:self.vkInviteView];
    [self.vkInviteView moveIn:nil];
}

- (void)deviceOrientationDidChange
{
    [super deviceOrientationDidChange];
    
    if (self.fbInviteView)
        [self.fbInviteView deviceOrientationDidChange];
    
    if (self.vkInviteView)
        [self.vkInviteView deviceOrientationDidChange];
}

@end
