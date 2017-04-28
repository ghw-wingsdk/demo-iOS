//
//  WAEventData.m
//  GHWSDKUI
//
//  Created by wuyx on 16/2/22.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import "WADemoEventData.h"
#import "WADemoEventParam.h"

static NSMutableArray* _waEventDataArray;
@implementation WADemoEventData

-(NSMutableArray *)params{
    if (!_params) {
        _params = [NSMutableArray array];
    }
    return _params;
}


+ (NSString*)getOts{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    // NSLog(@"date\n%lld", date); //1431931671 1431931690
    
    NSString *ots = [NSString stringWithFormat:@"%lld", date];
    return ots;
}

//-(NSMutableArray *)eventData{
//    if (!_eventData) {
//        _eventData = [self genarateData];
//    }
//    return _eventData;
//}
+(NSMutableArray*)genarateData{
 
    if (_waEventDataArray) {
        return _waEventDataArray;
    }
    
    NSMutableArray* _waEventDataArray = [NSMutableArray array];
    
    //*** event WAEventCompleteRegistration start ***
//    WADemoEventData* data1 = [[WADemoEventData alloc]init];
//    data1.eventName = WAEventCompleteRegistration;
//    data1.on = YES;
//    data1.eventNameOn = YES;
//    data1.paramDictOn = YES;
//    WADemoEventParam* param1_1 = [[WADemoEventParam alloc]init];
//    param1_1.paramName = WAEventParameterNameRegistrationMethod;
//    param1_1.paramDesc = @"string";
//    param1_1.paramType = GHWParamTypeString;
//    param1_1.paramDefValue = @"Facebook";
//    [data1.params addObject:param1_1];
//    WADemoEventParam* param1_2 = [[WADemoEventParam alloc]init];
//    param1_2.paramName = WAEventParameterNameGender;
//    param1_2.paramDesc = @"int(0,1,2)";
//    param1_2.paramType = GHWParamTypeInt;
//    [data1.params addObject:param1_2];
//    WADemoEventParam* param1_3 = [[WADemoEventParam alloc]init];
//    param1_3.paramName = WAEventParameterNameAge;
//    param1_3.paramDesc = @"int";
//    param1_3.paramType = GHWParamTypeInt;
//    [data1.params addObject:param1_3];
//    WADemoEventParam* param1_4 = [[WADemoEventParam alloc]init];
//    param1_4.paramName = WAEventParameterNameSuccess;
//    param1_4.paramDesc = @"bool";
//    param1_4.paramType = GHWParamTypeBool;
//    [data1.params addObject:param1_4];
//    [_waEventDataArray addObject:data1];
    //*** event WAEventCompleteRegistration end ***
    
    
    //*** event WAEventLogin start ***
    WADemoEventData* data2 = [[WADemoEventData alloc]init];
    data2.eventName = WAEventLogin;
    data2.on = YES;
    data2.eventNameOn = YES;
    data2.paramDictOn = YES;
    [_waEventDataArray addObject:data2];
    //*** event 2）	WAEventLogin end ***
    
    
    //*** event WAEventInitiatedPayment start ***
    WADemoEventData* data3 = [[WADemoEventData alloc]init];
    data3.eventName = WAEventInitiatedPayment;
    data3.on = YES;
    data3.eventNameOn = YES;
    data3.paramDictOn = YES;
    [_waEventDataArray addObject:data3];
    //*** event WAEventInitiatedPayment end ***
    
    //*** event WAEventPayment start ***
    WADemoEventData* data4 = [[WADemoEventData alloc]init];
    data4.eventName = WAEventPayment;
    data4.on = YES;
    data4.eventNameOn = YES;
    data4.paramDictOn = YES;
    WADemoEventParam* param4_1 = [[WADemoEventParam alloc]init];
    param4_1.paramName = WAEventParameterNameTransactionId;
    param4_1.paramDesc = @"string";
    param4_1.paramType = GHWParamTypeString;
    [data4.params addObject:param4_1];
    WADemoEventParam* param4_2 = [[WADemoEventParam alloc]init];
    param4_2.paramName = WAEventParameterNameCurrencyType;
    param4_2.paramDesc = @"string";
    param4_2.paramType = GHWParamTypeString;
    param4_2.paramDefValue = @"USD";
    [data4.params addObject:param4_2];
    WADemoEventParam* param4_3 = [[WADemoEventParam alloc]init];
    param4_3.paramName = WAEventParameterNameCurrencyAmount;
    param4_3.paramDesc = @"double";
    param4_3.paramType = GHWParamTypeDouble;
    [data4.params addObject:param4_3];
    WADemoEventParam* param4_4 = [[WADemoEventParam alloc]init];
    param4_4.paramName = WAEventParameterNameVirtualCoinAmount;
    param4_4.paramDesc = @"int";
    param4_4.paramType = GHWParamTypeInt;
    [data4.params addObject:param4_4];
    WADemoEventParam* param4_5 = [[WADemoEventParam alloc]init];
    param4_5.paramName = WAEventParameterNameIAPId;
    param4_5.paramDesc = @"string";
    param4_5.paramType = GHWParamTypeString;
    [data4.params addObject:param4_5];
    WADemoEventParam* param4_6 = [[WADemoEventParam alloc]init];
    param4_6.paramName = WAEventParameterNameIAPName;
    param4_6.paramDesc = @"string";
    param4_6.paramType = GHWParamTypeString;
    [data4.params addObject:param4_6];
    WADemoEventParam* param4_7 = [[WADemoEventParam alloc]init];
    param4_7.paramName = WAEventParameterNameIAPName;
    param4_7.paramDesc = @"int";
    param4_7.paramType = GHWParamTypeInt;
    [data4.params addObject:param4_7];
    [_waEventDataArray addObject:data4];
    //*** event WAEventPayment end ***
    
    
    //*** event WAEventInitiatedPurchase start ***
    WADemoEventData* data5 = [[WADemoEventData alloc]init];
    data5.eventName = WAEventInitiatedPurchase;
    data5.on = YES;
    data5.eventNameOn = YES;
    data5.paramDictOn = YES;
    [_waEventDataArray addObject:data5];
    //*** event WAEventInitiatedPurchase end ***
    
    //*** event WAEventPurchase start ***
    WADemoEventData* data6 = [[WADemoEventData alloc]init];
    data6.eventName = WAEventPurchase;
    data6.on = YES;
    data6.eventNameOn = YES;
    data6.paramDictOn = YES;
    WADemoEventParam* param6_1 = [[WADemoEventParam alloc]init];
    param6_1.paramName = WAEventParameterNameItemName;
    param6_1.paramDesc = @"string";
    param6_1.paramType = GHWParamTypeString;
    [data6.params addObject:param6_1];
    WADemoEventParam* param6_2 = [[WADemoEventParam alloc]init];
    param6_2.paramName = WAEventParameterNameItemAmount;
    param6_2.paramDesc = @"int";
    param6_2.paramType = GHWParamTypeInt;
    [data6.params addObject:param6_2];
    WADemoEventParam* param6_3 = [[WADemoEventParam alloc]init];
    param6_3.paramName = WAEventParameterNamePrice;
    param6_3.paramDesc = @"double";
    param6_3.paramType = GHWParamTypeDouble;
    [data6.params addObject:param6_3];
    [_waEventDataArray addObject:data6];
    //*** event WAEventPurchase end ***
    
    //*** event WAEventLevelAchieved start ***
    WADemoEventData* data7 = [[WADemoEventData alloc]init];
    data7.eventName = WAEventLevelAchieved;
    data7.on = YES;
    data7.eventNameOn = YES;
    data7.paramDictOn = YES;
    WADemoEventParam* param7_1 = [[WADemoEventParam alloc]init];
    param7_1.paramName = WAEventParameterNameLevel;
    param7_1.paramDesc = @"int";
    param7_1.paramType = GHWParamTypeInt;
    [data7.params addObject:param7_1];
    WADemoEventParam* param7_2 = [[WADemoEventParam alloc]init];
    param7_2.paramName = WAEventParameterNameScore;
    param7_2.paramDesc = @"int";
    param7_2.paramType = GHWParamTypeInt;
    [data7.params addObject:param7_2];
    WADemoEventParam* param7_3 = [[WADemoEventParam alloc]init];
    param7_3.paramName = WAEventParameterNameFighting;
    param7_3.paramDesc = @"int";
    param7_3.paramType = GHWParamTypeInt;
    [data7.params addObject:param7_3];
//    WADemoEventParam* param7_4 = [[WADemoEventParam alloc]init];
//    param7_4.paramName = WAEventParameterNameLevelInfo;
//    param7_4.paramDesc = @"string";
//    param7_4.paramType = GHWParamTypeString;
//    [data7.params addObject:param7_4];
//    WADemoEventParam* param7_5 = [[WADemoEventParam alloc]init];
//    param7_5.paramName = WAEventParameterNameLevelType;
//    param7_5.paramDesc = @"int(1,2,3,4,5)";
//    param7_5.paramType = GHWParamTypeInt;
//    param7_5.paramDefValue = @"1";
//    [data7.params addObject:param7_5];
//    WADemoEventParam* param7_6 = [[WADemoEventParam alloc]init];
//    param7_6.paramName = WAEventParameterNameDescription;
//    param7_6.paramDesc = @"string";
//    param7_6.paramType = GHWParamTypeString;
//    [data7.params addObject:param7_6];
    [_waEventDataArray addObject:data7];
    //*** event WAEventLevelAchieved end ***
    
    
    //*** event WAEventAddToCart start ***
//    WADemoEventData* data8 = [[WADemoEventData alloc]init];
//    data8.eventName = WAEventAddToCart;
//    data8.on = YES;
//    data8.eventNameOn = YES;
//    data8.paramDictOn = YES;
//    WADemoEventParam* param8_1 = [[WADemoEventParam alloc]init];
//    param8_1.paramName = WAEventParameterNamePrice;
//    param8_1.paramDesc = @"double";
//    param8_1.paramType = GHWParamTypeDouble;
//    [data8.params addObject:param8_1];
//    WADemoEventParam* param8_2 = [[WADemoEventParam alloc]init];
//    param8_2.paramName = WAEventParameterNameContentType;
//    param8_2.paramDesc = @"string";
//    param8_2.paramType = GHWParamTypeString;
//    [data8.params addObject:param8_2];
//    WADemoEventParam* param8_3 = [[WADemoEventParam alloc]init];
//    param8_3.paramName = WAEventParameterNameContentID;
//    param8_3.paramDesc = @"string";
//    param8_3.paramType = GHWParamTypeString;
//    [data8.params addObject:param8_3];
//    WADemoEventParam* param8_4 = [[WADemoEventParam alloc]init];
//    param8_4.paramName = WAEventParameterNameCurrencyType;
//    param8_4.paramDesc = @"string";
//    param8_4.paramType = GHWParamTypeString;
//    param8_4.paramDefValue = @"USD";
//    [data8.params addObject:param8_4];
//    WADemoEventParam* param8_5 = [[WADemoEventParam alloc]init];
//    param8_5.paramName = WAEventParameterNameQuantity;
//    param8_5.paramDesc = @"int";
//    param8_5.paramType = GHWParamTypeInt;
//    [data8.params addObject:param8_5];
//    [_waEventDataArray addObject:data8];
    //*** event WAEventAddToCart end ***
    
    
    //*** event WAEventAddToWishlist start ***
//    WADemoEventData* data9 = [[WADemoEventData alloc]init];
//    data9.eventName = WAEventAddToWishlist;
//    data9.on = YES;
//    data9.eventNameOn = YES;
//    data9.paramDictOn = YES;
//    WADemoEventParam* param9_1 = [[WADemoEventParam alloc]init];
//    param9_1.paramName = WAEventParameterNamePrice;
//    param9_1.paramDesc = @"double";
//    param9_1.paramType = GHWParamTypeDouble;
//    [data9.params addObject:param9_1];
//    WADemoEventParam* param9_2 = [[WADemoEventParam alloc]init];
//    param9_2.paramName = WAEventParameterNameContentType;
//    param9_2.paramDesc = @"string";
//    param9_2.paramType = GHWParamTypeString;
//    [data9.params addObject:param9_2];
//    WADemoEventParam* param9_3 = [[WADemoEventParam alloc]init];
//    param9_3.paramName = WAEventParameterNameContentID;
//    param9_3.paramDesc = @"string";
//    param9_3.paramType = GHWParamTypeString;
//    [data9.params addObject:param9_3];
//    WADemoEventParam* param9_4 = [[WADemoEventParam alloc]init];
//    param9_4.paramName = WAEventParameterNameCurrencyType;
//    param9_4.paramDesc = @"string";
//    param9_4.paramType = GHWParamTypeString;
//    param9_4.paramDefValue = @"USD";
//    [data9.params addObject:param9_4];
//    WADemoEventParam* param9_5 = [[WADemoEventParam alloc]init];
//    param9_5.paramName = WAEventParameterNameQuantity;
//    param9_5.paramDesc = @"int";
//    param9_5.paramType = GHWParamTypeInt;
//    [data9.params addObject:param9_5];
//    [_waEventDataArray addObject:data9];
    //*** event WAEventAddToWishlist end ***
    
    
    //*** event WAEventSearch start ***
//    WADemoEventData* data10 = [[WADemoEventData alloc]init];
//    data10.eventName = WAEventSearch;
//    data10.on = YES;
//    data10.eventNameOn = YES;
//    data10.paramDictOn = YES;
//    WADemoEventParam* param10_1 = [[WADemoEventParam alloc]init];
//    param10_1.paramName = WAEventParameterNameContentType;
//    param10_1.paramDesc = @"string";
//    param10_1.paramType = GHWParamTypeString;
//    [data10.params addObject:param10_1];
//    WADemoEventParam* param10_2 = [[WADemoEventParam alloc]init];
//    param10_2.paramName = WAEventParameterNameSearchString;
//    param10_2.paramDesc = @"string";
//    param10_2.paramType = GHWParamTypeString;
//    [data10.params addObject:param10_2];
//    WADemoEventParam* param10_3 = [[WADemoEventParam alloc]init];
//    param10_3.paramName = WAEventParameterNameSuccess;
//    param10_3.paramDesc = @"bool";
//    param10_3.paramType = GHWParamTypeBool;
//    [data10.params addObject:param10_3];
//    [_waEventDataArray addObject:data10];
    //*** event WAEventSearch end ***
    
    
    //*** event WAEventSpentCredits start ***
//    WADemoEventData* data11 = [[WADemoEventData alloc]init];
//    data11.eventName = WAEventSearch;
//    data11.on = YES;
//    data11.eventNameOn = YES;
//    data11.paramDictOn = YES;
//    WADemoEventParam* param11_1 = [[WADemoEventParam alloc]init];
//    param11_1.paramName = WAEventParameterNamePrice;
//    param11_1.paramDesc = @"double";
//    param11_1.paramType = GHWParamTypeDouble;
//    [data11.params addObject:param11_1];
//    WADemoEventParam* param11_2 = [[WADemoEventParam alloc]init];
//    param11_2.paramName = WAEventParameterNameContentType;
//    param11_2.paramDesc = @"string";
//    param11_2.paramType = GHWParamTypeString;
//    [data11.params addObject:param11_2];
//    WADemoEventParam* param11_3 = [[WADemoEventParam alloc]init];
//    param11_3.paramName = WAEventParameterNameContentType;
//    param11_3.paramDesc = @"string";
//    param11_3.paramType = GHWParamTypeString;
//    [data11.params addObject:param11_3];
//    [_waEventDataArray addObject:data11];
    //*** event WAEventSpentCredits end ***
    
    //*** event WAEventAchievementUnlocked start ***
//    WADemoEventData* data12 = [[WADemoEventData alloc]init];
//    data12.eventName = WAEventAchievementUnlocked;
//    data12.on = YES;
//    data12.eventNameOn = YES;
//    data12.paramDictOn = YES;
//    WADemoEventParam* param12_1 = [[WADemoEventParam alloc]init];
//    param12_1.paramName = WAEventParameterNameDescription;
//    param12_1.paramDesc = @"string";
//    param12_1.paramType = GHWParamTypeString;
//    [data12.params addObject:param12_1];
//    [_waEventDataArray addObject:data12];
    //*** event WAEventAchievementUnlocked end ***
    
    
    //*** event WAEventContentView start ***
//    WADemoEventData* data13 = [[WADemoEventData alloc]init];
//    data13.eventName = WAEventContentView;
//    data13.on = YES;
//    data13.eventNameOn = YES;
//    data13.paramDictOn = YES;
//    WADemoEventParam* param13_1 = [[WADemoEventParam alloc]init];
//    param13_1.paramName = WAEventParameterNamePrice;
//    param13_1.paramDesc = @"double";
//    param13_1.paramType = GHWParamTypeDouble;
//    [data13.params addObject:param13_1];
//    WADemoEventParam* param13_2 = [[WADemoEventParam alloc]init];
//    param13_2.paramName = WAEventParameterNameContentType;
//    param13_2.paramDesc = @"string";
//    param13_2.paramType = GHWParamTypeString;
//    [data13.params addObject:param13_2];
//    WADemoEventParam* param13_3 = [[WADemoEventParam alloc]init];
//    param13_3.paramName = WAEventParameterNameContentID;
//    param13_3.paramDesc = @"string";
//    param13_3.paramType = GHWParamTypeString;
//    [data13.params addObject:param13_3];
//    WADemoEventParam* param13_4 = [[WADemoEventParam alloc]init];
//    param13_4.paramName = WAEventParameterNameCurrencyType;
//    param13_4.paramDesc = @"string";
//    param13_4.paramType = GHWParamTypeString;
//    param13_4.paramDefValue = @"USD";
//    [data13.params addObject:param13_4];
//    [_waEventDataArray addObject:data13];
    //*** event WAEventContentView end ***
    
    
    //*** event WAEventShare start ***
//    WADemoEventData* data14 = [[WADemoEventData alloc]init];
//    data14.eventName = WAEventShare;
//    data14.on = YES;
//    data14.eventNameOn = YES;
//    data14.paramDictOn = YES;
//    WADemoEventParam* param14_1 = [[WADemoEventParam alloc]init];
//    param14_1.paramName = WAEventParameterNameDescription;
//    param14_1.paramDesc = @"string";
//    param14_1.paramType = GHWParamTypeString;
//    [data14.params addObject:param14_1];
//    [_waEventDataArray addObject:data14];
    //*** event WAEventShare end ***
    
    
    //*** event WAEventInvite start ***
//    WADemoEventData* data15 = [[WADemoEventData alloc]init];
//    data15.eventName = WAEventShare;
//    data15.on = YES;
//    data15.eventNameOn = YES;
//    data15.paramDictOn = YES;
//    WADemoEventParam* param15_1 = [[WADemoEventParam alloc]init];
//    param15_1.paramName = WAEventParameterNameDescription;
//    param15_1.paramDesc = @"string";
//    param15_1.paramType = GHWParamTypeString;
//    [data15.params addObject:param15_1];
//    [_waEventDataArray addObject:data15];
    //*** event WAEventShare end ***
    
    
    //*** event WAEventReEngage start ***
//    WADemoEventData* data16 = [[WADemoEventData alloc]init];
//    data16.eventName = WAEventShare;
//    data16.on = YES;
//    data16.eventNameOn = YES;
//    data16.paramDictOn = YES;
//    WADemoEventParam* param16_1 = [[WADemoEventParam alloc]init];
//    param16_1.paramName = WAEventParameterNameDescription;
//    param16_1.paramDesc = @"string";
//    param16_1.paramType = GHWParamTypeString;
//    [data16.params addObject:param16_1];
//    [_waEventDataArray addObject:data16];
    //*** event WAEventReEngage end ***
    
    //*** event WAEventUpdate start ***
//    WADemoEventData* data17 = [[WADemoEventData alloc]init];
//    data17.eventName = WAEventShare;
//    data17.on = YES;
//    data17.eventNameOn = YES;
//    data17.paramDictOn = YES;
//    [_waEventDataArray addObject:data17];
    //*** event WAEventUpdate end ***
    
    //*** event WAEventOpenedFromPushNotification start ***
//    WADemoEventData* data18 = [[WADemoEventData alloc]init];
//    data18.eventName = WAEventShare;
//    data18.on = YES;
//    data18.eventNameOn = YES;
//    data18.paramDictOn = YES;
//    [_waEventDataArray addObject:data18];
    //*** event WAEventOpenedFromPushNotification end ***
    
    
    //*** event WAEventUserCreate start ***
    WADemoEventData* data19 = [[WADemoEventData alloc]init];
    data19.eventName = WAEventUserCreate;
    data19.on = YES;
    data19.eventNameOn = YES;
    data19.paramDictOn = YES;
    WADemoEventParam* param19_1 = [[WADemoEventParam alloc]init];
    param19_1.paramName = WAEventParameterNameRoleType;
    param19_1.paramDesc = @"string";
    param19_1.paramType = GHWParamTypeString;
    [data19.params addObject:param19_1];
    WADemoEventParam* param19_2 = [[WADemoEventParam alloc]init];
    param19_2.paramName = WAEventParameterNameGender;
    param19_2.paramDesc = @"int(0,1,2)";
    param19_2.paramType = GHWParamTypeInt;
    [data19.params addObject:param19_2];
    WADemoEventParam* param19_3 = [[WADemoEventParam alloc]init];
    param19_3.paramName = WAEventParameterNameNickName;
    param19_3.paramDesc = @"string";
    param19_3.paramType = GHWParamTypeString;
    [data19.params addObject:param19_3];
    WADemoEventParam* param19_4 = [[WADemoEventParam alloc]init];
    param19_4.paramName = WAEventParameterNameRegisterTime;
    param19_4.paramDesc = @"string";
    param19_4.paramType = GHWParamTypeString;
    long registerTime = 1000*[[NSDate date]timeIntervalSince1970];
    param19_4.paramDefValue = [NSString stringWithFormat:@"%ld",registerTime];
    [data19.params addObject:param19_4];
    WADemoEventParam* param19_5 = [[WADemoEventParam alloc]init];
    param19_5.paramName = WAEventParameterNameVip;
    param19_5.paramDesc = @"int";
    param19_5.paramType = GHWParamTypeInt;
    [data19.params addObject:param19_5];
    WADemoEventParam* param19_6 = [[WADemoEventParam alloc]init];
    param19_6.paramName = WAEventParameterNameStatus;
    param19_6.paramDesc = @"int(-1,1)";
    param19_6.paramType = GHWParamTypeInt;
    param19_6.paramDefValue = @"-1";
    [data19.params addObject:param19_6];
    WADemoEventParam* param19_7 = [[WADemoEventParam alloc]init];
    param19_7.paramName = WAEventParameterNameBindGameGold;
    param19_7.paramDesc = @"int";
    param19_7.paramType = GHWParamTypeInt;
    [data19.params addObject:param19_7];
    WADemoEventParam* param19_8 = [[WADemoEventParam alloc]init];
    param19_8.paramName = WAEventParameterNameGameGold;
    param19_8.paramDesc = @"int";
    param19_8.paramType = GHWParamTypeInt;
    [data19.params addObject:param19_8];
    WADemoEventParam* param19_9 = [[WADemoEventParam alloc]init];
    param19_9.paramName = WAEventParameterNameLevel;
    param19_9.paramDesc = @"int";
    param19_9.paramType = GHWParamTypeInt;
    [data19.params addObject:param19_9];
    WADemoEventParam* param19_10 = [[WADemoEventParam alloc]init];
    param19_10.paramName = WAEventParameterNameFighting;
    param19_10.paramDesc = @"int";
    param19_10.paramType = GHWParamTypeInt;
    [data19.params addObject:param19_10];
    [_waEventDataArray addObject:data19];
    //*** event WAEventUserCreate end ***
    
    
    //*** event WAEventUserInfoUpdate start ***
    WADemoEventData* data20 = [[WADemoEventData alloc]init];
    data20.eventName = WAEventUserInfoUpdate;
    data20.on = YES;
    data20.eventNameOn = YES;
    data20.paramDictOn = YES;
    WADemoEventParam* param20_1 = [[WADemoEventParam alloc]init];
    param20_1.paramName = WAEventParameterNameNickName;
    param20_1.paramDesc = @"string";
    param20_1.paramType = GHWParamTypeString;
    [data20.params addObject:param20_1];
    WADemoEventParam* param20_2 = [[WADemoEventParam alloc]init];
    param20_2.paramName = WAEventParameterNameVip;
    param20_2.paramDesc = @"int";
    param20_2.paramType = GHWParamTypeInt;
    [data20.params addObject:param20_2];
    WADemoEventParam* param20_3 = [[WADemoEventParam alloc]init];
    param20_3.paramName = WAEventParameterNameRoleType;
    param20_3.paramDesc = @"string";
    param20_3.paramType = GHWParamTypeString;
    [data20.params addObject:param20_3];
    [_waEventDataArray addObject:data20];
    //*** event WAEventOpenedFromPushNotification end ***
    
    
    //*** event WAEventGoldUpdate start ***
    WADemoEventData* data21 = [[WADemoEventData alloc]init];
    data21.eventName = WAEventGoldUpdate;
    data21.on = YES;
    data21.eventNameOn = YES;
    data21.paramDictOn = YES;
    WADemoEventParam* param21_1 = [[WADemoEventParam alloc]init];
    param21_1.paramName = WAEventParameterNameGoldType;
    param21_1.paramDesc = @"string";
    param21_1.paramType = GHWParamTypeString;
    param21_1.paramDefValue = @"1";
    [data21.params addObject:param21_1];
    WADemoEventParam* param21_2 = [[WADemoEventParam alloc]init];
    param21_2.paramName = WAEventParameterNameApproach;
    param21_2.paramDesc = @"string";
    param21_2.paramType = GHWParamTypeString;
    [data21.params addObject:param21_2];
    WADemoEventParam* param21_3 = [[WADemoEventParam alloc]init];
    param21_3.paramName = WAEventParameterNameAmount;
    param21_3.paramDesc = @"int";
    param21_3.paramType = GHWParamTypeInt;
    [data21.params addObject:param21_3];
    WADemoEventParam* param21_4 = [[WADemoEventParam alloc]init];
    param21_4.paramName = WAEventParameterNameCurrentAmount;
    param21_4.paramDesc = @"int";
    param21_4.paramType = GHWParamTypeInt;
    [data21.params addObject:param21_4];
    [_waEventDataArray addObject:data21];
    //*** event WAEventGoldUpdate end ***
    
    //*** event WAEventTaskUpdate start ***
    WADemoEventData* data22 = [[WADemoEventData alloc]init];
    data22.eventName = WAEventTaskUpdate;
    data22.on = YES;
    data22.eventNameOn = YES;
    data22.paramDictOn = YES;
    WADemoEventParam* param22_1 = [[WADemoEventParam alloc]init];
    param22_1.paramName = WAEventParameterNameTaskId;
    param22_1.paramDesc = @"string";
    param22_1.paramType = GHWParamTypeString;
    [data22.params addObject:param22_1];
    WADemoEventParam* param22_2 = [[WADemoEventParam alloc]init];
    param22_2.paramName = WAEventParameterNameTaskName;
    param22_2.paramDesc = @"string";
    param22_2.paramType = GHWParamTypeString;
    [data22.params addObject:param22_2];
    WADemoEventParam* param22_3 = [[WADemoEventParam alloc]init];
    param22_3.paramName = WAEventParameterNameTaskType;
    param22_3.paramDesc = @"string";
    param22_3.paramType = GHWParamTypeString;
    [data22.params addObject:param22_3];
    WADemoEventParam* param22_4 = [[WADemoEventParam alloc]init];
    param22_4.paramName = WAEventParameterNameTaskStatus;
    param22_4.paramDesc = @"int(1,2,3,4)";
    param22_4.paramType = GHWParamTypeString;
    [data22.params addObject:param22_4];
    [_waEventDataArray addObject:data22];
    //*** event WAEventTaskUpdate end ***
    
    
    //*** event WAEventUserImport start ***
    WADemoEventData* data23 = [[WADemoEventData alloc]init];
    data23.eventName = WAEventUserImport;
    data23.on = YES;
    data23.eventNameOn = YES;
    data23.paramDictOn = YES;
    WADemoEventParam* param23_1 = [[WADemoEventParam alloc]init];
    param23_1.paramName = WAEventParameterNameIsFirstEnter;
    param23_1.paramDesc = @"int(0,1)";
    param23_1.paramType = GHWParamTypeInt;
    [data23.params addObject:param23_1];
    WADemoEventParam* param23_2 = [[WADemoEventParam alloc]init];
    param23_2.paramName = WAEventParameterNameServerId;
    param23_2.paramDesc = @"string";
    param23_2.paramType = GHWParamTypeString;
    [data23.params addObject:param23_2];
    [_waEventDataArray addObject:data23];
    //*** event WAEventUserImport end ***

    return _waEventDataArray;
}


+(WADemoEventData*)dealWithData:(WADemoEventData*)data{
    data.value = @"0";
    [data.params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WADemoEventParam* eventParamObj = obj;
        if (!eventParamObj.paramDefValue) {
            if (eventParamObj.paramType == GHWParamTypeString) {
                eventParamObj.paramDefValue = eventParamObj.paramName;
            }else{
                eventParamObj.paramDefValue = @"0";
            }
        }
    }];
    return data;
}

+(WADemoEventData*)getEventDataWithEventName:(NSString*)eventName{
    
    NSMutableArray* eventDataArray = [self genarateData];
    
    __block WADemoEventData* eventData;
    __block BOOL isCustom = YES;
    [eventDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WADemoEventData* eventDataObj = obj;
        if ([eventDataObj.eventName isEqualToString:eventName]) {
            isCustom = NO;
            eventData = eventDataObj;
            [self dealWithData:eventData];
            *stop = YES;
        }
    }];
    
    if (isCustom) {
        eventData = [[WADemoEventData alloc]init];
        eventData.eventName = eventName;
        eventData.on = YES;
        eventData.eventNameOn = YES;
        eventData.paramDictOn = YES;
    }
    
    return eventData;
}
@end
