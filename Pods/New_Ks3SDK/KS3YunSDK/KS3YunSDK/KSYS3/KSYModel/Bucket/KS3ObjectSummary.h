//
//  KSS3Contents.h
//  NEW_KSCSDK
//
//  Created by ks3 on 12/13/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KS3Owner;
@interface KS3ObjectSummary : NSObject
@property(strong, nonatomic, nullable) NSString *Key;
@property(strong, nonatomic, nullable) NSString *LastModified;
@property(strong, nonatomic, nullable) NSString *ETag;
@property(strong, nonatomic, nullable) KS3Owner *owner;
@property(assign, nonatomic) int32_t size;
@property(strong, nonatomic, nullable) NSString *storageClass;

@end
