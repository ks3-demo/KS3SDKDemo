//
//  ListBucketObjects.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KS3ListObjectsResult : NSObject

@property(strong, nonatomic, nullable) NSMutableArray *objectSummaries;
@property(strong, nonatomic, nullable) NSString *bucketName;
@property(strong, nonatomic, nullable) NSString *prefix;
@property(strong, nonatomic, nullable) NSString *marker;
@property(strong, nonatomic, nullable) NSString *NextMarker;
@property(nonatomic) int32_t maxKeys;
@property(strong, nonatomic, nullable) NSString *delimiter;
@property(assign, nonatomic) BOOL IsTruncated;
@property(strong, nonatomic, nullable) NSMutableArray *commonPrefixes;
@end
