//
//  GHWProductList.h
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WASdkIntf/WASdkIntf.h>
typedef NS_ENUM(NSInteger, GoToType) {
    GoToTypeApple,
    GoToTypeWA,
};

@interface WADemoProductList : UITableView<UITableViewDataSource,WAPaymentDelegate>
@property (nonatomic, assign) GoToType goToType;
@property(strong,nonatomic)NSArray* products;
@end
