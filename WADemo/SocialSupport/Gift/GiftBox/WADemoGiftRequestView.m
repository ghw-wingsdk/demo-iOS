//
//  GHWGiftRequestView.m
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoGiftRequestView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
//#import <AFNetworking/AFNetworking.h>
typedef enum GHWBtnActionType{
    GHWBtnActionTypeAccept = 1,
    GHWBtnActionTypeRefuse
}GHWBtnActionType;
@interface WADemoGiftRequestView()
@property(nonatomic)GHWBtnActionType btnActionType;
@end
@implementation WADemoGiftRequestView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        self.dataSource = self;
        self.delegate =self;
    }
    return self;
}

#pragma mark DrawUI
-(void)initUI{
    [self.leftBtn setTitle:@"Accept" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(deleteRequestWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.tag = 10;
    
    [self.rightBtn setTitle:@"Refuse" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(deleteRequestWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.tag = 20;
    [self.bottomBtn setTitle:@"Close" forState:UIControlStateNormal];
    [self.bottomBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark property setting getting
-(void)setActionType:(WADemoFBActionType)actionType{
    
    _actionType = actionType;
    if (!_request) {
        return;
    }
    
    if (actionType == WADemoFBActionTypeSend) {
        self.labelInHeaderView.text = [NSString stringWithFormat:@"Received:%@",_request.object.title];
    }else if (actionType == WADemoFBActionTypeAskFor) {
        self.labelInHeaderView.text = [NSString stringWithFormat:@"Asked:%@",_request.object.title];
    }
}

#pragma mark action selector
-(void)deleteRequestWithBtn:(UIButton*)btn{
    NSString* msg;
    if (btn.tag == 10) {
        _btnActionType = GHWBtnActionTypeAccept;
        msg = @"Are you sure to Accept the gift?";
    }else if(btn.tag == 20){
        _btnActionType = GHWBtnActionTypeRefuse;
        msg = @"Are you sure to Refuse the gift?";
    }

    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sure", nil];
    alert.tag = btn.tag;
    [alert show];
}

-(void)deleteRequest{
    
    NSString* msg;

    if (_btnActionType == GHWBtnActionTypeAccept) {
        msg = @"Accept";
    }else if (_btnActionType == GHWBtnActionTypeRefuse){
        msg = @"Refuse";
    }
    
    
    [WASocialProxy fbDeleteRequestWithRequestId:_request.ID completeBlock:^(id result, NSError *error) {
        if (!error) {
            NSLog(@"GHWSDK LOG : 删除成功！");
            [self alertWithTitle:[NSString stringWithFormat:@"Success"] andContent:[NSString stringWithFormat:@"%@ 成功",msg] andTag:0];
        }else{
            NSLog(@"删除失败");
            [self alertWithTitle:[NSString stringWithFormat:@"Success"] andContent:[NSString stringWithFormat:@"%@ 失败",msg] andTag:0];
        }
    }];
    

}


#pragma mark DataSource UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    if (indexPath.row == 0) {
       
        [cell.imageView setImageWithURL:[NSURL URLWithString:_request.object.imageUrls]];
        cell.textLabel.text = _request.object.title;
    }else if(indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"request id:%@",_request.object.ID];
    }else if(indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"from:%@",_request.from.name];
    }else if(indexPath.row == 3){
        cell.textLabel.text = [NSString stringWithFormat:@"to:%@",_request.to.name];
    }
    
    return cell;
}

#pragma mark delegate UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }
    return 45;
}

#pragma mark AlertView
-(void)alertWithTitle:(NSString*)title andContent:(NSString*)content andTag:(NSUInteger)tag{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    alert.tag = tag;
    [alert show];
}
#pragma mark UIAlertViewDelegate
-(void)alertViewCancel:(UIAlertView *)alertView{
    if (alertView.tag == 10||alertView.tag ==20) {
        return;
    }
    [self.giftBox reloadRequest];
    [self close];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [self deleteRequest];
        return;
    }
    
    if (alertView.tag == 10||alertView.tag ==20) {
        return;
    }
    
    [self.giftBox reloadRequest];
    [self close];
}


@end
