//
//  WASDKAlertView.h
//  WASDKAlertView
//
//  Created by wuyx on 16/1/15.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WACommon/WACommon.h>
typedef enum WASDKAlertViewClicked{
    WASDKAlertViewClickedButtonCancel = 1,
    WASDKAlertViewClickedButtonOther
}WASDKAlertViewClicked;
@interface WASdkAlertView : UIView
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* message;
@property(nonatomic,strong)NSString* cancelButtonTitle;
@property(nonatomic,strong)NSString* otherButtonTitles;
@property(nonatomic,strong)id delegate;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles block:(void(^)(WASDKAlertViewClicked click))block;
-(void)show;
@end