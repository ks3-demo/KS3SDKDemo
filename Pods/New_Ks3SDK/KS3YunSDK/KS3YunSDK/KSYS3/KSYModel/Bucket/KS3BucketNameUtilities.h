//
//  KS3BucketNameUtilities.h
//  NEW_KSCSDK
//
//  Created by ks3 on 12/23/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KS3ClientException;
@interface KS3BucketNameUtilities : NSObject
+ (KS3ClientException *)validateBucketName:(NSString * _Nullable)theBucketName;
@end
