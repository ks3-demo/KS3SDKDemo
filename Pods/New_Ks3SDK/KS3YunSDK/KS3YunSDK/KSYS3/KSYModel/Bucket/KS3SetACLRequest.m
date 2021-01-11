//
//  KSS3SetACLRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3SetACLRequest.h"
#import "KS3AccessControlList.h"
#import "KS3Client.h"
#import "KS3Constants.h"
@implementation KS3SetACLRequest

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName
                   accessACL:(KS3AccessControlList *)accessACL {
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.httpMethod = kHttpMethodPut;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@/?acl", self.bucket];
    self.host = [NSString
        stringWithFormat:@"%@://%@.%@/?acl",
                         [[KS3Client initialize] requestProtocol], self.bucket,
                         [[KS3Client initialize] getBucketDomain]];
    _acl = accessACL;
  }
  return self;
}

- (KS3URLRequest * _Nonnull)configureURLRequest {

  [super configureURLRequest];
  [self.urlRequest setValue:_acl.accessACL forHTTPHeaderField:@"x-kss-acl"];
  return self.urlRequest;
}
@end
