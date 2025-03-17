//
//  GHWProductList.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoProductList.h"
#import "WADemoUtil.h"
#import <Toast/Toast.h>
static NSString* productCellIdentifier = @"ProductCellIdentifier";
@interface WADemoProductList()
@property(nonatomic)float naviheight;

@end
@implementation WADemoProductList

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.naviheight = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:productCellIdentifier];
        self.dataSource = self;
		self.delegate=self;
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
									  reuseIdentifier: productCellIdentifier];
	}
	

    
    float width = 70;
    float height = cell.frame.size.height - 10;
    //float space = 10;
    float x = 0;
    float y = 0;
    
    UIButton* buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [buyBtn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
    [buyBtn setTitle:@"buy" forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[UIColor lightGrayColor]];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setShowsTouchWhenHighlighted:YES];
    [buyBtn setTag:indexPath.row];
    [buyBtn addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView* btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,width, height)];
    btnView.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:buyBtn];
    
    cell.accessoryView = btnView;
    
    WAIapProduct* product = self.products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
	
	WAChannelProduct* channelProduct= [self getChannelProduct:product.productIdentifier];
	
	if (channelProduct) {
		if ([channelProduct.localeCurrencyCode length]!=0) {
			cell.detailTextLabel.text=[NSString stringWithFormat:@"(%@)  %@",channelProduct.localeCurrencyCode,channelProduct.localFormattedPrice];

		}
		
//		localeCurrencyCode

	}
    
    return cell;
}


- (WAChannelProduct*)getChannelProduct:(NSString*)pid
{
	WAChannelProduct * channelPro=nil;
	for (WAChannelProduct * channelProduct in self.channelProducts) {
		if ([channelProduct.productIdentifier isEqualToString:pid]) {
			channelPro=channelProduct;
		}
	}
	
	
	return channelPro;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    return 70;
}


-(void)buy:(UIButton*)btn{
    WAIapProduct* product = self.products[btn.tag];
    if (product) {
//        if (_goToType == GoToTypeApple)
//            [WAPayProxy payWithProductId:product.productIdentifier platform:WA_PLATFORM_APPLE extInfo:nil delegate:self];
//        if (_goToType == GoToTypeWA)
        [WAPayProxy payWithProductId:product.productIdentifier extInfo:nil delegate:self];
    }
}

-(void)deviceOrientationDidChange{
    
}

#pragma mark 实现 WAPaymentDelegate
-(void)paymentDidCompleteWithResult:(WAIapResult*)iapResult andPlatform:(NSString*)platform{
    NSString* msg = @"";
    if (!iapResult) {
        msg = [NSString stringWithFormat:@"%@ 购买失败！",platform];
        NSLog(@"%@ 购买失败!", platform);
    }else{
        if (iapResult.resultCode == 1) {
            msg = [NSString stringWithFormat:@"%@ 支付成功。",platform];
            NSLog(@"%@ 支付成功.", platform);
        }else if (iapResult.resultCode == 2) {
            msg = [NSString stringWithFormat:@"%@ 支付失败。",platform];
            NSLog(@"%@ 支付失败.", platform);
        }else if (iapResult.resultCode == 3) {
            msg = [NSString stringWithFormat:@"%@ 支付取消。",platform];
            NSLog(@"%@ 支付取消.", platform);
        }else if (iapResult.resultCode == 4) {
            msg = [NSString stringWithFormat:@"%@ 支付上报失败。",platform];
            NSLog(@"%@ 支付上报失败.", platform);
        }else if (iapResult.resultCode == 5) {
            msg = [NSString stringWithFormat:@"%@ 支付商品未消耗。",platform];
            NSLog(@"%@ 支付商品未消耗.", platform);
        }else if (iapResult.resultCode == 6) {
            msg = [NSString stringWithFormat:@"%@ 创建订单失败。",platform];
            NSLog(@"%@ 创建订单失败.", platform);
        }
    }
    [self.naviView makeToast:msg];
}
-(void)paymentDidFailWithError:(NSError*)error andPlatform:(NSString*)platform{
    if (error) {
        NSLog(@"paymentDidFailWithError:%@",error.description);
        [self.naviView makeToast:error.description];

    }
}

@end
