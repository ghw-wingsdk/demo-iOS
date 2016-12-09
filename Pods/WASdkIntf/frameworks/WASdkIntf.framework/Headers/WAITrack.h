//
//  WAITrack.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAITrack : NSObject
@property(strong,nonatomic)NSMutableDictionary *params;
@property(nonatomic)double value;
@property(copy,nonatomic)NSString* eventName;

-(void)initTracker;
-(void)trackWithEventName:(NSString *const)eventName valueToSum:(double)value params:(NSDictionary*)params;
-(void)autoTriggerAfterPayment:(BOOL)isAuto;
-(BOOL)getAutoTriggerAfterPayment;
-(NSString*)getCollectionInfo;


-(void)eventNameTransfer:(NSString *)eventName;
/**
 *  安装游戏
 */
-(void)launch;
/**
 *  打开游戏
 */
-(void)startUp;
/**
 *  注册账号
 */
-(void)register_;
/**
 *  登录游戏
 */
-(void)login;
/**
 *  点击充值
 */
-(void)initiatedPayment;
/**
 *  充值完成
 */
-(void)payment;
/**
 *  点击购买
 */
-(void)initiatedPurchase;
/**
 *  购买完成
 */
-(void)purchase;
/**
 *  在线时长
 */
-(void)heartbeat;
/**
 *  等级或分数
 */
-(void)levelAchieve;
/**
 *  加入购物车
 */
-(void)addToCart;
/**
 *  兴趣标记/愿望
 */
-(void)addToWishlist;
/**
 *  搜索内容
 */
-(void)search;
/**
 *  使用信用点消费
 */
-(void)spentCredits;
/**
 *  完成解锁事件
 */
-(void)achievementUnlocked;
/**
 *  追踪内容查看事件
 */
-(void)contentView;
/**
 *  分享事件
 */
-(void)share;
/**
 *  邀请事件
 */
-(void)invite;
/**
 *  重新连接到游戏
 */
-(void)reEngage;
/**
 *  更新游戏
 */
-(void)update;
/**
 *  打开推送通知
 */
-(void)openedFromPushNotification;
/**
 *  创建角色
 */
-(void)userCreate;
/**
 *  用户资料更新
 */
-(void)userInfoUpdate;
/**
 *  玩家任务统计
 */
-(void)taskUpdate;
/**
 *  货币状况变更
 */
-(void)goldUpdate;
/**
 * 用户资料初始化
 */
-(void)userInfoInit;
/**
 *  导入用户事件
 */
-(void)userImport;
/**
 *  自定义事件
 */
-(void)custom;

@end
