//
//  GHWButton_Main.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/23.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoButtonMain.h"

@implementation WADemoButtonMain


-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
//    self.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];//Helvetica-Bold
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self setShowsTouchWhenHighlighted:YES];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (frame.origin.x==0&&frame.origin.y==0&&frame.size.width == 0&&frame.size.height ==0) {
        return;
    }
    
    [self setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor] size:self.frame.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:[UIColor orangeColor] size:frame.size] forState:UIControlStateHighlighted];

}

-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    if (size.width <= 0 || size.height <= 0) {
        NSLog(@"Error: Invalid image size: (%f, %f)", size.width, size.height);
        return nil;
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
