//
//  GHWGiftListTVC.h
//  GHWSdkUI
//
//  Created by wuyx on 15/7/16.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WADemoGiftListTVC : UITableViewController<WAGameRequestDialogDelegate>
@property(nonatomic,strong)NSArray* gifts;
@end
