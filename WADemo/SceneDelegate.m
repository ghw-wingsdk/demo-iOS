//
//  SceneDelegate.m
//  wingsdkDemo17
//
//  Created by lpw on 2023/6/16.
//

#import "SceneDelegate.h"
#import <WASdkIntf/WASdkIntf.h>
#import "WADemoUtil.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);
    [WACoreProxy  scene:scene willConnectToSession:session options:connectionOptions];

}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);
    [WACoreProxy sceneDidDisconnect:scene];
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);

    [WACoreProxy sceneDidBecomeActive:scene];
    [WAAdMobProxy showAppOpenAdWithViewController:[WADemoUtil getCurrentVC] withDelegate:self];

}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);
    [WACoreProxy sceneWillResignActive:scene];

}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);
    [WACoreProxy sceneWillEnterForeground:scene];

}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);
    [WACoreProxy sceneDidEnterBackground:scene];

}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);
    [WACoreProxy scene:scene openURLContexts:URLContexts];
    
}
- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s, %s, ", __FILE__, __FUNCTION__);

}
@end
