//
//  KSS3CompleteMultipartUploadRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3CompleteMultipartUploadRequest : KS3Request

@property(strong, nonatomic, nonnull) NSString *key;
@property(strong, nonatomic, nonnull) NSString *uploadId;
@property(strong, nonatomic, nonnull) NSData *dataParts;
@property(strong, nonatomic, nullable) NSString *callbackUrl;
@property(strong, nonatomic, nullable) NSString *callbackBody;
@property(strong, nonatomic, nullable) NSDictionary *callbackParams;

- (instancetype _Nonnull)initWithMultipartUpload:(KS3MultipartUpload * _Nonnull)multipartUpload;

- (void)addPartWithPartNumber:(int)partNumber withETag:(NSString * _Nonnull)etag;

- (NSData * _Nonnull)requestBody;

@end
NS_ASSUME_NONNULL_END
