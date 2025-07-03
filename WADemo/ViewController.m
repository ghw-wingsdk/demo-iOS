//
//  ViewController.m
//  WADemo
//
//  Created by lpw on 2023/5/19.
//

#import "ViewController.h"
#import "WADemoMainUI.h"
#import "WADemoAlertView.h"
#import<CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "WADemoUtil.h"

@interface ViewController ()
@property (nonatomic, strong) WADemoMainUI* mainUI;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    WALog(@"viewDidLoad=%@",[NSThread currentThread]);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [WAAdMobProxy showAppOpenAdWithViewController:self withDelegate:nil];



    });

    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    NSString *phoneCode = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
    NSLog(@"phoneCode==%@", phoneCode);
    NSLog(@"countryCode==%@", countryCode);

    
//
//    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
//    NSRange startRange = [locale rangeOfString:@"_"];
//    NSString *result = [locale stringByReplacingCharactersInRange:NSMakeRange(0, startRange.length+1) withString:[[NSLocale preferredLanguages] objectAtIndex:0]];
//    NSLog(@"current locale: %@", result);
//    NSLog(@"current locale: %@", [[NSLocale preferredLanguages] objectAtIndex:0]);
//
//    CTTelephonyNetworkInfo *network_Info = [CTTelephonyNetworkInfo new];
//    CTCarrier *carrier = network_Info.subscriberCellularProvider;
//
//    NSLog(@"country code is: %@", carrier.mobileCountryCode);
//
//    //will return the actual country code
//    NSLog(@"ISO country code is: %@", carrier.isoCountryCode);


}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initUI{
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 60);
    UIView * bannerView =[[UIView alloc] initWithFrame:rect];
    bannerView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bannerView];
       
//    [WAAdMobProxy bindBannerAdWithViewController:self containerView:bannerView];


    self.mainUI = [[WADemoMainUI alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(rect)-10, self.view.frame.size.width, self.view.frame.size.height-rect.size.height)];
    [self.view addSubview:self.mainUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate  GHWLoginViewControllerDelegate
-(void)loginViewDidCancel:(WALoginResult *)result{

    
    UIAlertController *alertConrl = [UIAlertController
                                     alertControllerWithTitle:@"取消登录"
                                     message:[NSString stringWithFormat:@"用户取消登录 登录平台:%@",result.platform]
                                     preferredStyle:UIAlertControllerStyleAlert];
    [alertConrl addAction:[UIAlertAction actionWithTitle:@"Sure"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                 
    }]];

    
    [self presentViewController:alertConrl animated:true completion:nil];
    
    
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
    return UIInterfaceOrientationMaskAll;
}
@end

