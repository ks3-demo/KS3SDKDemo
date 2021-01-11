//
//  KSS3GetObjectACLResponse.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@class KS3BucketACLResult;
@interface KS3GetObjectACLResponse : KS3Response
@property(strong, nonatomic, nullable) KS3BucketACLResult *listBucketsResult;
@end
NS_ASSUME_NONNULL_END
