//
//  GHWSDKAlertView.m
//  GHWSDKAlertView
//
//  Created by wuyx on 16/1/15.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoAlertView.h"
#import "WADemoUtil.h"
@interface WADemoAlertView()
@property(nonatomic,strong)UIView* alertView;
@property(nonatomic,strong)UILabel* titleLable;
@property(nonatomic,strong)UIView* separator;
@property(nonatomic,strong)UIButton* cancelBtn;
@property(nonatomic,strong)UIButton* otherBtn;
@property(nonatomic,strong)UIView* btnZone;
@property(nonatomic,strong)UITextView* contentView;
@property(nonatomic, strong) void (^block)(GHWAlertViewClicked click);
@end
@implementation WADemoAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles block:(void(^)(GHWAlertViewClicked click))block{
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.block = block;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitles = otherButtonTitles;
        self.frame = [UIScreen mainScreen].bounds;
        [self initUI];
    }
    return self;
}

-(void)show{
    UIViewController* vc = [self getCurrentVC];
    [vc.view addSubview:self];
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initUI{
    //添加界面旋转通知
    [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
    _alertView = [[UIView alloc]init];
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 10;
    _alertView.backgroundColor = [UIColor grayColor];
    [self addSubview:_alertView];
    //标题栏
    _titleLable = [[UILabel alloc]init];
    _titleLable.text = self.title;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    _titleLable.textColor = [UIColor whiteColor];
    [_alertView addSubview:_titleLable];
    
    //分割线
    _separator = [[UIView alloc]init];
    _separator.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3];
    [_alertView addSubview:_separator];

    
    _btnZone = [[UIView alloc]init];
    [_alertView addSubview:_btnZone];
    
    //按钮
    if (_otherButtonTitles) {
        _otherBtn = [[UIButton alloc]init];
        _otherBtn.backgroundColor = [UIColor redColor];
        [_otherBtn setTitle:_otherButtonTitles forState:UIControlStateNormal];
        [_otherBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_otherBtn addTarget:self action:@selector(clickOtherBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_otherBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        _otherBtn.backgroundColor = [UIColor colorWithRed:125.0f/255.0f green:54.0f/255.0f blue:159.0f/255.0f alpha:1];
        [_btnZone addSubview:_otherBtn];
    }
    
    
    _cancelBtn = [[UIButton alloc]init];
    _cancelBtn.backgroundColor = [UIColor redColor];
    [_cancelBtn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    [_cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_cancelBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    _cancelBtn.backgroundColor = [UIColor colorWithRed:173.0f/255.0f green:146.0f/255.0f blue:42.0f/255.0f alpha:1];
    [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btnZone addSubview:_cancelBtn];
    
    _contentView = [[UITextView alloc]init];
    _contentView.text = self.message;
    _contentView.editable = NO;
    _contentView.selectable = NO;
    _contentView.backgroundColor = [UIColor clearColor];
    [_contentView setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.8]];
    [_contentView setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [_contentView setTextAlignment:NSTextAlignmentCenter];
    [_alertView addSubview:_contentView];
//    [self layoutUI];
    
}

-(void)clickCancelBtn:(UIButton*)btn{
    if (self.block) {
        self.block(GHWAlertViewClickedButtonCancel);
    }
    
    [self removeFromSuperview];
}

-(void)clickOtherBtn:(UIButton*)btn{
    if (self.block) {
        self.block(GHWAlertViewClickedButtonCancel);
    }
    [self removeFromSuperview];
}

-(void)layoutUI{
    self.frame = [UIScreen mainScreen].bounds;
    float screenW = [UIScreen mainScreen].bounds.size.width;
    float screenH = [UIScreen mainScreen].bounds.size.height;
    
    float alert_w_max = 400;
    //    float alert_w = 250;
    float alert_w = 4*screenW/5 > alert_w_max ? alert_w_max : 4*screenW/5;
    float temp_alert_h_max = 200;
    float temp_alert_h = 2*alert_w/3 > temp_alert_h_max ? temp_alert_h_max :  2*alert_w/3;
    
    
    float title_w = alert_w;
    float title_h = temp_alert_h/4;
    _titleLable.frame = CGRectMake(0, 0, title_w, title_h);
    
    float sepa_left = 10;
    float sepa_w = alert_w - 2*sepa_left;
    float sepa_h = 1;
    float sepa_x = sepa_left;
    float sepa_y = title_h;
    _separator.frame = CGRectMake(sepa_x, sepa_y, sepa_w, sepa_h);
    
    
    
    //message
    float content_h_max = 250;
    float content_h_min = 50;
    float content_left = 0;
    float content_space_top = 5;
    //    float content_space_bottom = 5;
    float content_w = alert_w - 2*content_left;
    float content_x = content_left;
    float content_y = sepa_y + sepa_h + content_space_top;
    CGSize contentSize = [self.message boundingRectWithSize:CGSizeMake(content_w, content_h_max) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:12]} context:nil].size;
    float content_h = contentSize.height + 20;
    if (contentSize.height > content_h_max) {
        content_h = content_h_max + 20;
    }else if(contentSize.height < content_h_min){
        content_h = content_h_min + 20;
    }
    
    
    _contentView.frame = CGRectMake(content_x, content_y, content_w, content_h);
    
    float btnZone_space_top = 5;
    float btnZone_h = 5*temp_alert_h/18;
    float btnZone_w = alert_w;
    float btnZone_x = 0;
    float btnZone_y = content_y + content_h +btnZone_space_top;
    _btnZone.frame = CGRectMake(btnZone_x, btnZone_y, btnZone_w, btnZone_h);
    
    float btn_left = 10;
    float btn_top = 0;
    float btn_bottom = 10;
    float btn_space = 10;
    float btn_x = btn_left;
    float btn_y = btn_top;
    float btn_w = (btnZone_w - 2*btn_left - btn_space)/2;
    if (!_otherButtonTitles) {
        btn_w = btnZone_w - 2*btn_left;
    }
    float btn_h = btnZone_h - btn_top - btn_bottom;
    _cancelBtn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
    
    if (_otherButtonTitles) {
        CGRect frame = _cancelBtn.frame;
        frame.origin.x = btn_x + btn_w + btn_space;
        _otherBtn.frame = frame;
    }
    
    float alert_h = btnZone_y + btnZone_h;
    _alertView.frame = CGRectMake(0, 0, alert_w, alert_h);
    _alertView.center = CGPointMake(screenW/2, screenH/2);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutUI];
}

-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow* window = (UIWindow*)[[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow* tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
