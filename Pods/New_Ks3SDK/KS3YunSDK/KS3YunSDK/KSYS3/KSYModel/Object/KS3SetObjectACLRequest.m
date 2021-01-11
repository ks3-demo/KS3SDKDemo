//
//  KSS3SetObjectACLRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3SetObjectACLRequest.h"
#import "KS3AccessControlList.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3SetObjectACLRequest

- (instancetype _Nullable)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKeyName
        acl:(KS3AccessControlList *_Nullable)acl {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.key = [self URLEncodedString:strKeyName];
    self.acl = acl;
    self.httpMethod = kHttpMethodPut;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    self.host = @"";

    self.kSYResource =
        [NSString stringWithFormat:@"%@/%@?acl", self.kSYResource, _key];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/%@?acl",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain], _key];
  }
  return self;
}
- (KS3URLRequest * _Nonnull)configureURLRequest {
  [super configureURLRequest];
  [self.urlRequest setHTTPMethod:kHttpMethodPut];
  [self.urlRequest setValue:_acl.accessACL forHTTPHeaderField:@"x-kss-acl"];
  return self.urlRequest;
}

@end
