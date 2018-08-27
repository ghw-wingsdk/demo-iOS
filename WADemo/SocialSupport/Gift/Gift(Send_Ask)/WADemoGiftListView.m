//
//  GHWGiftList.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoGiftListView.h"
#import "WADemoGiftList.h"
#import "WADemoMaskLayer.h"
#import "WADemoUtil.h"
#import "WADemoAlertView.h"
@implementation WADemoGiftListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
//        [self getGiftList];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}


-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    
    NSMutableArray* btnLayout = [NSMutableArray array];
    self.title = @"Gift(Send/Ask)";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)getGiftList{
    [WADemoMaskLayer startAnimating];
    //objectType 必须赋值 详见附录
    NSString* objectType = @"com_ghw_sdk:gift";
    [WASocialProxy queryFBGraphObjectsWithObjectType:objectType completeBlock:^(NSArray<WAFBObject *> *objects, NSError *error) {
        if (!error) {
            NSLog(@"===%@", self.scrollView);
            WADemoGiftList* giftList = [[WADemoGiftList alloc]initWithFrame:self.scrollView.bounds];
            giftList.gifts = objects;
            [self.scrollView addSubview:giftList];
            [WADemoMaskLayer stopAnimating];
        }else{
            NSLog(@"error:%@",error);
            [WADemoMaskLayer stopAnimating];
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];

}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
