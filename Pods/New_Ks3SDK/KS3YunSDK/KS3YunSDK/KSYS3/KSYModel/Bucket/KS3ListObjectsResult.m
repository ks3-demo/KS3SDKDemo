//
//  ListBucketObjects.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListObjectsResult.h"

@implementation KS3ListObjectsResult
- (instancetype _Nullable)init {
  self = [super init];
  if (self) {
    _objectSummaries = [NSMutableArray new];
    _commonPrefixes = [NSMutableArray new];
  }
  return self;
}
@end
