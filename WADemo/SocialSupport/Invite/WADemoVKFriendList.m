//
//  WADemoVKFriendList.m
//  WADemo
//
//  Created by wuyx on 16/7/11.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoVKFriendList.h"
@interface WADemoVKFriendList()
@property(nonatomic,copy)WAAppUser* appUser;
@end
@implementation WADemoVKFriendList

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"VKFriendListCell"];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark DrawUI
-(void)initUI{
    [self.labelInHeaderView setText:@"Binded Account List"];
    [self.leftBtn setTitle:@"Close" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"Invite" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)close{
    [super close];
}

-(void)invite{
//    if (_appUser) {
//        WAGameRequestContent *gameRequestContent = [[WAGameRequestContent alloc] init];
//        gameRequestContent.message = @"Invite friend";
//        gameRequestContent.title = @"Game for you.";
//        gameRequestContent.actionType = WAGameRequestActionRequest;
//        //recipients是个数组,可以同时发送给多个好友
//        NSMutableArray* recipients = [NSMutableArray array];
//        [recipients addObject:_appUser.ID];
//        
//        gameRequestContent.recipients = recipients;
//        [WASocialProxy gameInviteWithPlatform:WA_PLATFORM_VK Content:gameRequestContent delegate:self];
//        
//    }
    [self inviteBySendRequest];
}


-(void)inviteBySendRequest{
    if (_appUser) {
        [WASocialProxy sendRequestWithPlatform:WA_PLATFORM_VK requestType:WA_REQUEST_TYPE_REQUEST title:@"Game for you." message:@"Invite friend" objectId:nil receiptIds:@[_appUser.ID] delegate:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friends.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"VKFriendListCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VKFriendListCell"];
    }
    
    
    WAAppUser* friend = self.friends[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:friend.pictureURL]];
    cell.textLabel.text = friend.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _appUser = _friends[indexPath.row];;
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
}




//请求成功
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    //邀请好友成功 发送邀请信息到SDK后台

    NSLog(@"WASDK LOG :platform:%@ didCompleteWithResults : %@",platform,results);
    NSString* content = [NSString stringWithFormat:@"success platform :%@didCompleteWithResults :%@",platform,results];
    [self alertWithContent:content andTitle:@"Success"];
    
    //邀请好友成功 发送邀请信息到SDK后台
    if ([platform isEqualToString:WA_PLATFORM_FACEBOOK]||[platform isEqualToString:WA_PLATFORM_VK]) {
        
        [WASocialProxy createInviteInfoWithPlatform:platform results:results handler:^(NSUInteger code, NSString *msg, NSError *error) {
            //当code为200时,表示发送成功 进行相应的操作。
            if (code == 200) {
                
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"发送邀请信息到SDK后台成功 msg:%@",msg] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"发送邀请信息到SDK后台失败 error:%@",error] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }
    
}

//请求失败
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"WASDK LOG : didFailWithError : %@",error.description);
    NSString* content = [NSString stringWithFormat:@"gameRequestDialog didFailWithError :%@",error.description];
    [self alertWithContent:content andTitle:@"Fail"];
}

//请求取消
- (void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform{
    [self alertWithContent:@"Did cancel" andTitle:@"Cancel"];
    NSLog(@"gameRequestDialogDidCancel");
}


-(void)alertWithContent:(NSString*)content andTitle:(NSString*)title{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    [alert show];
}

#pragma mark UIAlertViewDelegate
-(void)alertViewCancel:(UIAlertView *)alertView{
    [self removeFromSuperview];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self removeFromSuperview];
}

@end
