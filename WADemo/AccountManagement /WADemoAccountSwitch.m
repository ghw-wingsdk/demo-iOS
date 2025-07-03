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

@interface WADemoAccountSwitch ()

@property (nonatomic, strong) NSDictionary *loginTypeDict;

@end

@implementation WADemoAccountSwitch

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBtnAndLayout];
    }
    return self;
}

-(void)initBtnAndLayout{
    _loginTypeDict = @{@"Facebook" : WA_PLATFORM_FACEBOOK,
                       @"Apple" : WA_PLATFORM_APPLE,
                       @"VK" : WA_PLATFORM_VK,
                       @"Twitter" : WA_PLATFORM_TWITTER,
                       @"Instagram" : WA_PLATFORM_INSTAGRAM,
                       @"guest" : WA_CONSTANT_GUEST,
                       @"wa" : WA_PLATFORM_WINGA,
                       @"signinwithapp" : WA_PLATFORM_SIGNINWITHAPPLE,

	};
    NSArray *titleStrs = @[@"Facebook", @"Apple", @"VK", @"Twitter", @"Instagram",@"guest",@"wa",@"signinwithapp"];
    
    NSMutableArray* btns = [NSMutableArray array];
    NSMutableArray* btnLayout = [NSMutableArray array];
    
    WADemoButtonMain *button;
    for (NSString *titleStr in titleStrs)
    {
        button = [[WADemoButtonMain alloc]init];
        [button setTitle:titleStr forState:UIControlStateNormal];
        [button addTarget:self action:@selector(switchAccount:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:button];
        
        [btnLayout addObject:@1];
    }
    //
    self.title = @"切换账户";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)switchAccount:(UIButton*)btn
{
    [WADemoMaskLayer startAnimating];
    
    NSString* loginType = [self.loginTypeDict objectForKey:[btn titleForState:UIControlStateNormal]];

    
    [WAUserProxy switchAccountWithPlatform:loginType completeBlock:^(NSError *error, WALoginResult *result) {
        if (!error) {
            
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"切换成功" message:[NSString stringWithFormat:@"userId:%@\ntoken:%@\nplatform:%@\npUserId:%@\npToken:%@\nextends:%@ 是否为游客登录:%d",result.userId,result.token,result.platform,result.pUserId,result.pToken,result.extends,result.isGuestAccount] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
            
        }else{
            NSLog(@"switchAccount error : %@",error);
            
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"切换失败" message:[NSString stringWithFormat:@"error : %@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
        
        [WADemoMaskLayer stopAnimating];
    }];
}

@end
