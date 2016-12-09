//
//  GHWSDKAlertView.h
//  GHWSDKAlertView
//
//  Created by wuyx on 16/1/15.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum GHWAlertViewClicked{
    GHWAlertViewClickedButtonCancel = 1,
    GHWAlertViewClickedButtonOther
}GHWAlertViewClicked;
@interface WADemoAlertView : UIView
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* message;
@property(nonatomic,strong)NSString* cancelButtonTitle;
@property(nonatomic,strong)NSString* otherButtonTitles;
@property(nonatomic,strong)id delegate;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles block:(void(^)(GHWAlertViewClicked click))block;
-(void)show;
@end