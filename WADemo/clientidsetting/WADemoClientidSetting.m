//
//  WADemoClientidSetting.m
//  WADemo
//
//  Created by lpw on 2023/7/18.
//

#import "WADemoClientidSetting.h"
#import <WASdkIntf/WASdkIntf.h>
#import <Toast/Toast.h>

static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
#define kRandomLength 32
@interface WADemoClientidSetting ()

@property (nonatomic, strong) UIView *viewTitle;
@property (nonatomic, strong) UITextField * textField;
@end



@implementation WADemoClientidSetting

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    frame.size.height -= frame.origin.y;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self addSubview:scrollView];
    
    
    self.textField =[[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.bounds.size.width-100, 40)];
    self.textField.backgroundColor =[UIColor grayColor];
    self.textField.placeholder=@"设置固定clientid";
    [scrollView addSubview:self.textField];
    
    int btn_x =CGRectGetMaxX(self.textField.frame)+10;
    int btn_y = 100;
    int btn_w = 80;
    int btnHeight = 40;

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(btn_x, btn_y, btn_w, btnHeight);
    button.tag =200;
    button.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];//Helvetica-Bold
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setShowsTouchWhenHighlighted:YES];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.backgroundColor =[UIColor yellowColor];
    
    [button setTitle:@"设置clientid" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    
    
     btn_x =100;
     btn_y =CGRectGetMaxX(self.textField.frame)+50;
     btn_w = self.bounds.size.width-btn_x*2;
     btnHeight = 40;

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(btn_x, btn_y, btn_w, btnHeight);
    button.tag =300;
    button.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];//Helvetica-Bold
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setShowsTouchWhenHighlighted:YES];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.backgroundColor =[UIColor yellowColor];

    [button setTitle:@"设置随机clientid" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    
}

#pragma mark -- 按钮事件
- (void)buttonEvent:(UIButton *)button
{
    [self.textField resignFirstResponder];
    if (button.tag == 100)
    {
        [self removeView ];
    }else if(button.tag==200){
        NSString * clientid =self.textField.text;
        if([clientid length]!=0){
            
            [self makeToast:clientid];

            [WACoreProxy setClientId:clientid];
            
        }
        
    }else if(button.tag==300){
        NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
        for (int i = 0; i < kRandomLength; i++) {
            [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
        }
        [self makeToast:randomString];

        [WACoreProxy setClientId:randomString];
        
    }
}
@end
