//
//  GHWLoginUI.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoLoginUI.h"
#import "WADemoButtonMain.h"
#import "WADemoButtonSwitch.h"
#import "ViewController.h"
#import "WADemoUtil.h"
#import "WADemoMaskLayer.h"
#import <Toast/Toast.h>
#import "WADemoAlertView.h"

@interface WADemoLoginUI()
@property(nonatomic)BOOL cacheEnabled;
@end
@implementation WADemoLoginUI

-(instancetype)initWithBtns:(NSMutableArray *)btns btnLayout:(NSMutableArray *)btnLayout{
    self = [super initWithBtns:btns btnLayout:btnLayout];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBtnAndLayout];
    }
    return self;
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    WADemoButtonSwitch* btn1 = [[WADemoButtonSwitch alloc]init];
    
    NSString* btnTitle;
    if ([WAUserProxy getLoginFlowType] == WA_LOGIN_FLOW_TYPE_DEFAULT) {
        btnTitle = @"登录时不重新绑定设备";
    }else{
        btnTitle = @"登录时重新绑定设备";
    }
    
    [btn1 setTitle:btnTitle forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(changeLoginFlowType:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonSwitch* btn2 = [[WADemoButtonSwitch alloc]init];
    [btn2 setTitle:@"Facebook登录" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(facebookLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"Apple登录" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(appleLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    WADemoButtonMain* btn4 = [[WADemoButtonMain alloc]init];
    [btn4 setTitle:@"VK登录" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(vkLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn4];
    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"Twitter登录" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(twitterLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];
    WADemoButtonMain* btn6 = [[WADemoButtonMain alloc]init];
    [btn6 setTitle:@"Instagram登录" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(instagramLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn6];
    WADemoButtonMain* btn7 = [[WADemoButtonMain alloc]init];
    [btn7 setTitle:@"访客登录" forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(anonymousLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn7];
    WADemoButtonMain* btn8 = [[WADemoButtonMain alloc]init];
    [btn8 setTitle:@"应用内登录" forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(appSelfLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn8];
    WADemoButtonMain* btn9 = [[WADemoButtonMain alloc]init];
    [btn9 setTitle:@"登录窗口" forState:UIControlStateNormal];
    [btn9 addTarget:self action:@selector(popLoginUI) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn9];
    WADemoButtonMain* btn10 = [[WADemoButtonMain alloc]init];
    
    NSString* btnTitle10;
    if (_cacheEnabled == NO) {
        btnTitle10 = @"不缓存登录方式";
    }else{
        btnTitle10 = @"缓存登录方式";
    }
    
    [btn10 setTitle:btnTitle10 forState:UIControlStateNormal];
    [btn10 addTarget:self action:@selector(setCache:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn10];
	
	
    WADemoButtonMain* btn12 = [[WADemoButtonMain alloc]init];
    [btn12 setTitle:@"sign in with apple  " forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(signinwithapple) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn12];
	
    btn12 = [[WADemoButtonMain alloc]init];
    [btn12 setTitle:@"GHG 登录 " forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(ghgLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn12];
	
	
    btn12 = [[WADemoButtonMain alloc]init];
    [btn12 setTitle:@"wa 登录 " forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(waLogin) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn12];
    
    
    
    WADemoButtonMain* btn11 = [[WADemoButtonMain alloc]init];
    [btn11 setTitle:@"登出" forState:UIControlStateNormal];
    [btn11 addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn11];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@2,@2,@2,@1,@2,@2
                                                                 ,@2]];
//
    self.title = @"登录";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

- (void)deviceOrientationDidChange
{
    [super deviceOrientationDidChange];
    [WADemoMaskLayer deviceOrientationDidChange];
}

#pragma btn action
- (void)waLogin{
//    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_WINGA extInfo:nil delegate:self];

}

- (void)anonymousLogin{
    [WADemoMaskLayer startAnimating];
    NSLog(@"---anonymousLogin login ---");
    [WAUserProxy loginWithPlatform:WA_CONSTANT_GUEST extInfo:nil delegate:self];
}



-(void)ghgLogin{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_GHG extInfo:nil delegate:self];
}
//登录
-(void)facebookLogin{
    NSLog(@"---facebook login ---");
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_FACEBOOK extInfo:nil delegate:self];
    
}


-(void)appSelfLogin{
    [WADemoMaskLayer startAnimating];
    NSString* extra = @"{\"puserId\":\"12345\",\"extInfo\":\"extInfo String\",\"accessToken\":\"o1akkfjia81FMvFSO8kxC96TgQYlhEEr\",\"appSelfLogin\":true}";
    [WAUserProxy loginWithPlatform:WA_PLATFORM_APPSELFLOGIN extInfo:extra delegate:self];
}

-(void)appleLogin{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_APPLE extInfo:nil delegate:self];
    NSLog(@"---apple login ---");
//    [GHWSDKLoginManager loginWithType:GHWLoginTypeApple delegate:self];

}

-(void)vkLogin{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_VK extInfo:nil delegate:self];
}

-(void)twitterLogin{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_TWITTER extInfo:nil delegate:self];
}

-(void)instagramLogin{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_INSTAGRAM extInfo:nil delegate:self];
}
- (void)signinwithapple{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy loginWithPlatform:WA_PLATFORM_SIGNINWITHAPPLE extInfo:nil delegate:self];

	
	
}

//修改登录流程
- (void)changeLoginFlowType:(WADemoButtonSwitch *)btn {
    
    int flowType = [WAUserProxy getLoginFlowType];
    NSLog(@"flowType:%d",flowType);
    NSString* btnTitle;
    if (flowType == WA_LOGIN_FLOW_TYPE_REBIND) {
        flowType= WA_LOGIN_FLOW_TYPE_DEFAULT;
        btnTitle = @"登录时不重新绑定设备";
    }else{
        flowType = WA_LOGIN_FLOW_TYPE_REBIND;
        btnTitle = @"登录时重新绑定设备";
    }
    [WAUserProxy setLoginFlowType:flowType];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
}

//弹出登录窗口
-(void)popLoginUI{
    
    ViewController* curentVC = (ViewController*)[WADemoUtil getCurrentVC];
    [WAUserProxy login:curentVC cacheEnabled:_cacheEnabled];
    

    WAEvent* event = [[WAEvent alloc] init];
    event.defaultEventName =  @"purchase_sev";
    event.defaultParamValues = [[NSDictionary alloc] init];
    event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:@YES,WA_PLATFORM_FACEBOOK:@YES,WA_PLATFORM_WINGA:@YES,WA_PLATFORM_FIREBASE:@YES};
    [event trackEvent];
    

}

//登出
-(void)logout{
    
    WATutorialCompletedEvent * event =[[WATutorialCompletedEvent alloc]init];
    [event trackEvent];
    
    [WAUserProxy logout];
}

//设置是否缓存登录方式
-(void)setCache:(UIButton*)btn{
    NSString* title;
    if (_cacheEnabled == NO) {
        _cacheEnabled = YES;
        title = @"缓存登录方式";
    }else{
        _cacheEnabled = NO;
        title = @"不缓存登录方式";
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

#pragma mark GHWLoginDelegate
-(void)loginDidCompleteWithResults:(WALoginResult *)result{
    [WADemoMaskLayer stopAnimating];
	
//	[self showToastMessage:@"登录成功 "];

    NSString * gameuserid= [NSString stringWithFormat:@"server1-role1-%@",result.userId];

    NSString * serverid = [WACoreProxy getServerId];
    NSString * nickName = [NSString stringWithFormat:@"青铜server1-%@",result.userId];
    if ([serverid isEqualToString:@"server2"]) {
        gameuserid= [NSString stringWithFormat:@"server2-role2-%@",result.userId];
        nickName = [NSString stringWithFormat:@"青铜server2-%@",result.userId];
    }
    
    
    [WACoreProxy setNickName:nickName];
//    [WACoreProxy setGameUserId:gameuserid];
//    [WACoreProxy setServerId:@"server2"];

    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"登录成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@,pToken:%@,userId:%@,token:%@,是否为游客账号%d",result.platform,result.pUserId,result.pToken,result.userId,result.token,result.isGuestAccount] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
	
	
    WALog(@"result--token:%@",result.token);
    WALog(@"result--userid:%@",result.userId);
    WALog(@"result--pToken:%@",result.pToken);
    WALog(@"result--pUserid:%@",result.pUserId);
    WALog(@"result--platform:%@",result.platform);
    WALog(@"result--extends:%@",result.extends);
    if (result.platform == WA_PLATFORM_FACEBOOK||result.platform == WA_PLATFORM_VK) {
        
//        [WASocialProxy inviteInstallRewardPlatform:result.platform TokenString:result.pToken handler:^(NSUInteger code, NSString *msg, NSError *error) {
//            if (code == 200) {
//                
//                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"触发Facebook被邀请人安装应用事件接口成功 msg:%@",msg] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
//                [alert show];
//            }else{
//                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"触发Facebook被邀请人安装应用事件接口失败 error:%@",error] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
//                [alert show];
//            }
//        }];
    }
}

//-(void)loginDidCompleteWithResults:(WALoginResult *)result{
//    if (result.platform == WA_PLATFORM_FACEBOOK||result.platform == WA_PLATFORM_VK) {
//        
//        [WASocialProxy inviteInstallRewardPlatform:result.platform TokenString:result.pToken handler:^(NSUInteger code, NSString *msg, NSError *error) {
//            if (code == 200) {
//                //触发被邀请人安装应用事件接口成功
//               
//            }else{
//               //触发被邀请人安装应用事件接口失败
//            }
//        }];
//    }
//}

-(void)loginDidFailWithError:(NSError *)error andResult:(WALoginResult *)result{
    [WADemoMaskLayer stopAnimating];
    NSLog(@"result.pToken:%@",result.pToken);
    NSLog(@"result.pUserId:%@",result.pUserId);
    NSLog(@"loginDidFailWithError:%@",error);
    NSLog(@"result.msg:%@",result.msg);
    NSLog(@"result.code:%@",result.code);

    if ([result.apply_delete_status intValue]==1) {
        NSString * userid =result.userId;
        NSString * deletedata= result.delete_date;
        
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"cp回掉状态" message:[NSString stringWithFormat:@"userid=%@,删除日期=%@,登录平台=%@",userid,deletedata,result.platform] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
        


    }else{
        [self showToastMessage:error.localizedDescription];

    }
    
	
}

- (void)showToastMessage:(NSString *)messag{
	
	[self makeToast:messag duration:2 position:CSToastPositionCenter];

}

-(void)loginDidCancel:(WALoginResult *)result{
    [WADemoMaskLayer stopAnimating];
    NSLog(@"loginDidCancel--platform:%@",result.platform);
    [self showToastMessage:[NSString stringWithFormat:@"loginDidCancel==%@",result.platform]];
}

@end
