//
//  GHWInviteView.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoFBInviteView.h"
#import "WADemoButtonMain.h"
#import "WADemoFriendListTV.h"
#import "WADemoMaskLayer.h"
#import "WADemoAlertView.h"
#import "WADemoUtil.h"
@implementation WADemoFBInviteView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
    [btn1 setTitle:@"Invite Friends" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(inviteFriends) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"Event reward" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(eventReward) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
//    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
//    [btn3 setTitle:@"FBAppInvite" forState:UIControlStateNormal];
//    [btn3 addTarget:self action:@selector(fbAppInvite) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn3];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1]];
    //
    self.title = @"Facebook邀请";
    self.btnLayout = btnLayout;
    self.btns = btns;
}
#pragma btn action
-(void)inviteFriends{
    [WADemoMaskLayer startAnimating];
//    [WASocialProxy queryInvitableFriendsWithDuration:5 platform:WA_PLATFORM_FACEBOOK completeBlock:^(NSArray *friends, NSError *error) {
//        if (!error) {
//            WADemoFriendListTV* friendsListTV = [[WADemoFriendListTV alloc]init];
//            friendsListTV.friends = friends;
//            [self addSubview:friendsListTV];
//            [WADemoMaskLayer stopAnimating];
//        }else{
//            NSLog(@"error:%@",error);
//            [WADemoMaskLayer stopAnimating];
//            [WADemoMaskLayer stopAnimating];
//            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
//            [alert show];
//        }
//    }];
        [WASocialProxy sendRequestWithPlatform:WA_PLATFORM_FACEBOOK requestType:WA_REQUEST_TYPE_INVITE title:@"Game for you." message:@"Take this bomb to blast your way to victory!!!" objectId:nil receiptIds:nil delegate:self];
}

-(void)eventReward{
    [WASocialProxy inviteEventRewardWithPlatform:WA_PLATFORM_FACEBOOK eventName:@"testxia" handler:^(NSUInteger code, NSString *msg, NSError *error) {
        if (code == 200) {
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"发送Facebook邀请奖励事件成功(testxia) msg:%@",msg] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }else{
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"发送Facebook邀请奖励事件失败(testxia):error:%@",error] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
//    [WASocialProxy inviteEventRewardWithPlatform:WA_PLATFORM_FACEBOOK eventName:@"eventName" handler:^(NSUInteger code, NSString *msg, NSError *error) {
//        if (code == 200) {
//            //发送邀请奖励事件成功
//        }else{
//            //发送邀请奖励事件失败
//        }
//    }];
    
}

- (void)fbAppInvite{
    
    WAAppInviteContent* content = [[WAAppInviteContent alloc]init];
    content.appLinkURL = [NSURL URLWithString:@"https://fb.me/1831135537104541"];
    content.appInvitePreviewImageURL = [NSURL URLWithString:@"https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xaf1/t39.2081-0/11057103_1038207922873472_1902526455_n.jpg"];
    [WASocialProxy appInviteWithPlatform:WA_PLATFORM_FACEBOOK Content:content delegate:self];
}

//邀请成功
- (void)appInviteDialog:(WAAppInviteDialog *)appInviteDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    [WADemoMaskLayer stopAnimating];
    NSString *msg = @"邀请成功";
    if (!results || ![results isKindOfClass:[NSDictionary class]] || [@"cancel" isEqualToString:results[@"completionGesture"]])
    {
        msg = @"邀请取消";
    }
    
    NSLog(@"%@:result:%@", msg, results);
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:msg message:[NSString stringWithFormat:@"%@:result:%@",msg, results] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

//邀请失败
- (void)appInviteDialog:(WAAppInviteDialog *)appInviteDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"邀请失败:error:%@",error.description);
    [WADemoMaskLayer stopAnimating];
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"邀请失败" message:[NSString stringWithFormat:@"邀请失败:error:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

#pragma mark delegate WAGameRequestDialogDelegate
//请求成功
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    
    NSLog(@"WASDK LOG :platform:%@ didCompleteWithResults : %@",platform,results);
    [WADemoMaskLayer stopAnimating];
    
    NSString* content = [NSString stringWithFormat:@"success platform :%@didCompleteWithResults :%@",platform,results];
    [self alertWithContent:content andTitle:@"Success"];
    
    //邀请好友成功 发送邀请信息到SDK后台
    if ([platform isEqualToString:WA_PLATFORM_FACEBOOK]||[platform isEqualToString:WA_PLATFORM_VK]) {
        
        [WASocialProxy createInviteInfoWithPlatform:platform results:results handler:^(NSUInteger code, NSString *msg, NSError *error) {
            //当code为200时,表示发送成功 进行相应的操作。
            if (code == 200) {
                
 
                
                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"发送邀请信息到SDK后台成功 msg:%@",msg] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];

                
                
            }else{

                
                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"发送邀请信息到SDK后台失败 error:%@",error] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];
                
            }
        }];
        
    }
    
}

//请求失败
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"GHWSDK LOG : didFailWithError : %@",error.description);
    [WADemoMaskLayer stopAnimating];
    NSString* content = [NSString stringWithFormat:@"gameRequestDialog didFailWithError :%@",error.description];
    [self alertWithContent:content andTitle:@"Fail"];
}

//请求取消
- (void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform{
    [WADemoMaskLayer stopAnimating];
    [self alertWithContent:@"Did cancel" andTitle:@"Cancel"];
    NSLog(@"gameRequestDialogDidCancel");
}


-(void)alertWithContent:(NSString*)content andTitle:(NSString*)title{

    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:title message:content cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

@end
