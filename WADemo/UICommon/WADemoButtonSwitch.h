//
//  GHWButtonSwitch.h
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoButtonMain.h"
typedef enum GHWButtonSwitchState{
    GHWButtonSwitchStateOn = 1,
    GHWButtonSwitchStateOff
}GHWButtonSwitchState;
@interface WADemoButtonSwitch : WADemoButtonMain
@property(nonatomic)GHWButtonSwitchState switchState;
-(instancetype)initWithSwitchState:(GHWButtonSwitchState)switchState;
-(instancetype)initWithFrame:(CGRect)frame switchState:(GHWButtonSwitchState)switchState;
@end
