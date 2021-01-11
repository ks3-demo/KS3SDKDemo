//
//  S3Request.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ServiceRequest.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3Request : KS3ServiceRequest
@property(strong, nonatomic, nonnull) NSString *bucket;
@property(nonatomic, assign) int64_t contentLength;
@end
NS_ASSUME_NONNULL_END
