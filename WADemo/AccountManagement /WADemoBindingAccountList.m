//
//  GHWBindingAccountList.m
//  GHWSdkUI
//
//  Created by wuyx on 15/12/1.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoBindingAccountList.h"
#import <WASdkIntf/WASdkIntf.h>
@interface WADemoBindingAccountList()
@property(nonatomic,strong)WAAccount* accountSelected;
@end
@implementation WADemoBindingAccountList

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GHWSDKBindingAccountCell"];
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
    [self.rightBtn setTitle:@"unBind" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(unBind) forControlEvents:UIControlEventTouchUpInside];

}

-(void)close{
    [super close];
}


-(void)unBind{
    if (_accountSelected) {
        
//        [GHWSDKLoginManager unBindAccount:_accountSelected block:^(NSError *error) {
//            if (error) {
//                //解绑失败
//            }else{
//                //解绑成功
//            }
//        }];
        [WAUserProxy unBindAccountWithPlatform:_accountSelected.platform platformUserId:_accountSelected.pUserId completeBlock:^(NSError *error) {
            if (error) {
                
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"失败,platform:%@ account:%@ error:%@",_accountSelected.platform,_accountSelected.pUserId,error.description] delegate:self cancelButtonTitle:@"Sure" otherButtonTitles: nil];
                [alert show];
                NSLog(@"unBindAccount : %@",error.description);
            }else{
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"tip" message:[NSString stringWithFormat:@"解绑成功,platform:%@ account:%@",_accountSelected.platform,_accountSelected.pUserId] delegate:self cancelButtonTitle:@"Sure" otherButtonTitles: nil];
                [alert show];
                NSLog(@"解绑成功 ");
            }
        }];
        
//        [WAUserProxy unBindAccountWithPlatform:_accountSelected.platform platformUserId:_accountSelected.pUserId completeBlock:^(NSError *error) {
//            if (error) {
//               //失败处理
//            }else{
//                //成功处理
//            }
//        }];
        
        
    }
}

-(void)alertViewCancel:(UIAlertView *)alertView{
    [self close];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self close];
}

#pragma mark loadData
-(void)reloadRequest{
//    [self loadRequestDataWithActionType:_actionType];
}



#pragma mark datasource UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHWSDKBindingAccountCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHWSDKBindingAccountCell"];
    }
    WAAccount* account = self.accounts[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",account.platform,account.pUserId];
    return cell;
}
#pragma mark delegate UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WAAccount* account = _accounts[indexPath.row];
    _accountSelected = account;
}

@end
