//
//  GHWAppleLogin.h
//  GHWSdk
//
//  Created by wuyx on 15/5/17.
//  Copyright (c) 2015年 Wuyx. All rights reserved.
//
#import <GameKit/GameKit.h>
#import <WASdkIntf/WASdkIntf.h>
#import "WAAPLoginInfo.h"
typedef enum APLoginError{
    APLoginErrorIOS7 = 30
}APLoginError;
@interface WAAPLogin : NSObject
// currentPlayerID is the value of the playerID last time GameKit authenticated.
@property (retain,readwrite) NSString* currentPlayerID;

// isGameCenterAuthenticationComplete is set after authentication, and authenticateWithCompletionHandler's completionHandler block has been run. It is unset when the applicaiton is backgrounded.
@property (readwrite, getter=isGameCenterAuthenticationComplete) BOOL gameCenterAuthenticationComplete;
+(id)shareInstance;
-(void)loginWithCompletionHandler:(void (^)(WAAPLoginInfo* loginInfo, NSError *error))completionHandler;
@end
