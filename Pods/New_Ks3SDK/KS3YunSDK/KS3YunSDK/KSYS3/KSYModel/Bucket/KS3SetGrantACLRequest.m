//
//  KSS3SetGrantACLRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import "KS3SetGrantACLRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
#import "KS3GrantAccessControlList.h"
@implementation KS3SetGrantACLRequest
- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName
                   accessACL:(KS3GrantAccessControlList *)accessACL {
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

    if (accessACL) {
      _acl = accessACL;
      NSString *strValue =
          [NSString stringWithFormat:@"id=\"%@\", ", _acl.identifier];
      strValue = [strValue
          stringByAppendingFormat:@"displayName=\"%@\"", _acl.displayName];
      [self.urlRequest setValue:strValue
             forHTTPHeaderField:_acl.accessGrantACL];
    }
  }
  return self;
}

- (KS3URLRequest * _Nonnull)configureURLRequest {
  [super configureURLRequest];
  return self.urlRequest;
}

@end
