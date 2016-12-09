//
//  GHWFriendListForSendingAsking.m
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoFriendListForSendingAsking.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@interface WADemoFriendListForSendingAsking()
@property(nonatomic,strong)NSMutableArray* friendCells;
@property(nonatomic,strong)NSMutableArray* friendSelected;
@end
@implementation WADemoFriendListForSendingAsking

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        _friendCells = [NSMutableArray array];
        _friendSelected = [NSMutableArray array];
        
        [self initUI];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        _friendCells = [NSMutableArray array];
        _friendSelected = [NSMutableArray array];
        
        [self initUI];
    }
    return self;
}
#pragma mark DrawUI
-(void)initUI{
    self.labelInHeaderView.text =[NSString stringWithFormat:@"Friends List(%d selected)",(int)self.friendSelected.count] ;
    [self.labelInHeaderView setTextColor:[UIColor whiteColor]];
    [self.leftBtn setTitle:@"Send" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(sendGift) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"Close" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

-(void)reloadHeaderLabel{
    self.labelInHeaderView.text =[NSString stringWithFormat:@"Friends List(%d selected)",(int)self.friendSelected.count] ;
}

-(void)close{
    [self removeFromSuperview];
}

#pragma mark selector action
-(void)sendGift{
    if (!_friendSelected.count) {
        [self alertWithTitle:@"tip" andContent:@"请选择好友" andTag:10];
        return;
    }
    
    NSMutableArray* recipients = [NSMutableArray array];
    
    for (WAAppUser* appUser in _friendSelected) {
        [recipients addObject:appUser.ID];
    }
    
    if (_gift&&recipients.count) {
//        WAGameRequestContent *gameRequestContent = [[WAGameRequestContent alloc] init];
//        gameRequestContent.message = @"send a gift to you!";
//        gameRequestContent.title = [NSString stringWithFormat:@"This is %@",_gift.title];
//        //设置赠送的好友
//        gameRequestContent.recipients = recipients;//数组存放WAAppUser的ID
//        //设置赠送的礼物id
//        gameRequestContent.objectID = _gift.ID;//WAFBObject的ID
//        //actionType设置为WAGameRequestActionTypeSend 赠送
//        gameRequestContent.actionType =WAGameRequestActionTypeSend;
//        [WASocialProxy fbSendGiftWithContent:gameRequestContent delegate:self];
        
        [self sendRequest:1 message:@"send a gift to you!" title:[NSString stringWithFormat:@"This is %@",_gift.title] objectId:_gift.ID receiptIds:recipients];
    }
}
//
-(void)askForGift{
    if (!_friendSelected.count) {
        [self alertWithTitle:@"tip" andContent:@"请选择好友" andTag:10];
        return;
    }
    
    NSMutableArray* recipients = [NSMutableArray array];
    
    for (WAAppUser* appUser in _friendSelected) {
        [recipients addObject:appUser.ID];
    }
    
    if (_gift) {
//        WAGameRequestContent *gameRequestContent = [[WAGameRequestContent alloc] init];
//        gameRequestContent.message = @"ask you for a gift.";
//        gameRequestContent.title = [NSString stringWithFormat:@"This is %@",_gift.title];
//        //设置索要礼物的好友
//        gameRequestContent.recipients = recipients;//数组存放WAAppUser的ID
//        //设置索要的礼物id
//        gameRequestContent.objectID = _gift.ID;//WAFBObject的ID
//        //actionType设置为WAGameRequestActionTypeAskFor 索要
//        gameRequestContent.actionType = WAGameRequestActionTypeAskFor;
//        [WASocialProxy fbAskForGiftWithContent:gameRequestContent delegate:self];
        
        [self sendRequest:2 message:@"ask you for a gift." title:[NSString stringWithFormat:@"This is %@",_gift.title] objectId:_gift.ID receiptIds:recipients];
    }
}
-(void)sendRequest:(int)type message:(NSString*)message title:(NSString*)title objectId:(NSString*)objectId receiptIds:(NSArray*)receiptIds{
    if (type == 1) {
        [WASocialProxy sendRequestWithPlatform:WA_PLATFORM_FACEBOOK requestType:WA_REQUEST_TYPE_SEND title:title message:message objectId:objectId receiptIds:receiptIds
                                      delegate:self];
    }else if(type == 2){
        [WASocialProxy sendRequestWithPlatform:WA_PLATFORM_FACEBOOK requestType:WA_REQUEST_TYPE_ASKFOR title:title message:message objectId:objectId receiptIds:receiptIds
                                      delegate:self];
    }
}


//-(void)sendRequest{
//    [WASocialProxy sendRequestWithPlatform:WA_PLATFORM_FACEBOOK requestType:WA_REQUEST_TYPE_SEND title:@"A gift" message:@"send you a gift" objectId:@"objectId" receiptIds:@[@"receiptId1",@"receiptId2"] delegate:self];
//}


#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friends.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell;
    if ((int)indexPath.row > (int)_friendCells.count-1) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendsCellForSendingAndAsking"];
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

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WAAppUser* appUser = _friends[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag ==0) {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.tag = 1;
        [_friendSelected addObject:appUser];
    }else{
        cell.backgroundColor = [UIColor clearColor];
        cell.tag = 0;
        [_friendSelected removeObject:appUser];
        
    }
    
    [self reloadHeaderLabel];
}
#pragma mark AlertView
-(void)alertWithTitle:(NSString*)title andContent:(NSString*)content andTag:(NSUInteger)tag{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
}
#pragma mark UIAlertViewDelegate
-(void)alertViewCancel:(UIAlertView *)alertView{
    if (!alertView.tag) {
        [self close];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (!alertView.tag) {
        [self close];
    }
}
#pragma mark delegate WAGameRequestDialogDelegate
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results;{
    
    NSString* content =[NSString stringWithFormat:@"didCompleteWithResults : %@",results];
    [self alertWithTitle:@"Success" andContent:content andTag:0];
    NSLog(@"GHWSDK LOG : gameRequestDialog didCompleteWithResults : %@",results);
}

-(void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSString* content =[NSString stringWithFormat:@"didFailWithError : %@",error.description];
    [self alertWithTitle:@"Fail" andContent:content andTag:0];
    NSLog(@"didFailWithError : %@",error.description);
}

-(void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform{
    [self alertWithTitle:@"Cancel" andContent:@"Did cancel." andTag:10];
    NSLog(@"gameRequestDialogDidCancel");
}

#pragma mark property setting getting
-(void)setActionType:(WAGameRequestActionType)actionType{
    _actionType = actionType;
    if (_actionType == WAGameRequestActionTypeSend) {
        [self.leftBtn setTitle:@"Send" forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(sendGift) forControlEvents:UIControlEventTouchUpInside];
    }else if (_actionType == WAGameRequestActionTypeAskFor) {
        [self.leftBtn setTitle:@"Ask for" forState:UIControlStateNormal];
        [self.leftBtn addTarget:self action:@selector(askForGift) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
