//
//  GHWBindingAccountList.h
//  GHWSdkUI
//
//  Created by wuyx on 15/12/1.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoListTableView.h"

@interface WADemoBindingAccountList : WADemoListTableView<UITableViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)NSArray* accounts;
@end
