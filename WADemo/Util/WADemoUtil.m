//
//  GHWUtil.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoUtil.h"

// Scene 生命周期下 UIApplication 的 keyWindow/statusBarFrame/statusBarOrientation 均已废弃，
// 统一从当前前台 UIWindowScene 获取。
static UIWindowScene *WADemoForegroundWindowScene(void) {
    UIWindowScene *fallback = nil;
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (![scene isKindOfClass:[UIWindowScene class]]) {
            continue;
        }
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            return windowScene;
        }
        if (!fallback) {
            fallback = windowScene;
        }
    }
    return fallback;
}

@implementation WADemoUtil

+ (UIWindow *)currentWindow {
    UIWindowScene *windowScene = WADemoForegroundWindowScene();
    UIWindow *normalWindow = nil;
    for (UIWindow *window in windowScene.windows) {
        if (window.isKeyWindow) {
            return window;
        }
        if (!normalWindow && window.windowLevel == UIWindowLevelNormal) {
            normalWindow = window;
        }
    }
    return normalWindow;
}

+ (CGRect)statusBarFrame {
    return WADemoForegroundWindowScene().statusBarManager.statusBarFrame;
}

+ (UIInterfaceOrientation)interfaceOrientation {
    return WADemoForegroundWindowScene().interfaceOrientation;
}
+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow* window = [self currentWindow];
    
//    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
//    UIWindow *window = windowScene.windows.firstObject;
    
    // currentWindow 已保证返回 key/normal 窗口，无需再遍历回退（原 [[UIApplication sharedApplication] windows] 也已废弃）
    
    UIView *frontView = window.subviews.firstObject;
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    if ([result isKindOfClass:[UINavigationController class]])
        result = ((UINavigationController *)result).topViewController;
    
    return result;
}



+(void)addOrientationNotification:(id)observer selector:(SEL)selector object:(id)object{
    NSString* model = [UIDevice currentDevice].model;
    if (![@"iPhone" isEqualToString:model]) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:observer
                                                 selector:selector
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:object
         ];
    }
    
}
+(void)removeOrientationNotification:(id)observer object:(id)object{
    NSString* model = [UIDevice currentDevice].model;
    if (![@"iPhone" isEqualToString:model]){
        [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                        name:UIDeviceOrientationDidChangeNotification
                                                      object:object
         ];
        [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
    }
}

// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonString{
    if (!jsonString) {
        return nil;
    }
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

+(NSString*)toJSONStringFromDictionary:(NSDictionary*)dict{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [jsonStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}
@end
