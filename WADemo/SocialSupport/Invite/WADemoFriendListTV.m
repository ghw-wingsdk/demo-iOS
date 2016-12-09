//
//  GHWListTV.m
//  TEST
//
//  Created by wuyx on 15/9/9.
//  Copyright (c) 2015年 GHW. All rights reserved.
//

#import "WADemoFriendListTV.h"
//#import <GHWSdk/GHWSdk.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface WADemoFriendListTV()
@property(nonatomic)float heightForFriendsListCell;
@property(nonatomic)float heightForFriendsListHearder;
@property(nonatomic,strong)UILabel* labelInHeader;
@property(nonatomic,strong)NSMutableArray* friendCells;
@property(nonatomic,strong)NSMutableArray* friendSelected;
@end

@implementation WADemoFriendListTV
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _friendCells = [NSMutableArray array];
        _friends = [NSArray array];
        _friendSelected = [NSMutableArray array];
        
        UIViewController *rootController = [[UIApplication sharedApplication] keyWindow].rootViewController;
        
        _heightForFriendsListCell = 50;
        _heightForFriendsListHearder = 100;
        
        
        float x = 10;
        float y = 80;
        float width = rootController.view.frame.size.width - 2*x;
        float height = 5*_heightForFriendsListCell + _heightForFriendsListHearder;
        
        self.frame = CGRectMake(x, y, width, height);
        //NSLog(@"[x:%f,y:%f,w:%f,h:%f]",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
        self.scrollEnabled = YES;
        self.dataSource = self;
        self.delegate = self;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 2;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LoginOptionCell"];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LoginOptionCell"];
    }
    return self;
}

#pragma mark delegate UITableViewDataSource
-(NSInteger)numberOfSections{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell;
    if ((int)indexPath.row > (int)_friendCells.count-1) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoginOptionCell"];
        [_friendCells addObject:cell];
        
    }else{
        cell = (UITableViewCell*)_friendCells[indexPath.row];
    }
    
    
    WAAppUser* friend = self.friends[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:friend.pictureURL]];
    cell.textLabel.text = friend.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark tableView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, _heightForFriendsListHearder);
    UIView* headerView = [[UIView alloc]initWithFrame:frame];
    headerView.layer.borderWidth = 2;
    headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    frame = CGRectMake(0, 0, tableView.frame.size.width, _heightForFriendsListHearder/2);
    _labelInHeader = [[UILabel alloc]initWithFrame:frame];
    _labelInHeader.text =[NSString stringWithFormat:@"   选择好友(%d个)",(int)_friendSelected.count];
    _labelInHeader.backgroundColor = [UIColor lightGrayColor];
    
    frame.origin.y = _heightForFriendsListHearder/2;
    UIView* btnView = [[UIView alloc]initWithFrame:frame];
    btnView.backgroundColor = [UIColor whiteColor];
    
    [self drawBtnInView:btnView];
    [headerView addSubview:btnView];
    
    [headerView addSubview:_labelInHeader];
    
    return headerView;
}

#pragma mark drawUI
-(void)drawBtnInView:(UIView*)view{
    float space = 5;
    float top = 5;
    float bottom = 5;
    float btnHeight = _heightForFriendsListCell -top -bottom;
    float btnWidth = (view.frame.size.width -3*space)/2;
    
    UIButton* inviteBtn = [[UIButton alloc]init];
    CGRect frame = CGRectMake(space, view.frame.size.height - _heightForFriendsListCell + top, btnWidth, btnHeight);
    inviteBtn.frame = frame;
    [inviteBtn setTitle:@"invite" forState:UIControlStateNormal];
    [inviteBtn setTitle:@"invite" forState:UIControlStateHighlighted];
    [inviteBtn addTarget:self action:@selector(invitableFriends) forControlEvents:UIControlEventTouchUpInside];
    [inviteBtn setShowsTouchWhenHighlighted:YES];
    inviteBtn.backgroundColor = [UIColor lightGrayColor];
    
    UIButton* closeBtn = [[UIButton alloc]init];
    //frame = CGRectMake(space + btnWidth + space, top, btnWidth, btnHeight);
    frame.origin.x = space + btnWidth + space;
    closeBtn.frame = frame;
    [closeBtn setTitle:@"close" forState:UIControlStateNormal];
    [closeBtn setTitle:@"close" forState:UIControlStateHighlighted];
    [closeBtn setShowsTouchWhenHighlighted:YES];
    closeBtn.backgroundColor = [UIColor lightGrayColor];
    [closeBtn addTarget:self action:@selector(removeFromSuperView_) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:inviteBtn];
    [view addSubview:closeBtn];
}


-(void)reloadHearder{
    [_labelInHeader setText:[NSString stringWithFormat:@"选择好友(%d个)",(int)_friendSelected.count]];
}

#pragma mark removeUI
-(void)removeFromSuperView_{
    [self removeFromSuperview];
}

#pragma mark Delegate UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WAAppUser* appUser = _friends[indexPath.row];
    NSLog(@"appUser count :%d",(int)_friends.count);
    NSLog(@"appUser :%p",appUser);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag ==0) {
        cell.backgroundColor = [UIColor colorWithRed:0 green:100 blue:10 alpha:.1];
        cell.tag = 1;
        [_friendSelected addObject:appUser];
    }else{
        cell.backgroundColor = [UIColor clearColor];
        cell.tag = 0;
        [_friendSelected removeObject:appUser];
        
        }
        
    [self reloadHearder];
   
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return _heightForFriendsListHearder;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _heightForFriendsListCell;
}

#pragma mark invite selector
- (void)invitableFriends{
    
    
//    WAGameRequestContent *gameRequestContent = [[WAGameRequestContent alloc] init];
//    gameRequestContent.message = @"Take this bomb to blast your way to victory!!!";
//    gameRequestContent.title = @"Game for you.";
//    //recipients是个数组,可以同时发送给多个好友
//    NSMutableArray* recipients = [NSMutableArray array];
//    for (WAAppUser* appUser in _friendSelected) {
//        [recipients addObject:appUser.ID];
//    }
//
//    gameRequestContent.recipients = recipients;
//    [WASocialProxy gameInviteWithPlatform:WA_PLATFORM_FACEBOOK Content:gameRequestContent delegate:self];
    
    [self inviteFriendBySendRequest];
    
}

-(void)inviteFriendBySendRequest{
    
    //recipients是个数组,可以同时发送给多个好友
    NSMutableArray* recipients = [NSMutableArray array];
    for (WAAppUser* appUser in _friendSelected) {
        [recipients addObject:appUser.ID];
    }
    
    [WASocialProxy sendRequestWithPlatform:WA_PLATFORM_FACEBOOK requestType:WA_REQUEST_TYPE_INVITE title:@"Game for you." message:@"Take this bomb to blast your way to victory!!!" objectId:nil receiptIds:recipients delegate:self];
}

#pragma mark delegate WAGameRequestDialogDelegate
//请求成功
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    
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

////请求成功
//- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
//    //邀请好友成功 发送邀请信息到SDK后台
//    [WASocialProxy createInviteInfoWithPlatform:WA_PLATFORM_FACEBOOK results:results handler:^(NSUInteger code, NSString *msg, NSError *error) {
//        //当code为200时,表示发送成功 进行相应的操作。
//        if (code == 200) {
//            //发送成功
//        }else{
//            //发送失败
//        }
//    }];
//}

//请求失败
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"GHWSDK LOG : didFailWithError : %@",error.description);
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
    [self removeFromSuperView_];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self removeFromSuperView_];
}

@end
