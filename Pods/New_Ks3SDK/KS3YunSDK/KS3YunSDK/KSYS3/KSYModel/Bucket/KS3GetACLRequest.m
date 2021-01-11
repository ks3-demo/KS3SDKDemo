//
//  KSS3BucketACLRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3GetACLRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3GetACLRequest

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodGet;
    self.contentMd5 = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@/?acl", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/?acl",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
  }
  return self;
}
@end
