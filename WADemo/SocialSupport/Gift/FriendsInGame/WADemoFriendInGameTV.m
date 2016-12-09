//
//  GHWFriendInGameTV.m
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoFriendInGameTV.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@implementation WADemoFriendInGameTV
-(instancetype)init{
    self = [super init];
    if (self) {
        [self.rightBtn setTitle:@"Close" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setTitle:@"None" forState:UIControlStateNormal];
        [self.labelInHeaderView setText:[NSString stringWithFormat:@"Friends in Game (%d)",(int)self.friends.count]];
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FriendInGameCell"];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.rightBtn setTitle:@"Close" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setTitle:@"None" forState:UIControlStateNormal];
        [self.labelInHeaderView setText:[NSString stringWithFormat:@"Friends in Game (%d)",(int)self.friends.count]];
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FriendInGameCell"];
    }
    return self;
}

#pragma mark delegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FriendInGameCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendInGameCell"];
    }
    
    
    WAAppUser* friend = self.friends[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:friend.pictureURL]];
    cell.textLabel.text = friend.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark DrawUI
-(void)reloadLabelInHeaderView{
    [self.labelInHeaderView setText:[NSString stringWithFormat:@"Friends in Game (%d)",(int)self.friends.count]];
}

#pragma mark property getting setting
-(void)setFriends:(NSArray *)friends{
    _friends = friends;
    [self reloadLabelInHeaderView];
}
@end
