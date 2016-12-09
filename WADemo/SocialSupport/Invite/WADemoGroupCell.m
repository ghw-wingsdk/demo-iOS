//
//  WADemoCell.m
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <SafariServices/SafariServices.h>
#import "WADemoGroupCell.h"
#import "WADemoUtil.h"
@interface WADemoGroupCell()

@end
@implementation WADemoGroupCell
@synthesize group = _group;
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _groupImg = [[UIImageView alloc]init];
        [self addSubview:_groupImg];
        _groupName = [[UILabel alloc]init];
        [self addSubview:_groupName];
        _groupName.adjustsFontSizeToFitWidth = YES;
        [_groupName setFont:[UIFont fontWithName:@"Arial" size:15]];
        _joinBtn = [[WADemoButtonMain alloc]init];
        [_joinBtn addTarget:self action:@selector(openOrJoin) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_joinBtn];
    }
    return self;
}

+(void)getGroup{
    [WASocialProxy getGroupWithPlatform:WA_PLATFORM_VK groupIds:@[@"groupid1",@"groupid2"] extInfo:nil completeBlock:^(NSArray *groups, NSError *error) {
        if (!error) {
            //查询成功
        }else{
            //查询失败
        }
    }];
}

-(void)setGroup:(WAGroup *)group{
    if (group != _group) {
        _group = group;
        [_groupName setText:_group.name];
        [_groupImg setImageWithURL:[NSURL URLWithString:_group.photo_medium]];
        
        if (_group.is_member) {
            [_joinBtn setTitle:@"Open" forState:UIControlStateNormal];
            
        }else{
            [_joinBtn setTitle:@"Join" forState:UIControlStateNormal];
        }
        
        
        [self setNeedsDisplay];
    }
}

-(void)openOrJoin{
    if (_group.is_member) {
        [WASocialProxy openGroupPageWithPlatform:WA_PLATFORM_VK groupUri:_group.screen_name extInfo:nil];
    }else{
        [WASocialProxy joinGroupWithPlatform:WA_PLATFORM_VK groupId:_group.gid extInfo:nil completeBlock:^(NSError *error) {
            NSString* message;
            if (error) {
                message = [NSString stringWithFormat:@"join VK group error : %@",error.description];
            }else{
                message = @"Succeed to join Group.";
                _group.is_member = YES;
                [_joinBtn setTitle:@"Open" forState:UIControlStateNormal];
            }
            
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:message delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
            [alert show];
            
        }];
    }
    
}

-(void)joinGroup{
    [WASocialProxy joinGroupWithPlatform:WA_PLATFORM_VK groupId:@"GroupId" extInfo:nil completeBlock:^(NSError *error) {
        if (!error) {
            //join Group 成功
        }else{
            //join Group 失败
        }
    }];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    float viewH = self.frame.size.height;
    float viewW = self.frame.size.width;
    float space = 5;
    float img_x = space;
    float img_y = space;
    float img_w = viewH - 2*space;
    float img_h = img_w;
    _groupImg.frame = CGRectMake(img_x, img_y, img_w, img_h);
    
    float lab_x = img_x + img_w + space;
    float lab_y = space;
    float lab_h = 3*(viewH - 3*space)/5;
    float lab_w = viewW - 3*space - img_w;
    _groupName.frame = CGRectMake(lab_x, lab_y, lab_w, lab_h);
    
    float btn_x = lab_x;
    float btn_y = lab_y + lab_h + space;
    float btn_w = lab_w/2;
    float btn_h = 2*(viewH - 3*space)/5;
    _joinBtn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
    
}


@end
