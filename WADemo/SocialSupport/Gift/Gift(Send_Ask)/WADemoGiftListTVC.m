//
//  GHWGiftListTVC.m
//  GHWSdkUI
//
//  Created by wuyx on 15/7/16.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import "WADemoGiftListTVC.h"
#import "WADemoFriendListForSendingAsking.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "WADemoAlertView.h"
#import "WADemoMaskLayer.h"
@interface WADemoGiftListTVC ()

@end

@implementation WADemoGiftListTVC
static NSString *_cellIdentifier = @"GiftCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:_cellIdentifier];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

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
    [WASocialProxy queryFriendsWithPlatform:WA_PLATFORM_FACEBOOK completeBlock:^(NSArray *friends, NSError *error) {
        if (!error) {
            WADemoFriendListForSendingAsking* friendListTV = [[WADemoFriendListForSendingAsking alloc]init];
            friendListTV.actionType = WAGameRequestActionTypeSend;
            friendListTV.friends = friends;
            if (gift) {
                friendListTV.gift = gift;
            }
            [self.view addSubview:friendListTV];
        }else{
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
            [self.view addSubview:friendListTV];
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
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"GHWSDK LOG : gameRequestDialog didCompleteWithResults : %@",results);
}

- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
     NSLog(@"didFailWithError : %@",error.description);
}

- (void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform{
     NSLog(@"gameRequestDialogDidCancel");
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
