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
#import <Toast/Toast.h>

@interface WADemoPayView ()

@property (nonatomic, strong) WADemoProductList* productList;

@end

@implementation WADemoPayView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBtnAndLayout];
        [self pay];
    }
    return self;
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
	
	
	
	[WAPayProxy queryChannelProduct:@"APPLE" callBackBlock:^(NSArray<WAChannelProduct *> *channelProductsArray, NSError *error) {
		if (!error) {
			
            self->_productList = [[WADemoProductList alloc]initWithFrame:self.scrollView.bounds];
			self.productList.goToType = GoToTypeWA;
			self.productList.products = Inventory;
			self.productList.channelProducts=channelProductsArray;
			self.productList.naviView = self;
			[self.scrollView addSubview:self.productList];
			
		}else{
			
            self->_productList = [[WADemoProductList alloc]initWithFrame:self.scrollView.bounds];
				self.productList.goToType = GoToTypeWA;
				self.productList.products = Inventory;
				self.productList.channelProducts=channelProductsArray;
				self.productList.naviView = self;
				[self.scrollView addSubview:self.productList];
		}
	}];


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

- (void)deviceOrientationDidChange
{
    [super deviceOrientationDidChange];
    self.productList.frame = self.scrollView.bounds;
    [self.productList deviceOrientationDidChange];
}

@end
