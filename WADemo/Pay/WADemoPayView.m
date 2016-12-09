//
//  WADemoPayView.m
//  WADemo
//
//  Created by hank on 16/4/27.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoPayView.h"
#import "WADemoMaskLayer.h"
#import "WADemoProductList.h"
#import "WADemoUtil.h"
#import "WADemoAlertView.h"

@implementation WADemoPayView

-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
        [self pay];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    
    NSMutableArray* btnLayout = [NSMutableArray array];
    self.title = @"支付";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)pay{
    [WADemoMaskLayer startAnimating];
//    [WAPayProxy queryInventoryWithPlatform:WA_PLATFORM_WINGA delegate:self];
    [WAPayProxy queryInventoryWithDelegate:self];
}

-(void)queryInventoryDidCompleteWithResult:(NSArray<WAIapProduct *> *)Inventory{
    [WADemoMaskLayer stopAnimating];
    for (WAIapProduct *iapProdict in Inventory)
    {
        iapProdict.localizedTitle = iapProdict.productIdentifier;
        iapProdict.localizedDescription = iapProdict.productIdentifier;
    }
    
    WADemoProductList* productList = [[WADemoProductList alloc]initWithFrame:self.scrollView.bounds];
    productList.goToType = GoToTypeWA;
    productList.products = Inventory;
    [self.scrollView addSubview:productList];
}

-(void)queryInventoryDidFailWithError:(NSError*)error{
    [WADemoMaskLayer stopAnimating];
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"查询支付发方式失败: error:%@", error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
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
