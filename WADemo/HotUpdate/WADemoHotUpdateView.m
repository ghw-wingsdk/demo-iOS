//
//  GHWHotUpdate.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoHotUpdateView.h"
#import "WADemoMaskLayer.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
@implementation WADemoHotUpdateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
    [btn1 setTitle:@"CheckUpdate(没有callback)" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(checkUpdate_nil) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"CheckUpdate(有callback)" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(checkUpdate_callback) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];

    
    
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1]];
    //
    self.title = @"检查更新";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)checkUpdate_nil{
    [WAHupProxy checkUpdate:nil];
}

-(void)checkUpdate_callback{
//    
    [WAHupProxy checkUpdate:^(NSError *error, WAUpdateInfo *updateInfo) {
        if (!error) {
            [WAHupProxy startUpdate:updateInfo handler:^(NSError *error) {
                if (!error) {
                    NSLog(@"patch 更新成功......................");
                }
            }];
        }
    }];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
