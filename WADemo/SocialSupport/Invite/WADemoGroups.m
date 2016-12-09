//
//  WADemoGroups.m
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoGroups.h"
#import "WADemoUtil.h"
#import "WADemoGroupCell.h"
@interface WADemoGroups()
@property(nonatomic,strong)NSMutableArray* groupViews;
@end
@implementation WADemoGroups
@synthesize groups = _groups;
-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    NSMutableArray* btnLayout = [NSMutableArray array];
    self.title = @"VK Groups";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

-(void)initGroups{
    _groupViews = [NSMutableArray array];
    [_groups enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WAGroup* group = obj;
        WADemoGroupCell* cell = [[WADemoGroupCell alloc]init];
        [self.scrollView addSubview:cell];
        cell.group = group;
        [self.groupViews addObject:cell];
    }];
}

-(void)setGroups:(NSArray *)groups{
    if (_groups != groups) {
        _groups = groups;
        [self initGroups];
        [self layoutSubviews];
    }
}





-(void)layoutSubviews{
    [super layoutSubviews];
    float viewW = self.frame.size.width;
    float space = 0;
    float cell_h = 100;
    float cell_w = viewW - 2*space;
    float cell_x = 0;
    float cell_y = 25;
    [_groupViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WADemoGroupCell* cell = obj;
        cell.frame = CGRectMake(cell_x, cell_y + idx*(cell_h + space), cell_w, cell_h);
    }];
    
    
}

@end
