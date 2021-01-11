//
//  KS3ClientException.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KS3ClientException : NSException

@property(strong, nonatomic, nullable) NSString *message;

@property(strong, nonatomic, nullable) NSError *error;

+ (instancetype _Nullable)exceptionWithMessage:(NSString * _Nullable)theMessage;

+ (instancetype _Nullable)exceptionWithMessage:(NSString * _Nullable)theMessage andError:(NSError *)theError;

@end
