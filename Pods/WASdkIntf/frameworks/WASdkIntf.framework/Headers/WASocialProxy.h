//
//  WASocialProxy.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WASharingDelegate,WASharingContent,WAAppInviteDialogDelegate,WAGameRequestDialogDelegate;
@class WAAppInviteContent,WAGameRequestContent,WAAppUser,WAFBObject,WAFBAppRequest;
/*!
 @discussion The common interface for components that initiate sharing.
 */
@protocol WASharing <NSObject>

/*!
 @abstract The receiver's delegate or nil if it doesn't have a delegate.
 */
@property (nonatomic, weak) NSObject<WASharingDelegate>* delegate;

/*!
 @abstract The content to be shared.
 */
@property (nonatomic, strong) NSObject<WASharingContent>* shareContent;

/*!
 @abstract A Boolean value that indicates whether the receiver should fail if it finds an error with the share content.
 @discussion If NO, the sharer will still be displayed without the data that was mis-configured.  For example, an
 invalid placeID specified on the shareContent would produce a data error.
 */
@property (nonatomic, assign) BOOL shouldFailOnDataError;


@end

/*!
 @discussion The common interface for dialogs that initiate sharing.
 - - -
 */
@protocol WASharingDialog <WASharing>

/*!
 @abstract A Boolean value that indicates whether the receiver can initiate a share.
 @discussion May return NO if the appropriate Facebook app is not installed and is required or an access token is
 required but not available.  This method does not validate the content on the receiver, so this can be checked before
 building up the content.
 @see [WASharing validateWithError:]
 @result YES if the receiver can share, otherwise NO.
 */
- (BOOL)canShow;

/*!
 @abstract Shows the dialog.
 @result YES if the receiver was able to begin sharing, otherwise NO.
 */
- (BOOL)show;

@end

/*!
 @abstract A delegate for WASharing.
 @discussion The delegate is notified with the results of the sharer as long as the application has permissions to
 receive the information.  For example, if the person is not signed into the containing app, the sharer may not be able
 to distinguish between completion of a share and cancellation.
 */
@protocol WASharingDelegate <NSObject>

/*!
 @abstract Sent to the delegate when the share completes without error or cancellation.
 @param sharer The WASharing that completed.
 @param platform The platform that the sharing from
 @param results The results from the sharer.  This may be nil or empty.
 */
- (void)sharer:(NSObject<WASharing>*)sharer platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results;

/*!
 @abstract Sent to the delegate when the sharer encounters an error.
 @param sharer The WASharing that completed.
 @param platform The platform that the sharing from
 @param error The error.
 */
- (void)sharer:(NSObject<WASharing>*)sharer platform:(NSString *const)platform didFailWithError:(NSError *)error;

/*!
 @abstract Sent to the delegate when the sharer is cancelled.
 @param sharer The WASharing that completed.
 @param platform The platform that the sharing from
 */
- (void)sharerDidCancel:(NSObject<WASharing>*)sharer platform:(NSString *const)platform;
@end

/*!
 @discussion WASocialProxy 该类用来做分享、游戏邀请、收发礼物等。
 - - -
 */
@interface WASocialProxy : NSObject
/*!
 #分享调用方法
 */
/*!
 @abstract 分享调用方法
 @param platform 平台
 @param shareContent 分享内容
 @param delegate 委托
 */
+(void)shareWithPlatform:(NSString *const)platform shareContent:(NSObject<WASharingContent>*)shareContent shareWithUI:(BOOL)shareWithUI delegate:(NSObject<WASharingDelegate>*)delegate;
/*!
 @abstract 应用邀请调用方法
 @param content 内容
 @param delegate 委托
 */
+(void)appInviteWithPlatform:(NSString *const)platform Content:(WAAppInviteContent*)content delegate:(NSObject<WAAppInviteDialogDelegate>*)delegate;
/*!
 @abstract Game Service - 获取可邀请好友列表
 @param duration 邀请有效时段,既是邀请好友成功之后,该好友在有效时段之内,不会再出现在可邀请好友列表之中.单位为分钟,不设置默认为0.
 @param platform 平台
 @param block 回调
 */
+(void)queryInvitableFriendsWithDuration:(float)duration platform:(NSString *const)platform completeBlock:(void(^)(NSArray* friends,NSError *error))block;
/*!
 @abstract Game Service - 向好友发送邀请
 @param content 内容
 @param delegate 委托
 */
+(void)gameInviteWithPlatform:(NSString *const)platform Content:(WAGameRequestContent*)content delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;
/*!
 @abstract Game Service - 查询赠送/索要礼物的好友列表
 @param platform 平台
 @param block 回调
 */
+(void)queryFriendsWithPlatform:(NSString *const)platform completeBlock:(void(^)(NSArray* friends,NSError *error))block ;
/*!
 @abstract 获取当前App所属的group
 @param platform 平台
 @param block 回调
 */
+(void)getCurrentAppLinkedGroupWithPlatfrom:(NSString *const)platform extInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;
/*!
 @abstract 获取当前user所属的group
 @param platform 平台
 @param block 回调
 */
+(void)getCurrentUserGroupWithPlatfrom:(NSString *const)platform extInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;

/*!
 @abstract 根据groupId查询对应的group
 @param platform 平台
 @param groupIds groupId数组
 @param block 回调
 */
+(void)getGroupWithPlatform:(NSString *const)platform groupIds:(NSArray*)groupIds extInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;

/*!
 @abstract 返回当前应用推荐的所有group
 @param platform 平台
 @param extInfo 扩展字段
 @param block 回调
 */
+(void)getGroupsWithPlatform:(NSString *const)platform extInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;

/*!
 @abstract 加入group
 @param platform 平台
 @param groupId group标识
 @param extInfo 扩展信息
 @param block 回调
 */
+(void)joinGroupWithPlatform:(NSString *const)platform groupId:(NSString*)groupId extInfo:(NSString *const)extInfo completeBlock:(void(^)(NSError* error))block;

/*!
 @abstract 打开group
 @param platform 平台
 @param groupUri
 @param extInfo 扩展信息
 @param block 回调
 */
+(void)openGroupPageWithPlatform:(NSString *const)platform groupUri:(NSString *const)groupUri extInfo:(NSString*)extInfo;

/*!
 @abstract Game Service - 查询礼物列表
 @param objectType 内容
 @param block 回调
 */
+(void)queryFBGraphObjectsWithObjectType:(NSString*)objectType completeBlock:(void(^)(NSArray<WAFBObject*>* objects,NSError *error))block;
/*!
 @abstract Game Service - 赠送礼物
 @param content 内容
 @param delegate 委托
 */
+(void)fbSendGiftWithContent:(WAGameRequestContent*)content delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;

/*!
 @abstract Game Service - 索要礼物
 @param content 内容
 @param delegate 委托
 */
+(void)fbAskForGiftWithContent:(WAGameRequestContent*)content delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;
/*!
 @abstract Game Service - 查看收到的礼物
 @param block 回调
 */
+(void)fbQueryReceivedGiftsWithCompleteBlock:(void(^)(NSArray<WAFBAppRequest *>* gifts,NSError *error))block;
/*!
 @abstract Game Service - 查看好友向自己索要礼物请求
 @param block 回调
 */
+(void)fbQueryAskForGiftRequestsWithCompleteBlock:(void(^)(NSArray<WAFBAppRequest *>* requests,NSError *error))block;
/*!
 @abstract Game Service - 删除请求
 @param block 回调
 */
+(void)fbDeleteRequestWithRequestId:(NSString*)requestId completeBlock:(void(^)(id result,NSError *error))block;


/*!
 @abstract 此方法用来取代gameInviteWithPlatform,fbSendGiftWithContent,fbAskForGiftWithContent
 @param platform 平台
 @param requestType 请求类型
 @param title 标题
 @param message 信息
 @param objectId
 @param receiptIds 接受者id
 @param delegate 委托
 */
+(void)sendRequestWithPlatform:(NSString *const)platform requestType:(NSString *const)requestType title:(NSString*)title message:(NSString*)message objectId:(NSString*)objectId receiptIds:(NSArray*)receiptIds delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;

/*!
 @abstract 下面的三个方法是关于奖励机制的,邀请奖励,自定义奖励事件
 @discussion 此方法用来提交Facebook邀请信息
 @param platform 平台
 @param result 这是发完邀请请求成功在WAGameRequestDialogDelegate的方法:[- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results]的results
 @param handler 回调block 当code为200时成功
 */
+(void)createInviteInfoWithPlatform:(NSString *const)platform results:(NSDictionary*)results handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
/*!
 @discussion 触发Facebook被邀请人安装应用事件接口。在玩家登录facebook或者用facebook账号绑定的时候可以触发安装事件
  @param platform 平台
 @param tokenString facebook accesstoken
 @param handler 回调block 当code为200时成功
 */
+(void)inviteInstallRewardPlatform:(NSString *const)platform TokenString:(NSString*)tokenString handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
/*!
 @discussion 发送Facebook邀请奖励事件统计接口
 @param platform 平台
 @param eventName 奖励事件名称
 @param handler 回调block 当code为200时成功
 */
+(void)inviteEventRewardWithPlatform:(NSString *const)platform eventName:(NSString*)eventName handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
@end

