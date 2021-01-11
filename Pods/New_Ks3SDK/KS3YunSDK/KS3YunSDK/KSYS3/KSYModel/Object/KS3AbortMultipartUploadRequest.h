//
//  KSS3AbortMultipartUploadRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3AbortMultipartUploadRequest : KS3Request

@property(strong, nonatomic, nonnull) NSString *key;
@property(strong, nonatomic, nonnull) NSString *uploadId;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName;
- (instancetype _Nonnull)initWithMultipartUpload:(KS3MultipartUpload * _Nonnull)multipartUpload;

@end
NS_ASSUME_NONNULL_END
