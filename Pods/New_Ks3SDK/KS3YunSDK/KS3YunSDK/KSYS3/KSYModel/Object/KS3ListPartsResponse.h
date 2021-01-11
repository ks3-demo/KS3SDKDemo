//
//  KSS3ListPartsResponse.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListPartsResult.h"
#import "KS3Response.h"
NS_ASSUME_NONNULL_BEGIN
@class KS3ListPartsResult;
@interface KS3ListPartsResponse : KS3Response

@property(strong, nonatomic, nullable) KS3ListPartsResult *listResult;
@end
NS_ASSUME_NONNULL_END
