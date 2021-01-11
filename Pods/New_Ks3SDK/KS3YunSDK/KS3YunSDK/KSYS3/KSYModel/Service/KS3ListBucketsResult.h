//
//  KSS3ListBucketsResult.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KS3Owner;

@interface KS3ListBucketsResult : NSObject

@property(strong, nonatomic, nullable) KS3Owner *owner;
@property(strong, nonatomic, nullable) NSMutableArray *buckets;

@end
