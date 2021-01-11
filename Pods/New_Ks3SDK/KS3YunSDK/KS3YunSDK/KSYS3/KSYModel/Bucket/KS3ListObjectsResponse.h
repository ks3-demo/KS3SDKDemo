//
//  KSS3ListObjectsResponse.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Response.h"
@class KS3ListObjectsResult;

@interface KS3ListObjectsResponse : KS3Response
@property(strong, nonatomic, nullable) KS3ListObjectsResult *listBucketsResult;
@end
