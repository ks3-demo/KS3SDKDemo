//
//  KSS3ListBucketsResult.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListBucketsResult.h"

@implementation KS3ListBucketsResult

- (instancetype _Nullable)init {
  self = [super init];
  if (self) {
    _buckets = [[NSMutableArray alloc] init];
  }
  return self;
}
@end
