//
//  WADemoCscViewController.m
//  WADemo
//
//  Created by hank on 2018/6/8.
//  Copyright © 2018年 GHW. All rights reserved.
//

#import "WADemoCscViewController.h"
#import <WASdkIntf/WASdkIntf.h>
#import <Toast/Toast.h>

@interface WADemoCscViewController ()

@property (nonatomic, strong) UIView *viewTitle;

@end

@implementation WADemoCscViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

BOOL vip;
- (void)initViews
{
    self.view.backgroundColor = [UIColor grayColor];
    
    [self initTitleViews:@"客服系统"];
    [self initScrollView];
    
    [WACscProxy setLanguage:@"zh_CN"];
	
//    [WACscProxy setName:@"WADemo"];
    

}

#pragma mark -- 初始化Bar
- (void)initTitleViews:(NSString *)title
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat heightStatus = rectStatus.size.width > rectStatus.size.height ? rectStatus.size.height : rectStatus.size.width;
	
	
    
    _viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, heightStatus, self.view.bounds.size.width, 44)];
    self.viewTitle.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.viewTitle];
    
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
    CGRect frame = self.view.bounds;
    frame.origin.y = self.viewTitle.bounds.size.height+self.viewTitle.frame.origin.y;

    frame.size.height -= frame.origin.y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:scrollView];
    
    NSArray *titles = @[@"是否开启了aihelp客服V2", @"打开v2客服", @"是否开启了评价界面客服", @"打开评价客服",@"切换语言",@"查询未读消息"];
    
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
		[self dismissViewControllerAnimated:YES completion:nil];
		
    }

   else if(button.tag==1){ 	//检测是否开启客服
		
       NSString * titlestr=@"未开启客服";
		if([WACscProxy isOpenAiHelp]){
            titlestr=@"开启了客服";
		}
       
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:titlestr preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           // 用户点击了取消按钮
       }];
       [alertController addAction:cancelAction];
       [self presentViewController:alertController animated:YES completion:nil];
       
		
	}else if(button.tag==2){     //检测是否开启客服
        
        if([WACscProxy isOpenAiHelp]){
            [WACscProxy openAiHelpV2];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未开启客服" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                // 用户点击了取消按钮
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }else if(button.tag==3){     //检测是否开启客服
        
        
        NSString * titlestr=@"未开启游戏评分客服";

        
        if([WACscProxy isOpenGameReviewAiHelp]){
            titlestr=@"开启了游戏评分客服";
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:titlestr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // 用户点击了取消按钮
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }else if(button.tag==4){     //检测是否开启客服
        
        if([WACscProxy isOpenGameReviewAiHelp]){
            [WACscProxy openGameReviewAiHelp];

        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未开启游戏评分客服" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                // 用户点击了取消按钮
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }else if(button.tag==5){     //切换语言
        changeLanguage=!changeLanguage;
        if(changeLanguage){
            [WACscProxy setLanguage:@"en"];
            [self showToastMessage:@"en"];

        }else{
            [WACscProxy setLanguage:@"zh_CN"];
            [self showToastMessage:@"zh_CN"];

        }
    }else if(button.tag==6){     //查询未读消息
        [WACscProxy getUnreadMessageCount:^(int messageCount, NSError * _Nullable error) {
            NSLog(@"查询未读消息:%d",messageCount);
            
            [self showToastMessage:[NSString stringWithFormat:@"查询未读消息:%d",messageCount]];

        }];
    }
}

BOOL changeLanguage= NO;

- (void)showToastMessage:(NSString *)messag{
	
	[self.view makeToast:messag duration:2 position:CSToastPositionCenter];

}

#pragma mark -- 弹出框
- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder callBack:(void (^ __nullable)(NSString *text))callBack
{
    UIAlertController *alertConrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertConrl addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = placeholder;
    }];
    [alertConrl addAction:[UIAlertAction actionWithTitle:@"确定"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     if (callBack)
                                                         callBack(alertConrl.textFields.firstObject.text);
                                                 }]];
    [alertConrl addAction:[UIAlertAction actionWithTitle:@"取消"
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
    [self presentViewController:alertConrl animated:true completion:nil];
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
    for (UIView *view in self.view.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

