//
//  SplashViewController.m
//  WADemo
//
//  Created by lpw on 2024/6/17.
//

#import "SplashViewController.h"
#import "AppDelegate.h"
#import "WADemoUtil.h"
@interface SplashViewController ()

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
    
    [self startTimer];
    
}
- (void)startMainScreen {
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
      [self startMainScreen];
      
  }

  self.splashScreenLabel.text = @"Done.";
  [_countdownTimer invalidate];
  _countdownTimer = nil;

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

