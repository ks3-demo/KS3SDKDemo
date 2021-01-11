//
//  KSS3ListPartsResult.m
//  NEW_KSCSDK
//
//  Created by ks3 on 12/16/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListPartsResult.h"

@implementation KS3ListPartsResult

- (instancetype _Nullable)init {
  self = [super init];
  if (self) {
    _parts = [NSMutableArray new];
  }
  return self;
}
@end
