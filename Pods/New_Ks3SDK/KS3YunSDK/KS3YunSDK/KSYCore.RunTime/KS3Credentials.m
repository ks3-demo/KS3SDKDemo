//
//  KingSoftCredentials.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Credentials.h"

@implementation KS3Credentials

- (instancetype _Nullable)init {
  self = [super init];
  if (self) {
    _accessKey = nil;
    _secretKey = nil;
  }
  return self;
}

- (instancetype _Nullable)initWithAccessKey:(NSString * _Nullable)accessKey
          withSecretKey:(NSString * _Nullable)secretKey {
  self = [super init];
  if (self) {
    _accessKey = accessKey;
    _secretKey = secretKey;
    NSLog(@"##### 初始化本地AK/SK #####");
  }
  return self;
}

@end
