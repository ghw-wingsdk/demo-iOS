//
//  WADemoCscViewController.m
//  WADemo
//
//  Created by hank on 2018/6/8.
//  Copyright © 2018年 GHW. All rights reserved.
//

#import "WADemoUserCenterViewController.h"
#import <WASdkIntf/WASdkIntf.h>
#import "WADemoAlertView.h"
#import <Toast/Toast.h>



@interface WADemoUserCenterViewController () <WAUserCenterNoticeDelegate, WAUserCenterNoticeUIDelegate>

@property (nonatomic, strong) UIView *viewTitle;

@end

@implementation WADemoUserCenterViewController



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self initTitleViews:@"用户中心"];
    [self initScrollView];
}

#pragma mark -- 初始化Bar
- (void)initTitleViews:(NSString *)title
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat heightStatus = rectStatus.size.width > rectStatus.size.height ? rectStatus.size.height : rectStatus.size.width;
    
    _viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, heightStatus, self.bounds.size.width, 44)];
    self.viewTitle.backgroundColor = [UIColor grayColor];
    [self addSubview:self.viewTitle];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:self.viewTitle.bounds];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont fontWithName:@"Arial" size:15];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.text = title;
    [self.viewTitle addSubview:labelTitle];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.viewTitle.bounds.size.height, self.viewTitle.bounds.size.height)];
    backBtn.tag = 100;
    [backBtn setTitle:@"<" forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    [backBtn setTintColor:[UIColor whiteColor]];
    [backBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewTitle addSubview:backBtn];
}

#pragma mark -- 初始化按钮
- (void)initScrollView
{
    CGRect frame = self.bounds;
    frame.origin.y = self.viewTitle.bounds.size.height+40;
    frame.size.height += frame.origin.y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.backgroundColor =[UIColor whiteColor];

    [self addSubview:scrollView];
    
    NSArray *titles = @[@"是否开启中心数据",@"获取用户中心数据", @"打开用户中心界面",@"切换区服"];
    
    CGFloat left = 10, right = 10, top = 60, bottom = 40, mid_space_h = 10, mid_space_v = 10, btnHeight = 40;
    
    UIButton *button;
    for (NSInteger i = 0; i < titles.count; i++)
    {
        CGFloat btn_w = (scrollView.bounds.size.width - left - right - mid_space_h) / 2.0f;
        CGFloat btn_x = left + (btn_w + mid_space_h) * (i % 2);
        CGFloat btn_y = top + (btnHeight + mid_space_v) * (i / 2);
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btn_x, btn_y, btn_w, btnHeight);
        button.tag = i + 1;
        [button setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor] size:button.frame.size] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor orangeColor] size:frame.size] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];//Helvetica-Bold
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [button setShowsTouchWhenHighlighted:YES];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        CGFloat contentHeight = top + (i + 1) * (btnHeight + mid_space_v) + btnHeight + bottom;
        if (contentHeight < scrollView.bounds.size.height) {
            contentHeight = scrollView.bounds.size.height;
        }
        scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, contentHeight);
    }
}

#pragma mark -- 按钮事件
- (void)buttonEvent:(UIButton *)button
{
    if (button.tag == 100)
    {
        [self removeView ];
    } else if (button.tag == 1)   //  获取用户中心数据
    {
       BOOL isOpenUserCenter= [WAUserProxy isOpenUserCenter];
        
        [self makeToast:[NSString stringWithFormat:@"是否开启:%d",isOpenUserCenter]];

        
    }
    else if (button.tag == 2)   //  获取用户中心数据
    {
        [WAUserProxy getUserCenterNotice:self];
    }
    else if (button.tag == 3)   // 打开用户中心界面
    {
        [WAUserProxy showUserCenterNoticeUI:self];
    }else if (button.tag == 4)   // 设置短链过期
    {
        WALoginResult* result = [WAUserProxy  getCurrentLoginResult];
        NSString * serverid = [WACoreProxy getServerId];
        NSString * gameuserid= [NSString stringWithFormat:@"server1-role1-%@",result.userId];

        
        if([serverid isEqualToString:@"server2"]){
            
            serverid=@"server1";
            
        }else{
            
            serverid=@"server2";
            gameuserid= [NSString stringWithFormat:@"server2-role2-%@",result.userId];

        }
        NSString * nickName = [NSString stringWithFormat:@"青铜%@-%@",serverid,result.userId];

        
        
        [WACoreProxy setServerId:serverid];
        [WACoreProxy setGameUserId:gameuserid];
        [WACoreProxy setNickName:nickName];

        WALog(@"gameuseid====%@",gameuserid);
        WALog(@"nickName====%@",nickName);

        WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"notice" message:gameuserid cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
        [alert show];
        
        
        
        
    }
}

#pragma mark WAUserCenterNoticeDelegate
- (void)userCenterNoticeWithResult:(WAUserCenterResult *)result
{
    if (result.code == WACodeSuccess) {
        NSLog(@"result--userCenterInfo:%@",result.userCenterInfo);

        
        NSString * alertTitle =[NSString stringWithFormat:@"uid=%@,shortUrl=%@,desc=%@",result.uid,result.shortUrl,result.userCenterInfo];
        
        WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"success" message:alertTitle cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
        [alert show];
        
        
    } else {
        NSLog(@"userCenterNoticeWithResult code:%ld, msg:%@",(long)result.code, result.msg);
        
           
        WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"notice" message:result.msg cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
        [alert show];
    }
}

#pragma mark WAUserCenterNoticeDelegateUI
- (void)userCenterNoticeClose
{
    NSLog(@"userCenterNoticeClose");
}

- (void)userCenterNoticeError:(NSError *)error
{
    NSLog(@"userCenterNoticeError code:%ld, msg:%@",(long)error.code, error.localizedDescription);
}

#pragma mark -- 颜色转图片
-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -- 旋转
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self initViews];
}


@end


