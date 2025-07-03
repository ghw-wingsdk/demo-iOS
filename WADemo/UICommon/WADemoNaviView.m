//
//  GHWNaviView.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoNaviView.h"
#import "WADemoUtil.h"

@interface WADemoNaviView()
@property(nonatomic,strong)UIView* naviBar;
@property(nonatomic,strong)UILabel* titleLable;
@property(nonatomic,strong)UIButton* backBtn;
@end
@implementation WADemoNaviView
@synthesize title = _title;
@synthesize hasBackBtn = _hasBackBtn;
@synthesize btns = _btns;
@synthesize btnLayout = _btnLayout;
@synthesize animated = _animated;
-(instancetype)initWithBtns:(NSMutableArray *)btns btnLayout:(NSMutableArray *)btnLayout{
    self = [super init];
    if (self) {
        self.btns = btns;
        self.btnLayout = btnLayout;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
#pragma mark setter getter
-(void)setTitle:(NSString *)title{
    if (![_title isEqual:title]) {
        _title = title;
        [_titleLable setText:_title];
    }
}

-(NSString *)title{
    return _title;
}

-(void)setHasBackBtn:(BOOL)hasBackBtn{
    if (_hasBackBtn!=hasBackBtn) {
        _hasBackBtn = hasBackBtn;
        [self addBackBtn];
    }
}

-(BOOL)hasBackBtn{
    return _hasBackBtn;
}

-(void)setBtns:(NSMutableArray *)btns{
    if (![_btns isEqualToArray:btns]) {
        _btns = btns;
        [self initUI];
    }
}

-(NSMutableArray *)btns{
    return _btns;
}

-(void)setBtnLayout:(NSMutableArray *)btnLayout{
    if (![_btnLayout isEqualToArray:btnLayout]) {
        _btnLayout = btnLayout;
        [self initUI];
    }
}

-(NSMutableArray *)btnLayout{
    return _btnLayout;
}

-(void)setAnimated:(BOOL)animated{
    if (_animated != animated) {
        _animated = animated;
        [self initUI];
    }
}

-(BOOL)animated{
    return _animated;
}

#pragma mark UI
-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    if (!_btnLayout||!_btns) {
        return;
    }
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat heightStatus = rectStatus.size.width > rectStatus.size.height ? rectStatus.size.height : rectStatus.size.width;
    _naviHeight = 44;
    
    _naviBar = [[UIView alloc]init];
    [self addSubview:_naviBar];
    _naviBar.backgroundColor = [UIColor grayColor];
   // _naviBar.frame = CGRectMake(0, 0, self.frame.size.width, _naviHeight);
    _naviBar.frame = CGRectMake(0, heightStatus, self.frame.size.width, _naviHeight);
    _titleLable = [[UILabel alloc]initWithFrame:_naviBar.bounds];
    [_naviBar addSubview:_titleLable];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.font = [UIFont fontWithName:@"Arial" size:15];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = _title;
    _titleLable.adjustsFontSizeToFitWidth = YES;
    _backBtn = [[UIButton alloc]init];
    [_naviBar addSubview:_backBtn];
    
    NSMutableArray* m_btns = [NSMutableArray arrayWithArray:_btns];
    NSMutableArray* m_btnLayout = [NSMutableArray arrayWithArray:_btnLayout];
    _scrollView = [[WADemoScrollView alloc]initWithFrame:CGRectMake(0, _naviBar.frame.origin.y + _naviBar.frame.size.height,
                                                                    self.bounds.size.width, self.bounds.size.height - _naviHeight)
                                                    btns:m_btns btnLayout:m_btnLayout];
    
    [self addSubview:_scrollView];

}

-(void)addBackBtn{
    if (_hasBackBtn) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setTitle:@"<" forState:UIControlStateNormal];
        [_backBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
        [_backBtn setTintColor:[UIColor whiteColor]];
        _backBtn.adjustsImageWhenDisabled = YES;
        [_naviBar addSubview:_backBtn];
        _backBtn.frame = CGRectMake(0, 0, _naviHeight, _naviHeight);
    }
    
}
#pragma btn action
-(void)removeView{
    
    __block CGRect frame = self.frame;
//    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
//    self.frame = frame;
    __weak WADemoNaviView* weakSelf = self;
    
    [UIView animateWithDuration:.2 animations:^{
        frame.origin.x = [UIScreen mainScreen].bounds.size.width;
        weakSelf.frame = frame;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)deviceOrientationDidChange{
    if (!_btns||!_btnLayout) {
        return;
    }
    
    self.frame = self.superview.bounds;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat heightStatus = rectStatus.size.width > rectStatus.size.height ? rectStatus.size.height : rectStatus.size.width;
    
    _naviBar.frame = CGRectMake(0, heightStatus, self.bounds.size.width, _naviHeight);
    _titleLable.frame = _naviBar.bounds;
    
    _scrollView.frame = CGRectMake(0, _naviBar.frame.origin.y + _naviBar.frame.size.height,
                                   self.bounds.size.width, self.bounds.size.height - _naviHeight);
    [_scrollView deviceOrientationDidChange];
}

-(void)moveIn:(void (^)(void))finishedBlock{
    __block CGRect frame = self.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.frame = frame;
    __weak WADemoNaviView* weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        frame.origin.x = 0;
        weakSelf.frame = frame;
        if (finishedBlock) {
            finishedBlock();
        }
    }];
}

@end
