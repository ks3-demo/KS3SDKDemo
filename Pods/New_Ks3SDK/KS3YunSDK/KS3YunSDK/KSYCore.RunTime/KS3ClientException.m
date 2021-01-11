//
//  KS3ClientException.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ClientException.h"

@implementation KS3ClientException

+ (instancetype _Nullable)exceptionWithMessage:(NSString * _Nullable)theMessage {
  KS3ClientException *e =
      [[[self class] alloc] initWithName:@"KS3ClientException"
                                  reason:theMessage
                                userInfo:nil];
  e.error = nil;
  e.message = theMessage;

  return e;
}

+ (instancetype _Nullable)exceptionWithMessage:(NSString * _Nullable)theMessage andError:(NSError *)theError {
  KS3ClientException *e =
      [[[self class] alloc] initWithName:@"KS3ClientException"
                                  reason:theMessage
                                userInfo:nil];
  e.error = theError;
  e.message = theMessage;

  return e;
}

- (instancetype _Nullable)initWithMessage:(NSString * _Nullable)theMessage {
  self =
      [super initWithName:@"KS3ClientException" reason:theMessage userInfo:nil];
  if (self) {
    _message = theMessage;
  }
  return self;
}
@end
