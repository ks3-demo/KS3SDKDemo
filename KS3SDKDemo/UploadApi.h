//
//  UploadApi.h
//  KS3SDKDemo
//
//  Created by cqc on 2021/1/10.
//  Copyright © 2021 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadApi : NSObject
// 获取签名
+(void) getTokenByFileMsg:(NSString *) contentMd5
              contentType: (NSString *) contentType
                objectKey: (NSString *) objectKey
  canonicalizedKssHeaders: (NSArray *) canonicalizedKssHeaders
        completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END
