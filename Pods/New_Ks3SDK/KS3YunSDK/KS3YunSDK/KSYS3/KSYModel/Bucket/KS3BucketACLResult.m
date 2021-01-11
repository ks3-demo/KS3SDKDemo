//
//  KSS3BucketACLResult.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3BucketACLResult.h"

@implementation KS3BucketACLResult
- (instancetype _Nullable)init {
  self = [super init];
  if (self) {
    _accessControlList = [[NSMutableArray alloc] init];
  }
  return self;
}
@end
