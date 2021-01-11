//
//  KingSoftCredentials.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KS3Credentials : NSObject

@property(strong, readonly, nonatomic) NSString *accessKey;
@property(strong, readonly, nonatomic) NSString *secretKey;

- (instancetype _Nullable)initWithAccessKey:(NSString * _Nullable)accessKey
          withSecretKey:(NSString * _Nullable)secretKey;

@end
