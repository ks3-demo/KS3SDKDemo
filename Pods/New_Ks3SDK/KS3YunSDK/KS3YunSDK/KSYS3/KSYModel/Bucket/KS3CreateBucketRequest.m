//
//  KSS3CreateBucketRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3CreateBucketRequest.h"
#import "KS3BucketNameUtilities.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3CreateBucketRequest

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodPut;
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
  if (!clientException) {
    clientException = [KS3BucketNameUtilities validateBucketName:self.bucket];
  }
  return clientException;
}

@end
