//
//  GHWPostEventView.h
//  GHWSDKUI
//
//  Created by wuyx on 16/1/27.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <GHWSDK/GHWSDK.h>
#import "WADemoEventData.h"
@interface WADemoPostEventView : UIView
@property(nonatomic,strong)WADemoEventData* defParam;
@property(nonatomic,strong)WADemoEventData* afParam;
@property(nonatomic,strong)WADemoEventData* fbParam;
@property(nonatomic,strong)WADemoEventData* cbParam;
@property(nonatomic,strong)WADemoEventData* ghwParam;
@property(nonatomic,strong)WADemoEventData* firebaseParam;


@property(nonatomic,copy)NSString* eventName;
-(instancetype)initWithViewControllerView:(UIViewController*)viewController eventName:(NSString*)eventName;
-(instancetype)initWithNaviHeight:(float)naviHeight eventName:(NSString*)eventName;
- (void)deviceOrientationDidChange;
@end
