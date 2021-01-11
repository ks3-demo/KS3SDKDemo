//
//  KSS3HeadObjectRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"

NS_ASSUME_NONNULL_BEGIN

@interface KS3HeadObjectRequest : KS3Request

@property(strong, nonatomic, nullable) NSString *range;
@property(strong, nonatomic, nullable) NSString *ifModifiedSince;
@property(strong, nonatomic, nullable) NSString *ifUnmodifiedSince;
@property(strong, nonatomic, nullable) NSString *ifMatch;
@property(strong, nonatomic, nullable) NSString *ifNoneMatch;
@property(strong, nonatomic, nonnull) NSString *key;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKey;

@end

NS_ASSUME_NONNULL_END
