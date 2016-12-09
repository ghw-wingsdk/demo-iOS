//
//  GHWGiftList.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoGiftList.h"
#import "WADemoFriendListForSendingAsking.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "WADemoAlertView.h"
#import "WADemoMaskLayer.h"
static NSString *_cellIdentifier = @"GiftCell";
@implementation WADemoGiftList

#pragma mark - Table view data source

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:_cellIdentifier];
        self.dataSource = self;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gifts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
    }
    
    WAFBObject* gift = self.gifts[indexPath.row];
    
    if (gift.imageUrls) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:gift.imageUrls]];
    }
    
    
    float width = 50;
    float height = cell.frame.size.height - 10;
    float space = 10;
    float x = 0;
    float y = 0;
    
    UIButton* sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [sendBtn setTitle:@"send" forState:UIControlStateHighlighted];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setShowsTouchWhenHighlighted:YES];
    [sendBtn setBackgroundColor:[UIColor lightGrayColor]];
    [sendBtn setTag:indexPath.row];
    [sendBtn addTarget:self action:@selector(sendGift:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* askBtn = [[UIButton alloc]initWithFrame:CGRectMake(x + width + space, y, width, height)];
    [askBtn setTitle:@"ask" forState:UIControlStateNormal];
    [askBtn setTitle:@"ask" forState:UIControlStateHighlighted];
    [askBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [askBtn setBackgroundColor:[UIColor lightGrayColor]];
    [askBtn setTag:indexPath.row];
    [askBtn addTarget:self action:@selector(askGift:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width + space + width, height)];
    btnView.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:sendBtn];
    [btnView addSubview:askBtn];
    
    cell.accessoryView = btnView;
    cell.textLabel.text = gift.title;
    
    return cell;
}
-(void)sendGift:(UIButton*)btn{
    WAFBObject* gift = self.gifts[btn.tag];
    [WASocialProxy queryFriendsWithPlatform:WA_PLATFORM_FACEBOOK completeBlock:^(NSArray* friends, NSError *error) {
        if (!error) {
            WADemoFriendListForSendingAsking* friendListTV = [[WADemoFriendListForSendingAsking alloc]init];
            friendListTV.actionType = WAGameRequestActionTypeSend;
            friendListTV.friends = friends;
            if (gift) {
                friendListTV.gift = gift;
            }
            [self addSubview:friendListTV];
        }else{
            NSLog(@"sendGift error : %@",error.description);
            [WADemoMaskLayer stopAnimating];
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
    }];
    
}
-(void)askGift:(UIButton*)btn{
    
    WAFBObject* gift = self.gifts[btn.tag];
    [WASocialProxy queryFriendsWithPlatform:WA_PLATFORM_FACEBOOK completeBlock:^(NSArray *friends, NSError *error) {
        if (!error) {
            WADemoFriendListForSendingAsking* friendListTV = [[WADemoFriendListForSendingAsking alloc]init];
            friendListTV.actionType = WAGameRequestActionTypeAskFor;
            friendListTV.friends = friends;
            if (gift) {
                friendListTV.gift = gift;
            }
            [self addSubview:friendListTV];
        }else{
            [WADemoMaskLayer stopAnimating];
            WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"ERROR" message:[NSString stringWithFormat:@"ERROR:%@",error.description] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
            [alert show];
        }
        
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma delegate WAGameRequestDialogDelegate
-(void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"GHWSDK LOG : gameRequestDialog didCompleteWithResults : %@",results);
}

-(void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError : %@",error.description);
}

-(void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform{
    NSLog(@"gameRequestDialogDidCancel");
}

@end
