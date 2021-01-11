//
//  KSS3UploadPartRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MultipartUpload.h"
#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3UploadPartRequest : KS3Request

@property(strong, nonatomic, nullable) NSString *expect;

@property(nonatomic, assign) int32_t partNumber;
@property(nonatomic, assign) BOOL generateMD5;
@property(strong, nonatomic, nonnull) NSString *uploadId;
@property(strong, nonatomic, nonnull) NSData *data;
@property(strong, nonatomic, nonnull) NSString *key;
@property(strong, nonatomic, nonnull) KS3MultipartUpload *multipartUpload;
- (instancetype _Nonnull)initWithMultipartUpload:(KS3MultipartUpload * _Nonnull)multipartUpload
                   partNumber:(int32_t)partNumber
                         data:(NSData * _Nonnull)data
                  generateMD5:(BOOL)generateMD5;

@end
NS_ASSUME_NONNULL_END
