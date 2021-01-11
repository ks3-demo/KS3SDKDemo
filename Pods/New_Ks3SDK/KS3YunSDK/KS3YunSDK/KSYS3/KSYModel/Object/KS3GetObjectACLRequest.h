//
//  KSS3GetObjectACLRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Request.h"
NS_ASSUME_NONNULL_BEGIN
@interface KS3GetObjectACLRequest : KS3Request

@property(strong, nonatomic, nullable) NSString *key;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)bucketName
                 withKeyName:(NSString * _Nonnull)strKey;
@end
NS_ASSUME_NONNULL_END
