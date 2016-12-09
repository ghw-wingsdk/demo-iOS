//
//  GHWConstants.h
//  GHWSdk
//
//  Created by GHW-T-01 on 15/5/21.
//  Copyright (c) 2015年 Wuyx. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef WA_Constants_h
#define WA_Constants_h


extern NSString *const WA_MODULE_USR;//用户模块
extern NSString *const WA_MODULE_PAY;//支付模块
extern NSString *const WA_MODULE_TRA;//数据收集模块
extern NSString *const WA_MODULE_SOC;//社交模块
extern NSString *const WA_MODULE_APW;//应用墙模块
extern NSString *const WA_MODULE_CORE;//公共模块
extern NSString *const WA_MODULE_HUP;//热更新模块

extern NSString *const WA_PLATFORM_FACEBOOK;
extern NSString *const WA_PLATFORM_APPLE;
extern NSString *const WA_PLATFORM_APPSFLYER;
extern NSString *const WA_PLATFORM_CHARTBOOST;
extern NSString *const WA_PLATFORM_WEBPAY;
extern NSString *const WA_PLATFORM_WINGA;
extern NSString *const WA_PLATFORM_BOACOMPRA;
extern NSString *const WA_PLATFORM_VK;
extern NSString *const WA_PLATFORM_WECHAT;


extern NSString *const WA_CONSTANT_GUEST;



extern NSString *const WA_XML_NODE_CONFIG;
extern NSString *const WA_XML_NODE_VERSION;
extern NSString *const WA_XML_NODE_SUPPORTS;
extern NSString *const WA_XML_NODE_COMP;

extern NSString *const WA_XML_ATTRIBUTE_KEY_VAL;
extern NSString *const WA_XML_ATTRIBUTE_KEY_MODULE;
extern NSString *const WA_XML_ATTRIBUTE_KEY_PLAF;
extern NSString *const WA_XML_ATTRIBUTE_KEY_VALUE;
extern NSString *const WA_XML_ATTRIBUTE_KEY_DESC;

//登录流程
extern const int WA_LOGIN_FLOW_TYPE_DEFAULT;
extern const int WA_LOGIN_FLOW_TYPE_REBIND;

//facebook permission
extern NSString *const WA_FB_PERMISSION_PUBLIC_PROFILE;
extern NSString *const WA_FB_PERMISSION_PUBLISH_ACTIONS;
extern NSString *const WA_FB_PERMISSION_USER_FRIENDS;
extern NSString *const WA_FB_PERMISSION_EMAIL;


//facebook action type
extern NSString *const WA_FB_ACTION_TYPE_NONE;
extern NSString *const WA_FB_ACTION_TYPE_SEND;
extern NSString *const WA_FB_ACTION_TYPE_ASKFOR;
extern NSString *const WA_FB_ACTION_TYPE_INVITE;

extern NSString *const WA_REQUEST_TYPE_SEND;
extern NSString *const WA_REQUEST_TYPE_ASKFOR;
extern NSString *const WA_REQUEST_TYPE_INVITE;
extern NSString *const WA_REQUEST_TYPE_REQUEST;


extern NSString *const WA_APPLE_IAPResultNotification;

//下面四个通知分别是绑定成功、绑定失败、解绑成功、解绑失败。当绑定有结果之后（无论成功失败），将回传一个WABindingResult实例。当解绑有结果（无论成功失败），将回传一个WAAccount实例。
extern NSString *const WABindDidSucceedNotification;//绑定成功
extern NSString *const WABindDidFailNotification;//绑定失败
extern NSString *const WAUnbindDidSucceedNotification;//解绑成功
extern NSString *const WAUnbindDidFailNotification;//解绑失败

// SDK类型
extern const int WA_SDK_TYPE_FR; // 国外
extern const int WA_SDK_TYPE_CN; // 国内

@interface WAConstants : NSObject {
    
}
#endif
@end
