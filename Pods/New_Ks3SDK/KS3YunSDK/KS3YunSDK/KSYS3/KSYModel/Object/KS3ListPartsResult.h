//
//  KSS3ListPartsResult.h
//  NEW_KSCSDK
//
//  Created by ks3 on 12/16/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Owner.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3ListPartsResult : NSObject

@property(strong, nonatomic, nonnull) NSString *Bucket;

@property(strong, nonatomic, nonnull) NSString *key;
@property(strong, nonatomic, nonnull) NSString *UploadId;

@property(nonatomic) int32_t partNumberMarker;

@property(nonatomic) int32_t maxParts;

@property(nonatomic) BOOL isTruncated;

@property(strong, nonatomic, nullable) KS3Owner *initiator;

@property(strong, nonatomic, nullable) KS3Owner *owner;

@property(strong, nonatomic, nullable) NSMutableArray *parts;

@end
NS_ASSUME_NONNULL_END
