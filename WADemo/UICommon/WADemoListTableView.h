//
//  GHWListTableView.h
//  test
//
//  Created by Wuyixin on 15/9/9.
//  Copyright (c) 2015年 Game Hollywood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WADemoListTableView : UITableView<UITableViewDelegate>
@property(nonatomic)float heightForContentView;//内容列表的高度
@property(nonatomic)float heightForHearder;//表头高度

@property(nonatomic)float left;//左边距
@property(nonatomic)float top;//右边距
@property(nonatomic,strong)UIColor* subjectColor;//主题颜色
@property(nonatomic,strong)UIButton* leftBtn;//左边键
@property(nonatomic,strong)UIButton* rightBtn;//右边键
@property(nonatomic,strong)UILabel* labelInHeaderView;//表头label
@property(nonatomic,strong)UIView* headerView;//表头视图
@property(nonatomic,strong)UIView* footerView;
@property(nonatomic,strong)UIButton* bottomBtn;

- (void)deviceOrientationDidChange;
-(void)close;
@end
