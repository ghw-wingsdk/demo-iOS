//
//  ViewController.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/23.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoViewController.h"
#import "WADemoMainUI.h"
#import "WADemoAlertView.h"

@interface WADemoViewController ()

@property (nonatomic, strong) WADemoMainUI* mainUI;

@end

@implementation WADemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initUI{
    self.mainUI = [[WADemoMainUI alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainUI];   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate  GHWLoginViewControllerDelegate
-(void)loginViewDidCancel:(WALoginResult *)result{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"取消登录" message:[NSString stringWithFormat:@"用户取消登录 登录平台:%@",result.platform] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    [alert show];
}

-(void)loginViewDidCompleteWithResult:(WALoginResult *)result{
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"登录成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@,pToken:%@,userId:%@,token:%@  是否为游客账号:%d",result.platform,result.pUserId,result.pToken,result.userId,result.token,result.isGuestAccount] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

-(void)loginViewDidFailWithError:(NSError *)error andResult:(WALoginResult *)result{
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"error:%@\nplatform:%@\npUserId:%@,pToken:%@,userId:%@,token:%@",error.description,result.platform,result.pUserId,result.pToken,result.token,result.userId] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}
- (BOOL)shouldAutorotate
{
    return YES;
}
#pragma mark delegate  WAAcctManagerDelegate
-(void)newAcctDidCompleteWithResult:(WALoginResult*)result{
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"新建账户成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@,pToken:%@,userId:%@,token:%@",result.platform,result.pUserId,result.pToken,result.token,result.userId] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

-(void)switchAcctDidCompleteWithResult:(WALoginResult*)result{
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"切换账户成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@,pToken:%@,userId:%@,token:%@",result.platform,result.pUserId,result.pToken,result.token,result.userId] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.mainUI deviceOrientationDidChange];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
