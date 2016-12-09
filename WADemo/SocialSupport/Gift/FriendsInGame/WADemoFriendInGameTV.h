//
//  GHWFriendInGameTV.h
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoListTableView.h"
#import <WASdkIntf/WASdkIntf.h>
@interface WADemoFriendInGameTV : WADemoListTableView<UITableViewDataSource>
@property(nonatomic,strong)NSArray* friends;
@end
