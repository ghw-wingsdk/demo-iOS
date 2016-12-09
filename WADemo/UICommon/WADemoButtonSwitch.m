//
//  GHWButtonSwitch.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoButtonSwitch.h"
@interface WADemoButtonSwitch()
@end
@implementation WADemoButtonSwitch
-(instancetype)init{
    self = [super init];
    if (self) {
        self.switchState = GHWButtonSwitchStateOff;
    }
    return self;
}

-(instancetype)initWithSwitchState:(GHWButtonSwitchState)switchState{
    self = [super init];
    if (self) {
        self.switchState = switchState;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame switchState:(GHWButtonSwitchState)switchState{
    self = [super initWithFrame:frame];
    if (self) {
        self.switchState = switchState;
    }
    return self;
}

@end
