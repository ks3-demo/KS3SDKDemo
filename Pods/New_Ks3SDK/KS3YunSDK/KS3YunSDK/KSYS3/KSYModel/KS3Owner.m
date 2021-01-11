//
//  KS3Owner.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Owner.h"

@implementation KS3Owner

- (instancetype _Nonnull)initWithID:(NSString * _Nonnull)theID withDisplayName:(NSString * _Nonnull)theDisplayName {
  self = [super init];
  if (self) {
    _ID = theID;
    _displayName = theDisplayName;
  }
  return self;
}

+ (instancetype _Nonnull)ownerWithID:(NSString * _Nonnull)theID withDisplayName:(NSString * _Nonnull)theDisplayName {
  return [[self alloc] initWithID:theID withDisplayName:theDisplayName];
}

@end
