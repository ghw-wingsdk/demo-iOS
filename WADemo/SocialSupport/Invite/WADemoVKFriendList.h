//
//  WADemoVKFriendList.h
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoListTableView.h"
#import <WASdkIntf/WASdkIntf.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
@interface WADemoVKFriendList : WADemoListTableView<UITableViewDataSource,UIAlertViewDelegate,WAGameRequestDialogDelegate>
@property(nonatomic,copy)NSArray* friends;
@end
