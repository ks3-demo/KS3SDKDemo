//
//  KSS3Grant.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class KS3Grantee;
@interface KS3Grant : NSObject
@property(strong, nonatomic, nullable) NSString *permission;
@property(strong, nonatomic, nullable) KS3Grantee *grantee;

@end

@interface KS3Grantee : NSObject
@property(strong, nonatomic, nonnull) NSString *ID;
@property(strong, nonatomic, nonnull) NSString *displayName;
@property(strong, nonatomic, nonnull) NSString *URI;

@end
NS_ASSUME_NONNULL_END
