//
//  GHWGiftView.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoFBGiftView.h"
#import "WADemoButtonMain.h"
#import "WADemoGiftListTVC.h"
#import "WADemoGiftListView.h"
#import "WADemoUtil.h"
#import "WADemoFriendInGameTV.h"
#import "WADemoGiftBoxTV.h"
#import "WADemoMaskLayer.h"
#import "WADemoAlertView.h"
@implementation WADemoFBGiftView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加界面旋转通知
        [self initBtnAndLayout];
    }
    return self;
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    WADemoButtonMain* btn1 = [[WADemoButtonMain alloc]init];
    [btn1 setTitle:@"Gift(Send/Ask)" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(getGiftList) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"Friends In Game" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(getFriendList) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"Gift box" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(showGiftBox) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    
    
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1,@1]];
    //
    self.title = @"FB礼物";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

#pragma mark btn action
- (void)getGiftList{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoGiftListView* giftList = [[WADemoGiftListView alloc]initWithFrame:self.bounds];
    giftList.hasBackBtn = YES;
    [vc.view addSubview:giftList];
    [giftList moveIn:^{
        [giftList getGiftList];
    }];
}

- (void)getFriendList{
    [WADemoMaskLayer startAnimating];
    
    [WASocialProxy queryFriendsWithPlatform:WA_PLATFORM_FACEBOOK completeBlock:^(NSArray *friends, NSError *error){
        if (!error) {
            WADemoFriendInGameTV* friendInGameTV = [[WADemoFriendInGameTV alloc]initWithFrame:CGRectMake(0, self.naviHeight, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
            friendInGameTV.friends = friends;
            [self addSubview:friendInGameTV];
            [WADemoMaskLayer stopAnimating];
        }else{
            NSLog(@"error:%@",error);
            [WADemoMaskLayer stopAnimating];
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
    
    
}

- (void)showGiftBox {
    WADemoGiftBoxTV* giftBox = [[WADemoGiftBoxTV alloc]init];
    [self addSubview:giftBox];
}

@end
