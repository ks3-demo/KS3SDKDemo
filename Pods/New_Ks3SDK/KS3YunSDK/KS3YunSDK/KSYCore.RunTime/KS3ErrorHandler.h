//
//  KS3ErrorHandler.h
//  NEW_KSCSDK
//
//  Created by ks3 on 12/23/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const KS3iOSSDKServiceErrorDomain;
extern NSString *const KS3iOSSDKClientErrorDomain;

@interface KS3ErrorHandler : NSObject
+ (void)shouldThrowExceptions __attribute__((deprecated));
+ (void)shouldNotThrowExceptions;
+ (BOOL)throwsExceptions;
+ (NSError *)errorFromExceptionWithThrowsExceptionOption:
    (NSException *)exception;
+ (NSError *)errorFromException:(NSException *)exception;
+ (NSError *)errorFromException:(NSException *)exception
             serviceErrorDomain:(NSString * _Nullable)serviceErrorDomain
              clientErrorDomain:(NSString * _Nullable)clientErrorDomain;
@end
