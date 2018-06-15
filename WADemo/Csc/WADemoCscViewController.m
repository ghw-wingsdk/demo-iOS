//
//  WADemoCscViewController.m
//  WADemo
//
//  Created by hank on 2018/6/8.
//  Copyright © 2018年 GHW. All rights reserved.
//

#import "WADemoCscViewController.h"
#import <WASdkIntf/WASdkIntf.h>

@interface WADemoCscViewController ()

@property (nonatomic, strong) UIView *viewTitle;

@end

@implementation WADemoCscViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTitleViews:@"客服系统"];
    [self initScrollView];
    
//    [WACscProxy setLanguage:@"zh_CN"];
    [WACscProxy setName:@"WADemo"];
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
    frame.origin.y = self.viewTitle.bounds.size.height;
    frame.size.height -= frame.origin.y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:scrollView];
    
    NSArray *titles = @[@"启动机器人客服界面", @"启动运营界面", @"展示全部FAQ菜单", @"展示FAQ分类", @"展示单条FAQ", @"进入人工客服界面"];
    
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (button.tag == 1)   //  启动机器人客服界面
    {
        NSMutableDictionary *customData = [NSMutableDictionary dictionary];
        [customData setObject:@"vip,pay1" forKey:@"WINGSDK-tags"];
        [customData setObject:@"1.0.0" forKey:@"VersionCode"];
        
        NSMutableDictionary *config = [NSMutableDictionary dictionary];
        [config setObject:customData forKey:@"WINGSDK-custom-metadata"];
        
        [WACscProxy showElva:@"1" config:config];
    }
    else if (button.tag == 2)   // 启动运营界面
    {
        NSMutableDictionary *customData = [NSMutableDictionary dictionary];
        [customData setObject:@"vip,pay1" forKey:@"WINGSDK-tags"];
        [customData setObject:@"1.0.0" forKey:@"VersionCode"];
        
        NSMutableDictionary *config = [NSMutableDictionary dictionary];
        [config setObject:customData forKey:@"WINGSDK-custom-metadata"];
        
        [WACscProxy showElvaOP:@"1" config:config];
    }
    else if (button.tag == 3)   // 展示全部FAQ菜单
    {
        NSMutableDictionary *customData = [NSMutableDictionary dictionary];
        [customData setObject:@"vip,pay1" forKey:@"WINGSDK-tags"];
        [customData setObject:@"1.0.0" forKey:@"VersionCode"];
        
        NSMutableDictionary *config = [NSMutableDictionary dictionary];
        [config setObject:customData forKey:@"WINGSDK-custom-metadata"];
        
        [WACscProxy showFAQs:config];
    }
    else if (button.tag == 4)   // 展示FAQ分类
    {
        [self alertViewWithTitle:@"展示FAQ分类"
                         message:nil
                     placeholder:@"请输入sectionPublishId"
                        callBack:^(NSString *text) {
                            NSMutableDictionary *customData = [NSMutableDictionary dictionary];
                            [customData setObject:@"vip,pay1" forKey:@"WINGSDK-tags"];
                            [customData setObject:@"1.0.0" forKey:@"VersionCode"];
                            
                            NSMutableDictionary *config = [NSMutableDictionary dictionary];
                            [config setObject:customData forKey:@"WINGSDK-custom-metadata"];
                            
                            [WACscProxy showFAQSection:text config:config];
                        }];
    }
    else if (button.tag == 5)   // 展示单条FAQ
    {
        NSMutableDictionary *customData = [NSMutableDictionary dictionary];
        [customData setObject:@"vip,pay1" forKey:@"WINGSDK-tags"];
        [customData setObject:@"1.0.0" forKey:@"VersionCode"];
        
        NSMutableDictionary *config = [NSMutableDictionary dictionary];
        [config setObject:customData forKey:@"WINGSDK-custom-metadata"];
        
        [self alertViewWithTitle:@"展示单条FAQ"
                         message:nil
                     placeholder:@"请输入faqId"
                        callBack:^(NSString *text) {
                            [WACscProxy showSingleFAQ:text config:config];
                        }];
    }
    else if (button.tag == 6)   // 进入人工客服界面
    {
        NSMutableDictionary *customData = [NSMutableDictionary dictionary];
        [customData setObject:@"vip,pay1" forKey:@"WINGSDK-tags"];
        [customData setObject:@"1.0.0" forKey:@"VersionCode"];
        
        NSMutableDictionary *config = [NSMutableDictionary dictionary];
        [config setObject:customData forKey:@"WINGSDK-custom-metadata"];
        
        [WACscProxy showConversation:config];
    }
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
