//
//  GHWGiftBoxTV.m
//  GHWSdkUI
//
//  Created by wuyx on 15/9/10.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoGiftBoxTV.h"
//#import "SVProgressHUD.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "WADemoGiftRequestView.h"
#import "WADemoMaskLayer.h"
#import "WADemoAlertView.h"



@interface WADemoGiftBoxTV()
@property(nonatomic)WADemoFBActionType actionType;
@end
@implementation WADemoGiftBoxTV
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AppRequestCellForReceived"];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark DrawUI
-(void)initUI{
    [self.labelInHeaderView setText:@"Gift Box(Received)"];
    [self.leftBtn setTitle:@"Received" forState:UIControlStateNormal];
    self.leftBtn.tag = 0;
    [self.leftBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"Asked" forState:UIControlStateNormal];
    self.rightBtn.tag = 1;
    [self.rightBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBtn setTitle:@"Close" forState:UIControlStateNormal];
    [self.bottomBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadRequestDataWithActionType:WADemoFBActionTypeSend];
}

-(void)close{
    [super close];
    [WADemoMaskLayer stopAnimating];
}

-(void)choose:(UIButton*)btn{
    if (!btn.tag) {
        [self loadRequestDataWithActionType:WADemoFBActionTypeSend];
        [self.labelInHeaderView setText:@"Gift Box(Received)"];
    }else{
        [self loadRequestDataWithActionType:WADemoFBActionTypeAskFor];
        [self.labelInHeaderView setText:@"Gift Box(Asked)"];
    }
}

#pragma mark loadData
-(void)reloadRequest{
    [self loadRequestDataWithActionType:_actionType];
}

-(void)loadRequestDataWithActionType:(WADemoFBActionType)actionType{
//    [SVProgressHUD show];
    [WADemoMaskLayer startAnimating];
    self.actionType = actionType;
    
    if (actionType == WADemoFBActionTypeAskFor) {
        [WASocialProxy fbQueryAskForGiftRequestsWithCompleteBlock:^(NSArray<WAFBAppRequest *> *requests, NSError *error) {
            if (!error) {
                self.appRequests = requests;
                self.dataSource = self;
                [self reloadData];
                [WADemoMaskLayer stopAnimating];
                
            }else{
                [WADemoMaskLayer stopAnimating];
                NSLog(@"WASDK LOG : ERROR %@",error.description);
                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];
                
            }
        }];
        
    }else if(actionType == WADemoFBActionTypeSend){
        [WASocialProxy fbQueryReceivedGiftsWithCompleteBlock:^(NSArray<WAFBAppRequest *> *gifts, NSError *error) {
            if (!error) {
                self.appRequests = gifts;
                self.dataSource = self;
                [self reloadData];
                [WADemoMaskLayer stopAnimating];
                
            }else{
                NSLog(@"WASDK LOG : ERROR %@",error.description);
                [WADemoMaskLayer stopAnimating];
                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];
            }
        }];
        
    }
}

#pragma mark datasource UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appRequests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppRequestCellForReceived" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AppRequestCellForReceived"];
    }
    
    WAFBAppRequest* appRequest = self.appRequests[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ requestId:%@",appRequest.object.title,appRequest.ID];
    [cell.imageView setImageWithURL:[NSURL URLWithString:appRequest.object.imageUrls]];
    return cell;
}
#pragma mark delegate UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WADemoGiftRequestView* requestView = [[WADemoGiftRequestView alloc]init];
    WAFBAppRequest* appRequest = self.appRequests[indexPath.row];
    requestView.request = appRequest;
    requestView.actionType = _actionType;
    requestView.giftBox = self;
    [self.superview addSubview:requestView];
}
@end
