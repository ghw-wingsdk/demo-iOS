//
//  GHWAccountManagement.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoAccountManagement.h"
#import "WADemoButtonMain.h"
#import "WADemoAlertView.h"
#import "WADemoUtil.h"
#import "WADemoAccountSwitch.h"
#import "WADemoMaskLayer.h"
#import "WADemoViewController.h"
#import "WADemoBindingAccountList.h"

@implementation WADemoAccountManagement

-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        
        [self initBtnAndLayout];
        [self bindAddObserver];
    }
    return self;
}

#pragma mark 注册绑定解绑观察者
-(void)bindAddObserver{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bindDidSucceed:) name:WABindDidSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bindDidFail:) name:WABindDidFailNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unbindDidSucceed:) name:WAUnbindDidSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unbindDidFail:) name:WAUnbindDidFailNotification object:nil];
    
}

#pragma mark 移除绑定解绑观察者
-(void)bindRemoveObserver{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WABindDidSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WABindDidFailNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WAUnbindDidSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WAUnbindDidFailNotification object:nil];
}



#pragma mark 通过界面绑定解绑 接受通知的selector
-(void)bindDidSucceed:(NSNotification*)noti{
    
    if (noti.object) {
        WABindingResult* bResult = noti.object;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"绑定成功" message:[NSString stringWithFormat:@"platform:%@\nuserid:%@\ntoken:%@",bResult.platform,bResult.userId,bResult.accessToken] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
        
        
        if ([bResult.platform isEqualToString:WA_PLATFORM_FACEBOOK]||[bResult.platform isEqualToString:WA_PLATFORM_VK]) {
            [WASocialProxy inviteInstallRewardPlatform:bResult.platform TokenString:bResult.accessToken handler:^(NSUInteger code, NSString *msg, NSError *error) {
                if (code == 200) {
                    
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"触发Facebook被邀请人安装应用事件接口成功 msg:%@",msg] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
                    [alert show];
                }else{
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"触发Facebook被邀请人安装应用事件接口失败 error:%@",error] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
        
    }
}

//接收通知的方法
//-(void)bindDidSucceed:(NSNotification*)noti{
//    if (noti.object) {
//        WABindingResult* result = noti.object;
//        if ([result.platform isEqualToString:WA_PLATFORM_FACEBOOK]) {
//
//            [WASocialProxy inviteInstallRewardPlatform:WA_PLATFORM_FACEBOOK TokenString:result.accessToken handler:^(NSUInteger code, NSString *msg, NSError *error) {
//                if (code == 200) {
//                    //触发被邀请人安装应用事件接口成功
//
//                }else{
//                    //触发被邀请人安装应用事件接口失败
//
//                }
//            }];
//
//        }
//    }
//}

-(void)bindDidFail:(NSNotification*)noti{
    if (noti.object) {
        WABindingResult* bResult = noti.object;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"绑定失败" message:[NSString stringWithFormat:@"platform:%@\nuserid:%@\ntoken:%@",bResult.platform,bResult.userId,bResult.accessToken] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)unbindDidSucceed:(NSNotification*)noti{
    if (noti.object) {
        WAAccount* acct = noti.object;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"解绑成功" message:[NSString stringWithFormat:@"platform:%@\nuserid:%@",acct.platform,acct.pUserId] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)unbindDidFail:(NSNotification*)noti{
    if (noti.object) {
        WAAccount* acct = noti.object;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"解绑失败" message:[NSString stringWithFormat:@"platform:%@\nuserid:%@",acct.platform,acct.pUserId] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
        [alert show];
    }
}


-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    WADemoButtonMain* btn1 = [[WADemoButtonMain alloc]init];
    [btn1 setTitle:@"绑定Facebook账号" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(bindFB) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"绑定Apple账号" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(bindApple) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn7 = [[WADemoButtonMain alloc]init];
    [btn7 setTitle:@"绑定VK账号" forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(bindVK) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn7];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"新建账户" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(newAccount) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    WADemoButtonMain* btn4 = [[WADemoButtonMain alloc]init];
    [btn4 setTitle:@"切换账户" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(accoutSwitch) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn4];
    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"查询已绑定账户" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(bindingList) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];
    WADemoButtonMain* btn6 = [[WADemoButtonMain alloc]init];
    [btn6 setTitle:@"打开SDK内置账号管理界面" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(popAcctManagementUI) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn6];
    WADemoButtonMain* btn8 = [[WADemoButtonMain alloc]init];
    [btn8 setTitle:@"获取当前账户信息(getAccountInfo-VK)" forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(getAccountInfo) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn8];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@2,@2,@2,@1,@1]];
    //
    self.title = @"账户管理";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

#pragma mark btn Action
//绑定facebook
-(void)bindFB{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_FACEBOOK extInfo:nil delegate:self];
}
//绑定apple
-(void)bindApple{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_APPLE extInfo:nil delegate:self];
}

-(void)bindVK{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_VK extInfo:nil delegate:self];
}
//新建账户

-(void)newAccount{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy createNewAccountWithCompleteBlock:^(NSError *error, WALoginResult *result) {
        [WADemoMaskLayer stopAnimating];
        if (!error) {
            //新建账号成功
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"新建成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@\npToken:%@\nuserId:%@\ntoken:%@",result.platform,result.pUserId,result.pToken,result.userId,result.token] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }else{
            //新建账号错误处理
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"新建失败" message:[NSString stringWithFormat:@"platform:%@\nerror:%@",result.platform,error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
}
//切换账户
-(void)accoutSwitch{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoAccountSwitch* acctSwitch = [[WADemoAccountSwitch alloc]init];
    acctSwitch.hasBackBtn = YES;
    [vc.view addSubview:acctSwitch];
    [acctSwitch moveIn];
}

//查询已绑定账户
- (void)bindingList{
    [WAUserProxy queryBoundAccountWithCompleteBlock:^(NSError *error, NSArray *accounts) {
        if (error) {
            NSLog(@"error : %@",error.description);
        }else{
            WADemoBindingAccountList* accountList = [[WADemoBindingAccountList alloc]init];
            accountList.accounts = accounts;
            [self addSubview:accountList];
        }
    }];
    
}

//打开SDK内置账号管理界面
-(void)popAcctManagementUI{
    WADemoViewController* vc = (WADemoViewController*)[WADemoUtil getCurrentVC];
    [WAUserProxy openAccountManager:vc];
}

-(void)getAccountInfo{
    WAAppUser* appUser = [WAUserProxy getAccountInfoWithPlatform:WA_PLATFORM_VK];
    NSString* msg;
    if (appUser) {
        msg = [NSString stringWithFormat:@"platform:VK\nuserId:%@\nname:%@\npictureURL:%@\n",appUser.ID,appUser.name,appUser.pictureURL];
        
    }else{
        msg = @"获取账号信息为空,可能未登录相应平台";
    }
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"获取账号信息" message:msg cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}


/**
 *绑定成功
 */
-(void)bindingDidCompleteWithResult:(WABindingResult*)result{
    [WADemoMaskLayer stopAnimating];
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"绑定成功" message:[NSString stringWithFormat:@"绑定%@成功\n,userId:%@\ntoken:%@\n",result.platform,result.userId,result.accessToken] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
    
    if ([result.platform isEqualToString:WA_PLATFORM_FACEBOOK]||[result.platform isEqualToString:WA_PLATFORM_VK]) {
        [WASocialProxy inviteInstallRewardPlatform:result.platform TokenString:result.accessToken handler:^(NSUInteger code, NSString *msg, NSError *error) {
            if (code == 200) {
                
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"触发Facebook被邀请人安装应用事件接口成功 msg:%@",msg] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"触发Facebook被邀请人安装应用事件接口失败 error:%@",error] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    
}

//-(void)bindingDidCompleteWithResult:(WABindingResult*)result{
//
//    if ([result.platform isEqualToString:WA_PLATFORM_FACEBOOK]||[result.platform isEqualToString:WA_PLATFORM_VK]) {
//        [WASocialProxy inviteInstallRewardPlatform:result.platform TokenString:result.accessToken handler:^(NSUInteger code, NSString *msg, NSError *error) {
//            if (code == 200) {
//                //触发被邀请人安装应用事件接口成功
//            }else{
//
//                //触发被邀请人安装应用事件接口失败
//            }
//        }];
//    }
//
//}

/**
 *  绑定失败
 */
-(void)bindingDidFailWithError:(NSError*)error andResult:(WABindingResult*)result{
    [WADemoMaskLayer stopAnimating];
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"绑定失败" message:[NSString stringWithFormat:@"绑定%@失败,error:%@",result.platform,error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

/**
 *绑定取消
 */
-(void)bindingDidCancel:(WABindingResult*)result{
    [WADemoMaskLayer stopAnimating];
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:@"用户取消" cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
    [self bindRemoveObserver];
}
-(void)removeFromSuperview{
    
}

@end
