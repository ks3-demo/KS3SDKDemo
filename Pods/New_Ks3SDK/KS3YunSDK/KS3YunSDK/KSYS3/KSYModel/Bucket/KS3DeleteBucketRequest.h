//
//  KSS3DeleteBucketRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"

@interface KS3DeleteBucketRequest : KS3Request

- (instancetype _Nullable)initWithName:(NSString * _Nullable)bucketName;
@end
