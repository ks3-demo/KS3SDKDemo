//
//  KSS3SetObjectGrantACLRequest.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 Blues. All rights reserved.
//

#import "KS3SetObjectGrantACLRequest.h"
#import "KS3Client.h"
#import "KS3Constants.h"
#import "KS3GrantAccessControlList.h"

@implementation KS3SetObjectGrantACLRequest

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKeyName
                    grantAcl:(KS3GrantAccessControlList *_Nonnull)grantAcl
{
  self = [super init];
  if (self) {
    self.bucket = [self URLEncodedString:bucketName];
    self.key = [self URLEncodedString:strKeyName];
    self.acl = grantAcl;
    self.httpMethod = kHttpMethodPut;
    self.contentMd5 = @"";
    self.contentType = @"";
    self.kSYResource = [NSString stringWithFormat:@"/%@", self.bucket];
    self.host = @"";

    //
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
  NSString *strValue =
      [NSString stringWithFormat:@"id=\"%@\", ", _acl.identifier];
  strValue = [strValue
      stringByAppendingFormat:@"displayName=\"%@\"", _acl.displayName];
  [super configureURLRequest];
  [self.urlRequest setHTTPMethod:kHttpMethodPut];
  [self.urlRequest setValue:strValue forHTTPHeaderField:_acl.accessGrantACL];

  return self.urlRequest;
}

@end
