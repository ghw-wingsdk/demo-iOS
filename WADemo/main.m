//
//  main.m
//  WADemo
//
//  Created by lpw on 2023/5/19.
//

#import <UIKit/UIKit.h>
#import "WADemoAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([WADemoAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
