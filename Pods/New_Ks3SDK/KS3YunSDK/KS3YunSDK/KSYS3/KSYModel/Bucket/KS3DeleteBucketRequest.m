//
//  KSS3DeleteBucketRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3DeleteBucketRequest.h"
#import "KS3Client.h"
#import "KS3ClientException.h"
#import "KS3Constants.h"
@implementation KS3DeleteBucketRequest

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodDelete;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@/", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
  }
  return self;
}
- (KS3ClientException *)validate {
  KS3ClientException *clientException = [super validate];
  if (clientException == nil) {
    if (nil == self.bucket) {
      clientException = [KS3ClientException
          exceptionWithMessage:@"Bucket Name should not be nil."];
    }
  }
  return clientException;
}
@end
