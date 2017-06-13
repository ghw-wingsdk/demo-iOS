//
//  WADemoGiftView_.m
//  WADemo
//
//  Created by wuyx on 16/7/18.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoGiftView.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import "WADemoFBGiftView.h"
#import "WADemoVKGiftView.h"
@implementation WADemoGiftView
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
    self.title = @"礼物";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)fb{
    
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoFBGiftView* fbGiftView = [[WADemoFBGiftView alloc]initWithFrame:self.bounds];
    fbGiftView.hasBackBtn = YES;
    [vc.view addSubview:fbGiftView];
    [fbGiftView moveIn:nil];
}

-(void)vk{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoVKGiftView* vkGiftView = [[WADemoVKGiftView alloc]initWithFrame:self.bounds];
    vkGiftView.hasBackBtn = YES;
    [vc.view addSubview:vkGiftView];
    [vkGiftView moveIn:nil];
}
@end
