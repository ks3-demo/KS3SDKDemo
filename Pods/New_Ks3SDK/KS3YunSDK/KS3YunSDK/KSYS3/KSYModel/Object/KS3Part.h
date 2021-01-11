//
//  KSS3Part.h
//  NEW_KSCSDK
//
//  Created by ks3 on 12/16/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3Part : NSObject

@property(strong, nonatomic, nullable) NSString *etag;

@property(strong, nonatomic, nullable) NSString *lastModified;

@property(nonatomic, assign) int32_t partNumber;

@property(nonatomic, assign) long long size;

@end
NS_ASSUME_NONNULL_END
