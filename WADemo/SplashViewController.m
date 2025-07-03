//
//  SplashViewController.m
//  WADemo
//
//  Created by lpw on 2024/6/17.
//

#import "SplashViewController.h"
#import "AppDelegate.h"
#import "WADemoUtil.h"
#import <WACommon/WACommon.h>

@interface SplashViewController ()<GADFullScreenContentDelegate>

@end

static const NSInteger CounterTime = 5;

@implementation SplashViewController {
  /// Number of seconds remaining to show the app open ad.
  NSInteger _secondsRemaining;
  /// The countdown timer.
  NSTimer *_countdownTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
//    self.splashScreenLabel =[[UILabel alloc] initWithFrame:self.view.bounds];
//    self.splashScreenLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.splashScreenLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAdmobUMPStatusNotification:)
                                                 name:WASDK_ADMOB_UMP_STATUS_NOTIFICATION
                                               object:nil];
    
    [self startTimer];
    
}

BOOL umpStatus = NO;
- (void)handleAdmobUMPStatusNotification:(NSNotification *)notification {
    NSDictionary *admobUMPResultDic = notification.userInfo;
    NSString *status = admobUMPResultDic[@"status"];
    NSError * error =admobUMPResultDic[@"error"];
    NSLog(@"handleAdmobUMPStatusNotification Status: %@", status);
    umpStatus= [status intValue];

    if (!umpStatus) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"admob sdk初始化失败"
                                                                                  message:error.localizedDescription
                                                                           preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"进入游戏"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
             
             
             umpStatus =YES;
                                                              NSLog(@"OK button tapped");
//             UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//             UIViewController *navigationController = (UIViewController *)[mainStoryBoard
//                 instantiateViewControllerWithIdentifier:@"ViewController"];
//
//             AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//             UIWindow *window = appDelegate.window;
//             window.rootViewController=navigationController;
             
                                                       
         }];
         
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"退出"
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction *action) {
                                                                  NSLog(@"Cancel button tapped");
             exit(0);
                                                              }];
         
         [alertController addAction:okAction];
         [alertController addAction:cancelAction];
         
         [self presentViewController:alertController animated:YES completion:nil];    }
}


- (void)startShowAd {

    
    // 检测admob 广告同意是否可用
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (!umpStatus) {
            [NSThread sleepForTimeInterval:1]; // 每1秒检查一次
//            NSLog(@"Waiting for umpStatus to be YES.");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (umpStatus) {
                
                NSLog(@" 开屏页---umpStatus  be YES.");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [WAAdMobProxy showAppOpenAdWithViewController:self withDelegate:self];
                });
                

            }
        });
    });
    
    
    



    
}

- (void)enterMainPage{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *navigationController = (UIViewController *)[mainStoryBoard
        instantiateViewControllerWithIdentifier:@"ViewController"];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = appDelegate.window;
    window.rootViewController=navigationController;
    
}
- (void)startTimer {
  _secondsRemaining = CounterTime;
  self.splashScreenLabel.text = [NSString stringWithFormat:@"App is done loading in: %ld",
                                 (long)_secondsRemaining];
  _countdownTimer = [NSTimer
                     scheduledTimerWithTimeInterval:1.0
                     target:self
                     selector:@selector(decrementCounter)
                     userInfo:nil
                     repeats:YES];
}
- (void)decrementCounter {
  _secondsRemaining--;
  if (_secondsRemaining > 0) {
    self.splashScreenLabel.text = [NSString stringWithFormat:@"App is done loading in: %ld",
                                   (long)_secondsRemaining];
    return;
  }else{
      
      [self startShowAd];

      
      
  }

  self.splashScreenLabel.text = @"Done.";
  [_countdownTimer invalidate];
  _countdownTimer = nil;

}

- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad{}

/// Tells the delegate that a click has been recorded for the ad.
- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad{}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
didFailToPresentFullScreenContentWithError:(nonnull NSError *)error{
    
    NSLog(@"开屏页=====didFailToPresentFullScreenContentWithError.");

    [self enterMainPage];

}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{
    
    [self enterMainPage];
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


