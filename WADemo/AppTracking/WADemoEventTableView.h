//
//  GHWEventTableView.h
//  GHWSDKUI
//
//  Created by wuyx on 16/1/27.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WADemoPostEventView.h"
#import "WADemoEventParam.h"
#import "WADemoEventData.h"
typedef enum GHWEventTableViewChannel{
    GHWEventTableViewChannelAF = 1,
    GHWEventTableViewChannelFB,
    GHWEventTableViewChannelCB,
    GHWEventTableViewChannelGHW,
    GHWEventTableViewChannelDEF,
	GHWEventTableViewChannelFIREBASE

}GHWEventTableViewChannel;
@interface WADemoEventTableView : UITableView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame channel:(GHWEventTableViewChannel)channel param:(WADemoEventData*)param;
//@property(nonatomic,strong)GHWEventParam* param;
@property(nonatomic,strong)WADemoEventData* param;
@property(nonatomic,weak)WADemoPostEventView* eventView;
@end
