//
//  GHWMainScrollView.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/23.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoScrollView.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"

@interface WADemoScrollView()
@end
@implementation WADemoScrollView
//@synthesize naviHeight = _naviHeight;
@synthesize btns = _btns;
@synthesize btnLayout = _btnLayout;


#pragma mark setter getter


-(void)setBtns:(NSMutableArray *)btns{
    if (![_btns isEqualToArray:btns]) {
        _btns = btns;
        [self layoutSubviews];
    }
}

-(NSMutableArray *)btns{
    return _btns;
}

-(void)setBtnLayout:(NSMutableArray *)btnLayout{
    if (![_btnLayout isEqualToArray:btnLayout]) {
        _btnLayout = btnLayout;
        [self layoutSubviews];
    }
}

-(NSMutableArray *)btnLayout{
    return _btnLayout;
}

#pragma mark instancetype

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame btns:(NSMutableArray*)btns btnLayout:(NSMutableArray*)btnLayout naviHeight:(float)naviHeight{
    self = [super initWithFrame:frame];
    if (self) {
//        self.naviHeight = naviHeight;
        self.backgroundColor = [UIColor whiteColor];
        self.btnLayout = btnLayout;
        self.btns = btns;
        [self initUI];
        self.scrollEnabled = YES;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame btns:(NSMutableArray*)btns btnLayout:(NSMutableArray*)btnLayout{
    self = [self initWithFrame:frame btns:btns btnLayout:btnLayout naviHeight:0];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.btnLayout = btnLayout;
        self.btns = btns;
        [self initUI];
        self.scrollEnabled = YES;
    }
    return self;
}



-(void)initUI{
    
    _left = 10;
    _right = 10;
    _top = 40;
    _bottom = 40;
    _mid_space_h = 10;
    _mid_space_v = 10;
    _btnHeight = 40;
    
    __weak WADemoScrollView* weakSelf = self;
    [_btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf addSubview:obj];
    }];
    
    [self deviceOrientationDidChange];
}


#pragma mark Layout

-(void)deviceOrientationDidChange
{
    if (!_btnLayout||!_btns) {
        return;
    }
    
//    CGRect frame = self.frame;
//    frame.size.width = self.superview.bounds.size.width;
//    frame.size.height = self.superview.bounds.size.height;
//    self.frame = frame;
    __block int btnIndex = 0;
    __block NSUInteger line;
    [_btnLayout enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        line = idx + 1;//当前行
        NSNumber* numOfBtn = obj;//当前行的按钮个数

        float btn_h = _btnHeight;//高度一样
        float viewW = self.bounds.size.width;
        for (int i = 1; i < numOfBtn.intValue + 1; i++) {
            float btn_w = (viewW - _left - _right - (numOfBtn.intValue - 1)* _mid_space_h)/numOfBtn.intValue;
            float btn_x = _left + (btn_w + _mid_space_h)*(i - 1);
            float btn_y = _top + (btn_h + _mid_space_v)*(line - 1);
            if (btnIndex < _btns.count) {
                WADemoButtonMain* btn = _btns[btnIndex];
                [btn setFrame:CGRectMake(btn_x, btn_y, btn_w, btn_h)];
                btnIndex++;
            }else{
                *stop = YES;
                break;
            }
            
        }
    }];
    
    float contentHeight = _top + line*(_btnHeight + _mid_space_v)+ _btnHeight + _bottom;
    if (contentHeight < self.bounds.size.height) {
        contentHeight = self.bounds.size.height;
    }
    self.contentSize = CGSizeMake(self.bounds.size.width, contentHeight);
    
}

@end
