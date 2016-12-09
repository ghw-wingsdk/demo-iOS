//
//  GHWFriendListForSendingAsking.h
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoListTableView.h"
#import <UIKit/UIKit.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WADemoFriendListForSendingAsking : WADemoListTableView<UITableViewDelegate,UITableViewDataSource,WAGameRequestDialogDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSArray* friends;
@property(nonatomic,strong)WAFBObject* gift;
@property(nonatomic)WAGameRequestActionType actionType;
@end
