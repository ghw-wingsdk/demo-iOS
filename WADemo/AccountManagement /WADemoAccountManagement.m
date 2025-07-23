//
//  WADemoAccountManagement.m
//  WADemo
//
//  Created by LPW on 2020/5/12.
//  Copyright © 2020 GHW. All rights reserved.
//

#import "WADemoAccountManagement.h"
#import "WADemoUtil.h"
#import "WADemoMaskLayer.h"
#import "WADemoButtonMain.h"
#import "WADemoAlertView.h"
#import "WADemoUtil.h"
#import "WADemoAccountSwitch.h"
#import "WADemoMaskLayer.h"
#import "ViewController.h"
#import "WADemoBindingAccountList.h"

@interface WADemoAccountManagement ()<WAAccountBindingDelegate,WAAcctManagerDelegate>
@property (nonatomic, strong) UIView *viewTitle;
@property (nonatomic, strong) WADemoAccountSwitch* acctSwitch;
@property (nonatomic, strong) WADemoBindingAccountList* accountList;

@end

@implementation WADemoAccountManagement


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        
        [self initViews];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}



- (void)initViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self initTitleViews:@"账号管理"];
    [self initScrollView];

}



#pragma mark -- 初始化按钮
- (void)initScrollView
{
    CGRect frame = self.bounds;
    frame.origin.y = self.viewTitle.bounds.size.height+self.viewTitle.frame.origin.y;

    frame.size.height += frame.origin.y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.backgroundColor =[UIColor whiteColor];

    [self addSubview:scrollView];
    
    NSArray *titles = @[@"绑定Facebook账号", @"绑定Apple账号",@"绑定signinwithapple", @"绑定VK账号", @"绑定Twitter账号", @"绑定Instagram账号", @"新建账户", @"切换账户", @"查询已绑定账户",@"打开SDK内置账号管理界面",@"获取当前账户信息(getAccountInfo-VK)",@"绑定ghg",@"绑定WA"];
    
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


#pragma mark -- 按钮事件
- (void)buttonEvent:(UIButton *)button
{
	NSString * titleStr= button.titleLabel.text;

    if (button.tag == 100)
    {
        [self removeView];
	}
	
	if ([titleStr isEqualToString:@"绑定Facebook账号"]) {
		[self bindFB];
	}else if ([titleStr isEqualToString:@"绑定Apple账号"]) {
		[self bindApple];
	}else if ([titleStr isEqualToString:@"绑定VK账号"]) {
		[self bindVK];
	}else if ([titleStr isEqualToString:@"绑定Twitter账号"]) {
		[self bindTwitter];
	}else if ([titleStr isEqualToString:@"绑定Instagram账号"]) {
		[self bindInstagram];
	}else if ([titleStr isEqualToString:@"新建账户"]) {
		[self newAccount];
	}else if ([titleStr isEqualToString:@"切换账户"]) {
		[self accoutSwitch];
	}else if ([titleStr isEqualToString:@"查询已绑定账户"]) {
		[self bindingList];
	}else if ([titleStr isEqualToString:@"打开SDK内置账号管理界面"]) {
		[self popAcctManagementUI];
	}else if ([titleStr isEqualToString:@"获取当前账户信息(getAccountInfo-VK)"]) {
		[self getAccountInfo];
	}else if ([titleStr isEqualToString:@"绑定signinwithapple"]) {
		[self bindsigninwithapple];
    }else if([titleStr isEqualToString:@"绑定ghg"]){
        [self bindghg];

    }else if([titleStr isEqualToString:@"绑定WA"]){
        [self bindWA];

    }
	
	
	
}

-(void)bindWA{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_WINGA extInfo:nil delegate:self];
}
-(void)bindghg{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_GHG extInfo:nil delegate:self];
}
//绑定facebook
-(void)bindFB{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_FACEBOOK extInfo:nil delegate:self];
}
//绑定apple
-(void)bindApple{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_APPLE extInfo:nil delegate:self];
}

//绑定sign in with apple
-(void)bindsigninwithapple{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_SIGNINWITHAPPLE extInfo:nil delegate:self];
}


-(void)bindVK{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_VK extInfo:nil delegate:self];
}

-(void)bindTwitter{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_TWITTER extInfo:nil delegate:self];
}

-(void)bindInstagram{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_INSTAGRAM extInfo:nil delegate:self];
}
//新建账户

-(void)newAccount{
    [WADemoMaskLayer startAnimating];
    [WAUserProxy createNewAccountWithCompleteBlock:^(NSError *error, WALoginResult *result) {
        [WADemoMaskLayer stopAnimating];
        if (!error) {
            //新建账号成功
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"新建成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@\npToken:%@\nuserId:%@\ntoken:%@",result.platform,result.pUserId,result.pToken,result.userId,result.token] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }else{
            //新建账号错误处理
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"新建失败" message:[NSString stringWithFormat:@"platform:%@\nerror:%@",result.platform,error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
}
//切换账户
-(void)accoutSwitch{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    self.acctSwitch = [[WADemoAccountSwitch alloc]initWithFrame:self.bounds];
    self.acctSwitch.hasBackBtn = YES;
    [vc.view addSubview:self.acctSwitch];
    [self.acctSwitch moveIn:nil];
}

//查询已绑定账户
- (void)bindingList{
    [WAUserProxy queryBoundAccountWithCompleteBlock:^(NSError *error, NSArray *accounts) {
        if (error) {
            NSLog(@"error : %@",error.description);
        }else{
            _accountList = [[WADemoBindingAccountList alloc]initWithFrame:self.bounds];
            self.accountList.accounts = accounts;
            [self addSubview:self.accountList];
        }
    }];
    
}

//打开SDK内置账号管理界面
-(void)popAcctManagementUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uiBindDidSucceed:) name:WABindDidSucceedNotification object:nil];
    [WAUserProxy openAccountManager:self];
}
-(void)uiBindDidSucceed:(NSNotification*)info{
    NSDictionary * objdic =info.object;
    WABindingResult * bindResult = info.object;
    
    
    if(bindResult&&[bindResult.platform isEqualToString:WA_PLATFORM_WINGA]){
        NSLog(@"UI绑定界面，绑定ghg成功");
        WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"获取账号信息" message:@"UI绑定wa成功" cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
        [alert show];
        
    }

    NSLog(@"=uiBindDidSucceed==%@",objdic);
    
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"UI绑定界面绑定回调" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@\npToken:%@\email:%@\mobile:%@",bindResult.platform,bindResult.userId,bindResult.accessToken,bindResult.email,bindResult.mobile] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];

    [alert show];
    
}
-(void)getAccountInfo{
    WAAppUser* appUser = [WAUserProxy getAccountInfoWithPlatform:WA_PLATFORM_VK];
    NSString* msg;
    if (appUser) {
        msg = [NSString stringWithFormat:@"platform:VK\nuserId:%@\nname:%@\npictureURL:%@\n",appUser.ID,appUser.name,appUser.pictureURL];
        
    }else{
        msg = @"获取账号信息为空,可能未登录相应平台";
    }
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"获取账号信息" message:msg cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}


/**
 *绑定成功
 */
-(void)bindingDidCompleteWithResult:(WABindingResult*)result{
    [WADemoMaskLayer stopAnimating];
    
    NSString * message =[NSString stringWithFormat:@"绑定%@成功\n,userId:%@\ntoken:%@\n mobile:%@\n email:%@\n ",result.platform,result.userId,result.accessToken,result.mobile,result.email];
    
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"绑定成功" message:message cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
    

    
}



/**
 *  绑定失败
 */
-(void)bindingDidFailWithError:(NSError*)error andResult:(WABindingResult*)result{
    [WADemoMaskLayer stopAnimating];
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"绑定失败" message:[NSString stringWithFormat:@"绑定%@失败,error:%@",result.platform,error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

/**
 *绑定取消
 */
-(void)bindingDidCancel:(WABindingResult*)result{
    [WADemoMaskLayer stopAnimating];
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"tip" message:@"用户取消" cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
}

#pragma mark 移除绑定解绑观察者
-(void)bindRemoveObserver{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WABindDidSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WABindDidFailNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WAUnbindDidSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WAUnbindDidFailNotification object:nil];
}

-(void)removeView{
    [super removeView];

    [self bindRemoveObserver];
    
}

- (void)bindAccountDidCompleteWithResult:(WABindingResult *)bindResult {
	
    if(bindResult&&[bindResult.platform isEqualToString:WA_PLATFORM_GHG]){
        NSLog(@"UI绑定ghg成功回调");
    }
}

- (void)newAcctDidCompleteWithResult:(WALoginResult *)result {
	
	WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"新建成功" message:[NSString stringWithFormat:@"userId:%@\ntoken:%@\nplatform:%@\npUserId:%@\npToken:%@\nextends:%@ 是否为游客登录:%d",result.userId,result.token,result.platform,result.userId,result.pToken,result.extends,result.isGuestAccount] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
	[alert show];
	
}

- (void)realNameAuthtDidCompleteWithResult:(WACertificationInfo *)certificationInfo {
	
}

- (void)switchAcctDidCompleteWithResult:(WALoginResult *)result {

    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"切换成功" message:[NSString stringWithFormat:@"userId:%@\ntoken:%@\nplatform:%@\npUserId:%@\npToken:%@\nextends:%@ 是否为游客登录:%d",result.userId,result.token,result.platform,result.pUserId,result.pToken,result.extends,result.isGuestAccount] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
	[alert show];
	
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
