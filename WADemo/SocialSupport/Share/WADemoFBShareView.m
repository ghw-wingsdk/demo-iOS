//
//  GHWFBShareView.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoFBShareView.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
@implementation WADemoFBShareView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    WADemoButtonMain* btn1 = [[WADemoButtonMain alloc]init];
    [btn1 setTitle:@"PhotoUI" forState:UIControlStateNormal];
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(sharePhotoOrVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"PhotoApi" forState:UIControlStateNormal];
    btn2.tag = 1;
    [btn2 addTarget:self action:@selector(sharePhotoOrVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"VideoUI" forState:UIControlStateNormal];
    btn3.tag = 2;
    [btn3 addTarget:self action:@selector(sharePhotoOrVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    WADemoButtonMain* btn4 = [[WADemoButtonMain alloc]init];
    [btn4 setTitle:@"VideoApi" forState:UIControlStateNormal];
    btn4.tag = 3;
    [btn4 addTarget:self action:@selector(sharePhotoOrVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn4];
    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"LinkUI" forState:UIControlStateNormal];
    btn5.tag = 0;
    [btn5 addTarget:self action:@selector(shareLink:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];
    WADemoButtonMain* btn6 = [[WADemoButtonMain alloc]init];
    [btn6 setTitle:@"LinkApi" forState:UIControlStateNormal];
    btn6.tag = 1;
    [btn6 addTarget:self action:@selector(shareLink:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn6];
    
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1,@1,@1,@1,@1]];
    //
    self.title = @"Facebook分享";
    self.btnLayout = btnLayout;
    self.btns = btns;
}
//

-(void)sharer:(NSObject<WASharing>*)sharer platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"didCompleteWithResults:%@",results);
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"platform:%@ result:%@",platform,results] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    [alert show];
}

-(void)sharer:(NSObject<WASharing> *)sharer platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError:%@",error);
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"platform:%@ error:%@",platform,error.description] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    [alert show];
}

-(void)sharerDidCancel:(NSObject<WASharing> *)sharer platform:(NSString *const)platform{
    NSLog(@"sharerDidCancel");
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"分享取消" message:[NSString stringWithFormat:@"platform:%@",platform] delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
    [alert show];
    
}


- (void)shareLink:(UIButton *)sender {
    
    WAShareLinkContent* content = [[WAShareLinkContent alloc]init];
    content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    content.contentTitle = @"To share a link to you.";
    content.contentDescription = @"This is a link ,and it links to https://developers.facebook.com";
    content.imageURL = [NSURL URLWithString:@"http://a5.mzstatic.com/us/r30/Purple3/v4/3a/84/63/3a8463f8-f90d-5e45-7fde-25efaee00b5b/icon175x175.jpeg"];
    if (sender.tag ==0) {
        [WASocialProxy shareWithPlatform:WA_PLATFORM_FACEBOOK shareContent:content shareWithUI:YES delegate:self];
    }else{
        [WASocialProxy shareWithPlatform:WA_PLATFORM_FACEBOOK shareContent:content shareWithUI:NO delegate:self];
    }
}

static UIImage* image = nil;
static NSURL *videoURL =nil;
static int flag = -1;//0:PhotoUI 1:PhotoApi 2:VideoUI 3:VideoApi
- (void)sharePhotoOrVideo:(UIButton *)sender {
    flag = (int)sender.tag;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (flag==0||flag==1) {
        picker.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil];
    }else{
        picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    }
    picker.delegate = self;
    
    
    [[WADemoUtil getCurrentVC] presentViewController:picker animated:YES completion:^{
    }];
}

-(void)share{
    if (videoURL) {
        
        WAShareVideo *video = [[WAShareVideo alloc] init];
        video.videoURL = videoURL;
        
        WAShareVideoContent *content = [[WAShareVideoContent alloc] init];
        //content.contentURL = videoURL;
        //content.previewPhoto = previewPhoto;
        content.video = video;
        if (flag==2) {
            [WASocialProxy shareWithPlatform:WA_PLATFORM_FACEBOOK shareContent:content shareWithUI:YES delegate:self];
        }
        if (flag==3) {
            [WASocialProxy shareWithPlatform:WA_PLATFORM_FACEBOOK shareContent:content shareWithUI:NO delegate:self];
        }
        
    }
    
    if (image) {
        
        WASharePhoto *photo = [[WASharePhoto alloc]init];
        photo.image = image;
        //phote.imageURL = [NSURL URLWithString:@"..."];//image 和 imageURL 可以二选一
        photo.userGenerated = YES;
        photo.caption = @"caption...";
        WASharePhotoContent *content = [[WASharePhotoContent alloc]init];
        content.photos = @[photo];
    
        if (flag==0) {
            [WASocialProxy shareWithPlatform:WA_PLATFORM_FACEBOOK shareContent:content shareWithUI:YES delegate:self];
        }
        
        if (flag==1) {
            [WASocialProxy shareWithPlatform:WA_PLATFORM_FACEBOOK shareContent:content shareWithUI:NO delegate:self];
        }
        
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        image = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self share];
    }
    if ([mediaType isEqualToString:@"public.movie"]) {
        videoURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self share];
    }
    
}

-(void)localVideo{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    
    [[WADemoUtil getCurrentVC] presentViewController:picker animated:YES completion:^{
        NSLog(@"...................");
    }];
    
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
