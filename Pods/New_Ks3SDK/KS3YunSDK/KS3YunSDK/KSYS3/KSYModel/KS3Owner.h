//
//  KS3Owner.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3Owner : NSObject

@property(strong, nonatomic, nonnull) NSString *ID;

@property(strong, nonatomic, nonnull) NSString *displayName;

- (instancetype _Nonnull)initWithID:(NSString * _Nonnull)theID withDisplayName:(NSString * _Nonnull)theDisplayName;

+ (instancetype _Nonnull)ownerWithID:(NSString * _Nonnull)theID withDisplayName:(NSString * _Nonnull)theDisplayName;

@end
NS_ASSUME_NONNULL_END
