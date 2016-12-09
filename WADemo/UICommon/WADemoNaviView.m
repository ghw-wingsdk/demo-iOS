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
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        self.btns = btns;
        self.btnLayout = btnLayout;
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
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
    if (!_btnLayout||!_btns) {
        return;
    }
    [self setCurrentFrame];
    
    
    _naviHeight = 44;
    
    _naviBar = [[UIView alloc]init];
    [self addSubview:_naviBar];
    _naviBar.backgroundColor = [UIColor grayColor];
    _titleLable = [[UILabel alloc]init];
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
    _scrollView = [[WADemoScrollView alloc]initWithFrame:CGRectMake(0, _naviHeight, self.bounds.size.width, self.bounds.size.height - _naviHeight) btns:m_btns btnLayout:m_btnLayout];
    
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

#pragma mark layout
-(void)setCurrentFrame{
    float statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    float naviBarH = 0;
    UIViewController* currentView = [WADemoUtil getCurrentVC];
    if (currentView.navigationController) {
        naviBarH = currentView.navigationController.navigationBar.bounds.size.height;
    }
    float screenW = [UIScreen mainScreen].bounds.size.width;
    float screenH = [UIScreen mainScreen].bounds.size.height;
    self.frame =CGRectMake(0, statusBarH + naviBarH, screenW,screenH - statusBarH -naviBarH);
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (!_btns||!_btnLayout) {
        return;
    }
    
    [self setCurrentFrame];
    
    
    float viewW = self.bounds.size.width;
    _naviBar.frame = CGRectMake(0, 0, viewW, _naviHeight);
    _titleLable.frame = _naviBar.bounds;
    
}

-(void)moveIn{
    __block CGRect frame = self.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.frame = frame;
    __weak WADemoNaviView* weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        frame.origin.x = 0;
        weakSelf.frame = frame;
    }];
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}
@end
