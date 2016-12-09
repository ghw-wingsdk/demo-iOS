//
//  GHWListTV.h
//  TEST
//
//  Created by wuyx on 15/9/9.
//  Copyright (c) 2015年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WADemoFriendListTV : UITableView<UITableViewDataSource,UITableViewDelegate,WAGameRequestDialogDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSArray* friends;
@end
