//
//  KS3BucketObj.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020年 ks3. All rights reserved.
//

#import "KS3BucketObject.h"

@implementation KS3BucketObject

- (instancetype _Nonnull)initWithBucketName:(NSString * _Nullable)strBucketName
                                    keyName:(NSString * _Nullable)strKeyName {
  self = [super init];
  if (self) {
    _bucketName = strBucketName;
    _objKey = strKeyName;
  }
  return self;
}

@end
