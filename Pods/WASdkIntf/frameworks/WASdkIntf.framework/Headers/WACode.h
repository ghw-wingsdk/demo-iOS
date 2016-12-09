//
//  WACode.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/22.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#ifndef WACode_h
#define WACode_h

typedef enum WACode{
    WACodeSuccess = 200 ,//成功
    WACodeError = 400 ,//错误
    WACodeUnautherized = 401 ,//请求未认证：访问受限资源是缺少认证信息，或者认证未通过
    WACodeForbiden = 403 ,//禁止访问：由于应用上下文原因或请求端上下文的原因被禁止访问资源，例如IP限制等
    WACodeNotFound = 404 ,//找不到被访问资源：接口不存在、页面不存在或对应的业务实体找不到
    WACodeServerError = 500 ,//服务器内部故障
    WACodeApiInvalid = 501 ,//所请求接口或页面未实现
    WACodeSdkAppIdInvalid = 4010 ,//无效appId: appId不存在或未开启
    WACodeSignError = 4011 ,//无效osign：osign校验失败
    WACodeRequestTimeOut = 4012 ,//请求已过期：ots校验失败
    WACodePlatformVerifyError = 4013 ,//第三方平台验证失败
    WACodeAccountVerifyError = 4014 ,//访客登录验证失败，登录验证失败
    WACodePlatformBoundAlready = 4015 ,//用户已经绑定了这个平台的其他账户
    WACodePrePlatformVerifyError = 4016 ,//prePlatform验证失败
    WACodeUserNotFound = 4017 ,//用户不存在（没有找到）
    WACodeAccountBoundByOthers = 4018 ,//账户已经被其他用户绑定
    WACodeOrderIdInvalid = 4019 ,//无效orderId
    WACodeOrderVerifyError = 4020 ,//订单验证失败
    WACodeRewardNotFound = 4021 ,//FB邀请奖励事件未找到奖励政策
    WACodeRepeatCrashReport = 4022 ,//闪退发送报告重复
    WACodeChannelNotFound = 4023 ,//未找到渠道信息
    WACodeCanNotUnbind = 4024 ,//不可以进行解绑操作
    WACodeExchangeRateConversionFailure = 4025 ,//汇率转换失败
    WACodePayPlatformClosed = 4026 ,//支付渠道已关闭
    WACodeLoginPlatformClosed = 4029 ,//登录渠道已关闭
    WACodeCanNotSwitchToAnonymous = 5001 ,
    WACodeFbObjectType = 5002 ,//facebook的objectType不能为空
    WACodeFbGiftListRequestPrameterLack = 5003 ,//请求gift列表缺少appid,appSecret,objectType参数
    WACodeFbTokenNull = 5004 ,//facebook token为空
    WACodeCanNotMakePayment = 5005 ,//该设备不能支付或者不允许支付
    WACodePaymentError = 5006 ,//支付过程中出错
    WACodeCancelled = -100 ,//取消操作
    WACodeSdkUninitialized = -200 ,//SDK没有初始化
    WACodeContentCanNotBeShared = -201 ,//内容不可分享，一般是传入的内容为空，或者其他
    WACodeNotLogin = -202 ,//没有登录
    WACodeLoginFailure = -203 ,//登录失败
    WACodeNoPermission = -204 ,//登录没有获取到相应的权限
    WACodeFileSizeLimit = -206 ,//文件大小超出限制 不超过12M
    WACodeCurrentIDNotMatch = -211 ,//当前平台账号跟当前WA UserId绑定的平台账号不一致,或者没有绑定该平台账号
    WACodeDeviceNotSupported = -401 ,//设备不支持
    WACodeNetworkUnavailable = -402 ,//网络不可用
    WACodePayReOrderTimeLimit = -509 //支付流程未完成或者在特定的时间内重复下订单
    
}WACode;

#endif /* WACode_h */
