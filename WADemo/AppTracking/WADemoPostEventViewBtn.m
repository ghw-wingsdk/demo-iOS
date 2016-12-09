//
//  GHWPostEventViewBtn.m
//  GHWSDKUI
//
//  Created by wuyx on 16/1/27.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import "WADemoPostEventViewBtn.h"

@implementation WADemoPostEventViewBtn
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }
    return self;
}
@end
