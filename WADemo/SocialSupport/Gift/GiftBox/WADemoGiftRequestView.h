//
//  GHWGiftRequestView.h
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoListTableView.h"
#import <WASdkIntf/WASdkIntf.h>
#import "WADemoGiftBoxTV.h"

@interface WADemoGiftRequestView : WADemoListTableView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic)WADemoFBActionType actionType;
@property(nonatomic,strong)WAFBAppRequest* request;
@property(nonatomic,weak)WADemoGiftBoxTV* giftBox;
@end
