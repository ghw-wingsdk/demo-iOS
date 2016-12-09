//
//  WADemoCell.h
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WADemoButtonMain.h"
#import <WASdkIntf/WASdkIntf.h>
#import <SafariServices/SafariServices.h>
@interface WADemoGroupCell : UIView<SFSafariViewControllerDelegate>
@property(nonatomic,strong)WAGroup* group;
@property(nonatomic,strong)UIImageView* groupImg;
@property(nonatomic,strong)UILabel* groupName;
@property(nonatomic,strong)WADemoButtonMain* joinBtn;
@end
