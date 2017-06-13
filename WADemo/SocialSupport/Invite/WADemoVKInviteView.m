//
//  WADemoVKInviteView.m
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoVKInviteView.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import "WADemoVKFriendList.h"
#import "WADemoMaskLayer.h"
#import "WADemoGroups.h"
#import "WADemoAlertView.h"
@implementation WADemoVKInviteView
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
    [btn1 setTitle:@"invite" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"app.groups" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(appGroup) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"user.groups" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(userGroups) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    WADemoButtonMain* btn4 = [[WADemoButtonMain alloc]init];
    [btn4 setTitle:@"all groups" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(getAllGroups) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn4];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1,@1,@1]];
    //
    self.title = @"VK邀请";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)invite{
    [WADemoMaskLayer startAnimating];
    [WASocialProxy queryInvitableFriendsWithDuration:0 platform:WA_PLATFORM_VK completeBlock:^(NSArray *friends, NSError *error) {
        if (!error) {
            WADemoVKFriendList* vkFriendList = [[WADemoVKFriendList alloc]init];
            vkFriendList.friends = friends;
            [self addSubview:vkFriendList];
            
        }else{
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"失败" message:error.description cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
        
        [WADemoMaskLayer stopAnimating];
    }];
}

-(void)appGroup{
    [WADemoMaskLayer startAnimating];
    [WASocialProxy getCurrentAppLinkedGroupWithPlatfrom:WA_PLATFORM_VK extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        [WADemoMaskLayer stopAnimating];
        if (!error) {
            UIViewController* vc = [WADemoUtil getCurrentVC];
            WADemoGroups* groupView = [[WADemoGroups alloc]init];
            groupView.groups = groups;
            groupView.hasBackBtn = YES;
            [vc.view addSubview:groupView];
            [groupView moveIn:nil];
        }else{
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"失败" message:error.description cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
}

-(void)userGroups{
    [WADemoMaskLayer startAnimating];
    [WASocialProxy getCurrentUserGroupWithPlatfrom:WA_PLATFORM_VK extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        [WADemoMaskLayer stopAnimating];
        if (!error) {
            UIViewController* vc = [WADemoUtil getCurrentVC];
            WADemoGroups* groupView = [[WADemoGroups alloc]init];
            groupView.groups = groups;
            groupView.hasBackBtn = YES;
            [vc.view addSubview:groupView];
            [groupView moveIn:nil];
        }else{
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"失败" message:error.description cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
}

-(void)getAllGroups{
    [WADemoMaskLayer startAnimating];
    [WASocialProxy getGroupsWithPlatform:WA_PLATFORM_VK extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        [WADemoMaskLayer stopAnimating];
        if (!error) {
            UIViewController* vc = [WADemoUtil getCurrentVC];
            WADemoGroups* groupView = [[WADemoGroups alloc]init];
            groupView.groups = groups;
            groupView.hasBackBtn = YES;
            [vc.view addSubview:groupView];
            [groupView moveIn:nil];
        }else{
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"失败" message:error.description cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
}
+(void)getCurrentAppGroup{
    [WASocialProxy getCurrentAppLinkedGroupWithPlatfrom:WA_PLATFORM_VK extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        if (!error) {
            //查询成功
        }else{
            //查询失败
        }
    }];
}

+(void)getCurrentUserGroup{
    [WASocialProxy getCurrentUserGroupWithPlatfrom:WA_PLATFORM_VK extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        if (!error) {
            //查询成功
        }else{
            //查询失败
        }
    }];
}

+(void)getAllGroup{
    [WASocialProxy getGroupsWithPlatform:WA_PLATFORM_VK extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        if (!error) {
            //查询成功
        }else{
            //查询失败
        }
    }];
}
@end
