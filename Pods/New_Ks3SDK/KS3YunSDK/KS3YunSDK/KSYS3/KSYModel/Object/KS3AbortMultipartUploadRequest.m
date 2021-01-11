//
//  KSS3AbortMultipartUploadRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import "KS3AbortMultipartUploadRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3AbortMultipartUploadRequest

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodDelete;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
  }
  return self;
}

- (instancetype _Nonnull)initWithMultipartUpload:(KS3MultipartUpload * _Nonnull)multipartUpload {
  if (self = [super init]) {
    self.bucket = [self URLEncodedString:multipartUpload.bucket];
    self.key = [self URLEncodedString:multipartUpload.key];
    self.uploadId = multipartUpload.uploadId;

    self.httpMethod = kHttpMethodDelete;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
    [multipartUpload cancel];
  }

  return self;
}

- (void)setCompleteRequest {
  self.kSYResource =
      [NSString stringWithFormat:@"%@/%@?uploadId=%@", self.kSYResource, _key,
                                 self.uploadId];
}
- (KS3URLRequest * _Nonnull)configureURLRequest {

  self.host = [NSString
      stringWithFormat:@"%@/%@?uploadId=%@", self.host, _key, _uploadId];
  [super configureURLRequest];
  return self.urlRequest;
}

@end
