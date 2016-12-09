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
@implementation WADemoInvite
-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
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
    WADemoFBInviteView* fbInviteView = [[WADemoFBInviteView alloc]init];
    fbInviteView.hasBackBtn = YES;
    [vc.view addSubview:fbInviteView];
    [fbInviteView moveIn];
}

-(void)vk{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoVKInviteView* vkInviteView = [[WADemoVKInviteView alloc]init];
    vkInviteView.hasBackBtn = YES;
    [vc.view addSubview:vkInviteView];
    [vkInviteView moveIn];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}
@end
