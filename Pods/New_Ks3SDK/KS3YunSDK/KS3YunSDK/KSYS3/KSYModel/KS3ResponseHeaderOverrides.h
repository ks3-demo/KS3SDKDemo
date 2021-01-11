//
//  KSS3ResponseHeaderOverrides.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3ResponseHeaderOverrides : NSObject

@property(strong, nonatomic, nullable) NSString *contentType;

@property(strong, nonatomic, nullable) NSString *contentLanguage;

@property(strong, nonatomic, nullable) NSString *expires;

@property(strong, nonatomic, nullable) NSString *cacheControl;

@property(strong, nonatomic, nullable) NSString *contentDisposition;

@property(strong, nonatomic, nullable) NSString *contentEncoding;

@property(nonatomic, assign) NSString *queryString;

@end
NS_ASSUME_NONNULL_END
