//
//  WASDKDownloadHandler.h
//  testDownload
//
//  Created by wuyx on 15/10/21.
//  Copyright © 2015年 GHW. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@interface WADownloadHandler : NSObject
+ (NSURLSessionDownloadTask *)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
                        method:(NSString*)method
                       success:(void (^)(NSURLResponse *response, NSURL *filePath))success
                       failure:(void (^)(NSURLResponse *response, NSError *error))failure
                      progress:(void (^)(float progress))progress;
@end

