//
//  GHWPostEventTextView.m
//  GHWSDKUI
//
//  Created by wuyx on 16/1/28.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import "WADemoPostEventTextView.h"
@interface WADemoPostEventTextView()
@property(nonatomic)float cellW;
@property(nonatomic)float cellH;
@end
@implementation WADemoPostEventTextView
-(instancetype)initWithCellWidth:(float)cellW cellHeight:(float)cellH{
    self = [super init];
    if (self) {
        _cellH = cellH;
        _cellW = cellW;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    float w = 150;
    float h = 30;
    float right = 10;
    float x = _cellW - right - w;
    float y = (_cellH - h)/2;
    self.frame = CGRectMake(x, y, w, h);
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}
@end
