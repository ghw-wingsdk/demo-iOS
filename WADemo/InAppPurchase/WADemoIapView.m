//
//  GHWProductList.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoIapView.h"
#import "WADemoMaskLayer.h"
#import "WADemoProductList.h"
#import "WADemoUtil.h"
#import "WADemoAlertView.h"

@implementation WADemoIapView

-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
        [self iap];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    
    NSMutableArray* btnLayout = [NSMutableArray array];
    self.title = @"应用内支付";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)iap{
    [WADemoMaskLayer startAnimating];
//    [WAPayProxy queryInventoryWithPlatform:WA_PLATFORM_APPLE delegate:self];
}

-(void)queryInventoryDidCompleteWithResult:(NSArray<WAIapProduct *> *)Inventory{
    [WADemoMaskLayer stopAnimating];
    WADemoProductList* productList = [[WADemoProductList alloc]initWithFrame:self.scrollView.bounds];
    productList.products = Inventory;
    [self.scrollView addSubview:productList];
}

-(void)queryInventoryDidFailWithError:(NSError*)error{
    [WADemoMaskLayer stopAnimating];
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"查询商品列表失败: error:%@", error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}


-(void)removeView{
    [super removeView];
    [WADemoMaskLayer stopAnimating];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
