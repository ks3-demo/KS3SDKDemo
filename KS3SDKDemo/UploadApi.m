//
//  UploadApi.m
//  KS3SDKDemo
//
//  Created by cqc on 2021/1/10.
//  Copyright © 2021 Kingsoft. All rights reserved.
//

#import "UploadApi.h"

@implementation UploadApi
// 上传前获取签名
+(void) getTokenByFileMsg:(NSString *) contentMd5
              contentType: (NSString *) contentType
                objectKey: (NSString *) objectKey
  canonicalizedKssHeaders: (NSArray *) canonicalizedKssHeaders
    completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{

    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: @ "http://www.cqc.cool/file/get_signature"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0
    ];
    NSDictionary * headers = @ {
            @ "Content-Type": @ "application/json",
    };
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
 
    if (objectKey == nil) {
        objectKey = @"test";
    }
    [param setObject:objectKey forKey:@"objectKey"];
    if (contentMd5) {
        [param setObject:contentMd5 forKey:@"contentMd5"];
    }
    if (contentType) {
        [param setObject:contentType forKey:@"contentType"];
    }
    if (canonicalizedKssHeaders) {
        [param setObject:canonicalizedKssHeaders forKey:@"canonicalizedKS3Headers"];
    }
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];

    [request setAllHTTPHeaderFields: headers];
    [request setHTTPBody: postData];
    [request setHTTPMethod: @ "POST"];

    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest: request
                                                 completionHandler:completionHandler];
    [dataTask resume];
}
@end
