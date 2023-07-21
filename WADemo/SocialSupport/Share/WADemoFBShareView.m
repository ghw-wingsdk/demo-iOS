//
//  GHWFBShareView.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//
#import <Photos/Photos.h>

#import "WADemoFBShareView.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import "WADemoAlertView.h"
@implementation WADemoFBShareView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initBtnAndLayout];
    }
    return self;
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
    WADemoButtonMain* btn1 = [[WADemoButtonMain alloc]init];
    [btn1 setTitle:@"PhotoUI" forState:UIControlStateNormal];
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(sharePhotoOrVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn1];

    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"VideoUI" forState:UIControlStateNormal];
    btn3.tag = 2;
    [btn3 addTarget:self action:@selector(sharePhotoOrVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];

    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"LinkUI" forState:UIControlStateNormal];
    btn5.tag = 0;
    [btn5 addTarget:self action:@selector(shareLink:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];

    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1,@1]];
    //
    self.title = @"Facebook分享";
    self.btnLayout = btnLayout;
    self.btns = btns;
}
//

-(void)sharer:(NSObject<WASharing>*)sharer platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"didCompleteWithResults:%@",results);
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"platform:%@ result:%@",platform,results] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
    
    
}

-(void)sharer:(NSObject<WASharing> *)sharer platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError:%@",error);
    
    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"platform:%@ error:%@",platform,error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
    [alert show];
    
}

-(void)sharerDidCancel:(NSObject<WASharing> *)sharer platform:(NSString *const)platform{
    NSLog(@"sharerDidCancel");

    WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"分享取消" message:[NSString stringWithFormat:@"platform:%@",platform] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
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
    NSLog(@"....sharePhotoOrVideo..............");
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

UIImage *previewImage=nil;

-(void)share{
    NSLog(@"....shareshareshare..............");

    if (videoURL) {
        

        
        
        WASharePhoto *previewPhoto = [[WASharePhoto alloc]init];
        previewPhoto.image = previewImage;
        previewPhoto.userGenerated = YES;
        previewPhoto.caption = @"caption...";

        
        
        
        WAShareVideo *video = [[WAShareVideo alloc] init];
        video.videoURL = videoURL;
        
        WAShareVideoContent *content = [[WAShareVideoContent alloc] init];
        content.contentURL = videoURL;
        content.previewPhoto = nil;
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
        
        NSLog(@"");
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

@end
