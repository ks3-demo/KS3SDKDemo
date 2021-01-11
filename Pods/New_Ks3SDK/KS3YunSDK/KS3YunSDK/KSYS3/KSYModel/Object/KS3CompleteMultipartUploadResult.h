//
//  KSS3CompleteMultipartUploadResult.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3CompleteMultipartUploadResult : NSObject

@property(strong, nonatomic, nullable) NSString *location;

@property(strong, nonatomic, nullable) NSString *bucket;

@property(strong, nonatomic, nullable) NSString *key;

@property(strong, nonatomic, nullable) NSString *etag;
@end
NS_ASSUME_NONNULL_END
