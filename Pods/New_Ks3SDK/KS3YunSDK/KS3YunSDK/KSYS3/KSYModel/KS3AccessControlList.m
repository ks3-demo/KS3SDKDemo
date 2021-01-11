//
//  KSS3AccessControlList.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3AccessControlList.h"

@implementation KS3AccessControlList

- (instancetype _Nonnull)init {
  self = [super init];
  if (self) {
    _accessACL = @"";
  }
  return self;
}
- (NSString * _Nonnull)setContronAccess:(KingSoftYun_PermissionACLType)aclType {
  _accessACL = @"";
  switch (aclType) {
  case KingSoftYun_Permission_Private:
    _accessACL = @"private";
    break;
  case KingSoftYun_Permission_Public_Read:
    _accessACL = @"public-read";
    break;
  case KingSoftYun_Permission_Public_Read_Write:
    _accessACL = @"public-read-write";
    break;
  case KingSoftYun_Permission_Authenticated_Read:
    _accessACL = @"authenticated-read";
    break;
  default:
    break;
  }
  return _accessACL;
}
@end
