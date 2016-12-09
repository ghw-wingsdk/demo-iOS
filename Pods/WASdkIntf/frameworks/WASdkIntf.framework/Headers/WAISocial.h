//
//  WAISocial.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASocialProxy.h"
@protocol WASharingContent;

@interface WAISocial : NSObject
-(void)shareWithContent:(NSObject<WASharingContent>*)shareContent shareWithUI:(BOOL)shareWithUI delegate:(NSObject<WASharingDelegate>*)delegate;
-(void)appInviteWithContent:(WAAppInviteContent*)content delegate:(NSObject<WAAppInviteDialogDelegate>*)delegate;
-(void)queryInvitableFriendsWithDuration:(float)duration completeBlock:(void(^)(NSArray* friends,NSError *error))block;
-(void)gameInviteWithContent:(WAGameRequestContent*)content delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;
-(void)getCurrentAppLinkedGroupWithExtInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;
-(void)getCurrentUserGroupWithExtInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;
-(void)getGroupWithGroupIds:(NSArray*)groupIds extInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;
-(void)getGroupsWithExtInfo:(NSString*)extInfo completeBlock:(void(^)(NSArray* groups,NSError* error))block;
-(void)joinGroupWithGroupId:(NSString*)groupId extInfo:(NSString*)extInfo completeBlock:(void(^)(NSError* error))block;
-(void)openGroupPageWithGroupUri:(NSString *const)groupUri extInfo:(NSString*)extInfo;
-(void)queryFriendsWithCompleteBlock:(void(^)(NSArray* friends,NSError *error))block;
-(void)queryFBGraphObjectsWithObjectType:(NSString*)objectType completeBlock:(void(^)(NSArray<WAFBObject *>* objects,NSError *error))block;
-(void)fbSendGiftWithContent:(WAGameRequestContent*)content delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;
-(void)fbAskForGiftWithContent:(WAGameRequestContent*)content delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;
-(void)fbQueryReceivedGiftsWithCompleteBlock:(void(^)(NSArray<WAFBAppRequest *>* gifts,NSError *error))block;
-(void)fbQueryAskForGiftRequestsWithCompleteBlock:(void(^)(NSArray<WAFBAppRequest *>* requests,NSError *error))block;
-(void)fbDeleteRequestWithRequestId:(NSString*)requestId completeBlock:(void(^)(id result,NSError *error))block;
-(void)sendRequestWithRequestType:(NSString *const)requestType title:(NSString*)title message:(NSString*)message objectId:(NSString*)objectId receiptIds:(NSArray*)receiptIds delegate:(NSObject<WAGameRequestDialogDelegate>*)delegate;
-(void)createInviteInfoWithResults:(NSDictionary*)results handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
-(void)inviteInstallRewardWithTokenString:(NSString*)tokenString handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
-(void)inviteEventRewardWithEventName:(NSString*)eventName handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
-(void)postWithRequestId:(NSString*)requestId andInviteeIds:(NSString*)inviteeIds platform:(NSString *const)platfrom handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
-(void)inviteInstallRewardWithTokenString:(NSString *)accessToken platform:(NSString*)platform inviteIds:(NSString*)inviteIds handler:(void (^)(NSUInteger, NSString *, NSError *))handler;
-(void)inviteEventRewardWithPlatform:(NSString *const)platform eventName:(NSString*)eventName handler:(void (^)(NSUInteger code,NSString* msg, NSError* error)) handler;
@end
