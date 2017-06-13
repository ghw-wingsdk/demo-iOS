//
//  GHWListTV.m
//  TEST
//
//  Created by wuyx on 15/9/9.
//  Copyright (c) 2015年 GHW. All rights reserved.
//

#import "WADemoListTableView.h"

@interface WADemoListTableView()
@property(nonatomic,strong)UIView* btnView;
@property(nonatomic)float heightForFooter;
@end

@implementation WADemoListTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        _heightForContentView = frame.size.height;
        _heightForContentView = 250;
        _heightForHearder = 100;
        _heightForFooter = 60;
        
        _left = 0;
//        _top = 44;
        _top = 80;
        float width = frame.size.width - 2*_left;
        float height = _heightForContentView + _heightForHearder + _heightForFooter;
        
        self.frame = CGRectMake(_left, _top, width, height);
        self.scrollEnabled = YES;
        self.subjectColor = [UIColor lightGrayColor];
        self.layer.borderWidth = 2;
        
        self.delegate =self;
//        self.tableHeaderView = [self fateHeaderViewWithTableView:self];
//        self.tableFooterView = [self fatefooterViewWithTableView:self];
        self.tableHeaderView = [self headerViewWithTableView:self];
        self.tableFooterView = [self footerViewWithTableView:self];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIViewController *rootController = [[UIApplication sharedApplication] keyWindow].rootViewController;
        
        _heightForContentView = 250;
        _heightForHearder = 100;
        _heightForFooter = 60;

        _left = 0;
        _top = 80;
        float width = rootController.view.frame.size.width - 2*_left;
        float height = _heightForContentView + _heightForHearder + _heightForFooter;
        
        self.frame = CGRectMake(_left, _top, width, height);
        self.scrollEnabled = YES;
        self.subjectColor = [UIColor lightGrayColor];
        self.layer.borderWidth = 2;
        
        self.delegate =self;
//        self.tableHeaderView = [self fateHeaderViewWithTableView:self];
//        self.tableFooterView = [self fatefooterViewWithTableView:self];
        self.tableHeaderView = [self headerViewWithTableView:self];
        self.tableFooterView = [self footerViewWithTableView:self];
    }
    return self;
}

//-(UIView*)fateHeaderViewWithTableView:(UITableView*)tableView{
//    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, _heightForHearder);
//    UIView* fhv = [[UIView alloc]initWithFrame:frame];
//    return fhv;
//}
//
//-(UIView*)fatefooterViewWithTableView:(UITableView*)tableView{
//    CGRect frame = CGRectMake(0, tableView.frame.size.height - _heightForFooter, tableView.frame.size.width, _heightForFooter);
//    UIView* fhv = [[UIView alloc]initWithFrame:frame];
//    return fhv;
//}

-(void)setTableViewFrame{
    UIViewController *rootController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    float width = rootController.view.frame.size.width - 2*_left;
    float height = _heightForContentView + _heightForHearder + _heightForFooter;
    
    if (height > self.superview.frame.size.height - _top)
        height = self.superview.frame.size.height - _top;
        
    self.frame = CGRectMake(_left, _top, width, height);
}


//-(void)setHeightForHearder:(float)heightForHearder{
//    _heightForHearder = heightForHearder;
//    [self setTableViewFrame];
//    [self headerViewWithTableView:self];
//    self.tableHeaderView = [self fateHeaderViewWithTableView:self];
//    self.tableHeaderView = [self fatefooterViewWithTableView:self];
//}

-(void)setHeightForContentView:(float)heightForCell{
    _heightForContentView = heightForCell;
    [self setTableViewFrame];
}

-(void)setHeightForFooter:(float)heightForFooter{
    _heightForFooter = heightForFooter;
    [self setTableViewFrame];
    [self footerViewWithTableView:self];
}

-(void)setTop:(float)top{
    _top = top;
    [self setTableViewFrame];
}

-(void)setLeft:(float)left{
    _left = left;
    [self setTableViewFrame];
    self.tableHeaderView = [self headerViewWithTableView:self];
}


-(void)setSubjectColor:(UIColor *)subjectColor{
    _subjectColor = subjectColor;
    self.layer.borderColor = _subjectColor.CGColor;
    _rightBtn.backgroundColor = _subjectColor;
    _leftBtn.backgroundColor = _subjectColor;
    _bottomBtn.backgroundColor = _subjectColor;
    _labelInHeaderView.backgroundColor = _subjectColor;
    _headerView.layer.borderColor = _subjectColor.CGColor;
}


- (UIView *)headerViewWithTableView:(UITableView *)tableView{
    
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, _heightForHearder);
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
    }

    _headerView.frame = frame;
    _headerView.layer.borderWidth = 2;
    _headerView.layer.borderColor = _subjectColor.CGColor;
    
    frame = CGRectMake(0, 0, tableView.frame.size.width, _heightForHearder/2);
    if (!_labelInHeaderView) {
        _labelInHeaderView = [[UILabel alloc]init];
        _labelInHeaderView.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_labelInHeaderView];
    }
    _labelInHeaderView.frame = frame;
    _labelInHeaderView.backgroundColor = _subjectColor;
    
    frame.origin.y = _heightForHearder/2;
    if (!_btnView) {
        _btnView = [[UIView alloc]init];
        [_headerView addSubview:_btnView];
    }
    _btnView.frame = frame;
    _btnView.backgroundColor = [UIColor whiteColor];
    
    [self drawBtnInView:_btnView];
//    [self addSubview:_headerView];
    return _headerView;
}


-(UIView*)footerViewWithTableView:(UITableView *)tableView{
    float space = 0;
    float btnHeight = _heightForFooter - 2*space;
    float btnWidth = tableView.frame.size.width - 2*space;
    float ftvHeight = btnHeight + 2*space;
//    CGRect frame = CGRectMake(0, tableView.frame.size.height - ftvHeight, tableView.frame.size.width, ftvHeight);
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, ftvHeight);
    if (!_footerView) {
        _footerView = [[UIView alloc]init];
    }

    _footerView.frame = frame;
    
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc]init];
        [_footerView addSubview:_bottomBtn];
    }
    
    _bottomBtn.backgroundColor = self.subjectColor;
    frame = CGRectMake(space, space, btnWidth, btnHeight);
    _bottomBtn.frame = frame;
    
//    [self addSubview:_footerView];
    return _footerView;
}


-(void)drawBtnInView:(UIView*)view{
    float space = 5;
    float top = 5;
    float bottom = 5;
    float btnHeight = view.frame.size.height -top -bottom;
    float btnWidth = (view.frame.size.width -3*space)/2;
    
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
        [view addSubview:_leftBtn];
    }
    
    CGRect frame = CGRectMake(space, top, btnWidth, btnHeight);
    _leftBtn.frame = frame;
    [_leftBtn setShowsTouchWhenHighlighted:YES];
    _leftBtn.backgroundColor = _subjectColor;
    
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
        [view addSubview:_rightBtn];
    }
    
    frame.origin.x = space + btnWidth + space;
    _rightBtn.frame = frame;
    [_rightBtn setShowsTouchWhenHighlighted:YES];
    _rightBtn.backgroundColor = _subjectColor;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGRect frame = self.headerView.frame;
//    frame.origin.y = scrollView.contentOffset.y;
//    self.headerView.frame = frame;
//    
//    frame = self.footerView.frame;
//    frame.origin.y = self.frame.size.height + scrollView.contentOffset.y - _footerView.frame.size.height;
//    self.footerView.frame = frame;
}

- (void)deviceOrientationDidChange
{
    [self setTableViewFrame];
    self.tableHeaderView = [self headerViewWithTableView:self];
    self.tableFooterView = [self footerViewWithTableView:self];
    
//    // header
//    CGRect frame = CGRectMake(0, 0, self.frame.size.width, _heightForHearder);
//    _headerView.frame = frame;
//    _labelInHeaderView.frame = frame;
//    frame.origin.y = _heightForHearder/2;
//    _btnView.frame = frame;
//    
//    [self drawBtnInView:_btnView];
//    
//    // footer
//    float space = 0;
//    float btnHeight = _heightForFooter - 2*space;
//    float btnWidth = self.frame.size.width - 2*space;
//    float ftvHeight = btnHeight + 2*space;
//    frame = CGRectMake(0, self.frame.size.height - ftvHeight, self.frame.size.width, ftvHeight);
//    _footerView.frame = frame;
//    frame = CGRectMake(space, space, btnWidth, btnHeight);
//    _bottomBtn.frame = frame;
}

-(void)close{
    [self removeFromSuperview];
}

@end
