//
//  GHWAccountSwitch.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoAccountSwitch.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import "WADemoAlertView.h"
#import "WADemoMaskLayer.h"
@implementation WADemoAccountSwitch

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
    [btn1 setTitle:@"Facebook" forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(switchAccount:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"Apple" forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(switchAccount:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1]];
    //
    self.title = @"切换账户";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)switchAccount:(UIButton*)btn{
    [WADemoMaskLayer startAnimating];
    NSString* loginType;
    if (btn.tag == 1) loginType = WA_PLATFORM_FACEBOOK;
    else if(btn.tag ==2) loginType = WA_PLATFORM_APPLE;
    
    [WAUserProxy switchAccountWithPlatform:loginType completeBlock:^(NSError *error, WALoginResult *result) {
        if (!error) {
            
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"切换成功" message:[NSString stringWithFormat:@"userId:%@\ntoken:%@\nplatform:%@\npUserId:%@\npToken:%@\nextends:%@",result.userId,result.token,result.platform,result.userId,result.pToken,result.extends] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
            
        }else{
            NSLog(@"switchAccount error : %@",error);
            
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"切换失败" message:[NSString stringWithFormat:@"error : %@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
        
        [WADemoMaskLayer stopAnimating];
    }];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
