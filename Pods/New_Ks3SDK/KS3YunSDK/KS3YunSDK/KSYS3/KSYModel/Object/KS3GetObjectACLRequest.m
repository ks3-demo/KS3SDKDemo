//
//  KSS3GetObjectACLRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3GetObjectACLRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3GetObjectACLRequest

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKey {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.key = [self URLEncodedString:strKey];
    self.httpMethod = kHttpMethodGet;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];

    //
    self.kSYResource =
        [NSString stringWithFormat:@"%@/%@?acl", self.kSYResource, _key];
    self.host = [NSString stringWithFormat:@"%@%@?acl", self.host, _key];
  }
  return self;
}

- (KS3URLRequest * _Nonnull)configureURLRequest {
  [super configureURLRequest];
  return self.urlRequest;
}
@end
