//
//  GHWUtil.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoUtil.h"

@implementation WADemoUtil
+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow* window = (UIWindow*)[[UIApplication sharedApplication] keyWindow];
    
//    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.anyObject;
//    UIWindow *window = windowScene.windows.firstObject;
    
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow* tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
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
