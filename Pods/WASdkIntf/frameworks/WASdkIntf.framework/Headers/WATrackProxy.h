//
//  WATrackProxy.h
//  WASdkIntfUI
//
//  Created by WA-T-01 on 16/3/1.
//  Copyright © 2016年 WA-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

//数据类型
typedef enum WAParameterType{
    WAParameterTypeString,
    WAParameterTypeInt,
    WAParameterTypeDouble,
    WAParameterTypeBool,
    WAParameterTypeEnumThree,
    WAParameterTypeData
}WAParameterType;

//支付类型
typedef enum WAEnumPaymentType{
    WAEnumPaymentTypeGoogle,
    WAEnumPaymentTypeApple,
    WAEnumPaymentTypeFree
}WAEnumPaymentType;

//性别
typedef enum WAEnumGender{
    WAEnumGenderFemale,
    WAEnumGenderMale,
    WAEnumGenderUnknown
}WAEnumGender;

//levelType
typedef enum WALevelType{
    // Highest level reached
    WALevelTypeHighestLevelReached  = 1,
    // Current area level reached
    WALevelTypeCurrentArea  = 2,
    // Current character level reached
    WALevelTypeCharacterLevel  = 3,
    // Other sequential level reached
    WALevelTypeOtherSequential   = 4,
    // Current non sequential level reached
    WALevelTypeOtherNonsequential = 5
    
} WALevelType;




extern NSString* WAEventParameterNameCustomMethodPrefix;//自定义事件名称前缀


extern NSString *const WAEventLaunch;
extern NSString *const WAEventStartUp;
extern NSString *const WAEventCompleteRegistration;
extern NSString *const WAEventLogin;
extern NSString *const WAEventInitiatedPayment;
extern NSString *const WAEventPayment;
extern NSString *const WAEventInitiatedPurchase;
extern NSString *const WAEventPurchase;
extern NSString *const WAEventHeartBeat;
extern NSString *const WAEventLevelAchieved;
extern NSString *const WAEventAddToCart;
extern NSString *const WAEventAddToWishlist;
extern NSString *const WAEventSearch;
extern NSString *const WAEventSpentCredits;
extern NSString *const WAEventAchievementUnlocked;
extern NSString *const WAEventContentView;
extern NSString *const WAEventShare;
extern NSString *const WAEventInvite;
extern NSString *const WAEventReEngage;
extern NSString *const WAEventUpdate;
extern NSString *const WAEventOpenedFromPushNotification;
extern NSString *const WAEventUserInfoUpdate;
extern NSString *const WAEventUserCreate;
extern NSString *const WAEventTaskUpdate;
extern NSString *const WAEventGoldUpdate;
extern NSString *const WAEventUserImport;

extern NSString *const WAEventParameterNameRegistrationMethod;

extern NSString *const WAEventParameterNameCurrencyType;
extern NSString *const WAEventParameterNamePrice;
extern NSString *const WAEventParameterNameContentType;
extern NSString *const WAEventParameterNameContentID;
extern NSString *const WAEventParameterNameQuantity;
extern NSString *const WAEventParameterNameSearchString;
extern NSString *const WAEventParameterNameSuccess ;
extern NSString *const WAEventParameterNameMaxRatingValue;
extern NSString *const WAEventParameterNamePaymentInfoAvailable;
extern NSString *const WAEventParameterNameItemAmount;
extern NSString *const WAEventParameterNameItemName;//道具名称
extern NSString *const WAEventParameterNameItemId;
extern NSString *const WAEventParameterNameLevel ;
extern NSString *const WAEventParameterNameLevelInfo;
extern NSString *const WAEventParameterNameLevelType;
extern NSString *const WAEventParameterNameScore;
extern NSString *const WAEventParameterNameDescription ;

extern NSString *const WAEventParameterNameGender;
extern NSString *const WAEventParameterNameAge;
extern NSString *const WAEventParameterNameAccountType;
extern NSString *const WAEventParameterNameDeviceId;
extern NSString *const WAEventParameterNameIDFA;
extern NSString *const WAEventParameterNameServerId;

extern NSString *const WAEventParameterNameStartTime;
extern NSString *const WAEventParameterNameNowTime;

extern NSString *const WAEventParameterNameTransactionId;
extern NSString *const WAEventParameterNamePaymentType;
extern NSString *const WAEventParameterNameCurrencyAmount;
extern NSString *const WAEventParameterNameVirtualCoinAmount;
extern NSString *const WAEventParameterNameVirtualCurrency;
extern NSString *const WAEventParameterNameIAPName;
extern NSString *const WAEventParameterNamePaymentType;
extern NSString *const WAEventParameterNameIAPAmount;
extern NSString *const WAEventParameterNameIAPId;
extern NSString *const WAEventParameterNameReceipt;
extern NSString *const WAEventParameterNameProductIdentifier;

extern NSString *const WAEventParameterNameIsFirstEnter;

extern NSString *const WAEventParameterNameTZ;//时区
extern NSString *const WAEventParameterNameDevice;//设备
extern NSString *const WAEventParameterNameProduct;//设备产品
extern NSString *const WAEventParameterNameModel;//设备版本
extern NSString *const WAEventParameterNameDeviceType;//类型
extern NSString *const WAEventParameterNameDeviceBrand;//品牌
extern NSString *const WAEventParameterNameOP;//运营商
extern NSString *const WAEventParameterNameNetwork;//网络制式
extern NSString *const WAEventParameterNameOS;//系统
extern NSString *const WAEventParameterNameResolution;//分辨率




extern NSString *const WAEventParameterNameOsign;

//创建角色
extern NSString *const WAEventParameterNameRegisterTime;//注册时间

//玩家任务统计
extern NSString *const WAEventParameterNameTaskId;//任务id
extern NSString *const WAEventParameterNameTaskName;//任务名称
extern NSString *const WAEventParameterNameTaskType;//任务类型
extern NSString *const WAEventParameterNameTaskStatus;//任务状态


//用户资料更新
extern NSString *const WAEventParameterNameNickName;//角色名称
extern NSString *const WAEventParameterNameVip;//vip等级
extern NSString *const WAEventParameterNameStatus;//状态
extern NSString *const WAEventParameterNameGameUserId;//游戏角色Id
extern NSString *const WAEventParameterNameBindGameGold;//绑定钻石
extern NSString *const WAEventParameterNameGameGold;//用户钻石数
extern NSString *const WAEventParameterNameFighting;//战斗力
extern NSString *const WAEventParameterNameRoleType;

//货币状况变更
extern NSString *const WAEventParameterNameGoldType;//货币类型
extern NSString *const WAEventParameterNameApproach;//变更途径
extern NSString *const WAEventParameterNameCurrentAmount;//当前货币数量
extern NSString *const WAEventParameterNameAmount;//变更货币数

//支付类型
extern NSString *const WAValueForPaymentTypeApple;
extern NSString *const WAValueForPaymentTypeGoogle;
extern NSString *const WAValueForPaymentTypeFree;




/*!
 @discussion WATrackProxy 该类用来做数据收集
 - - -
 */
@interface WATrackProxy : NSObject
/*!
 @discussion 该方法用来发送数据到各个渠道
 @param eventName 事件名称
 @param value 累加值
 @param params 参数
 */
+(void)trackWithEventName:(NSString *const)eventName valueToSum:(double)value params:(NSDictionary*)params;
/*!
 @discussion 该方法用来发送数据到指定渠道
 @param eventName 事件名称
 @param value 累加值
 @param params 参数
 @param platform 渠道
 */
+(void)trackWithEventName:(NSString *const)eventName valueToSum:(double)value params:(NSDictionary*)params platform:(NSString *const)platform;
/*!
 @abstract 获取collectionInfo
 */
+(NSString*)getCollectionInfo;

/*!
 @discussion 设置点击充值事件(WAEventInitiatedPayment)和充值完成事件(WAEventPayment)是否自动统计,默认为自动统计
 @param isAuto 是否自动统计事件
 */

+(void)autoTriggerAfterPayment:(BOOL)isAuto;
+(BOOL)getAutoTriggerAfterPayment;
+(void)checkParams:(NSDictionary*)params eventName:(NSString*)eventName;
@end
