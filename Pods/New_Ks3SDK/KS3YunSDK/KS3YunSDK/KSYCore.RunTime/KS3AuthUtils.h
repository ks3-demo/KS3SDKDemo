//
//  KingSoftAuthUtils.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3AuthUtils.h"
#import <Foundation/Foundation.h>
typedef enum {
    KSS3_HTTPVerbGet,
    KSS3_HTTPVerbPost,
    KSS3_HTTPVerbPut,
    KSS3_HTTPVerbDelete,
    KSS3_HTTPVerbHead,
} KSS3_HTTPVerbType;

@class KS3ServiceRequest;
@class KS3Credentials;
@class KS3URLRequest;

@interface KS3AuthUtils : NSObject

+ (NSString * _Nonnull)KSYSignatureWithSecretKey:(NSString * _Nonnull)secretKey
                               httpVerb:(NSString * _Nonnull)httpVerb
                             contentMd5:(NSString * _Nullable)strContentMd5
                            contentType:(NSString * _Nullable)strContentType
                                             date:(NSDate *_Nonnull)date
                 canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                  canonicalizedResource:(NSString * _Nullable)strResource;

+ (NSString * _Nonnull)KSYSignatureWithSecretKey:(NSString * _Nonnull)secretKey
                               httpVerb:(NSString * _Nonnull)httpVerb
                             contentMd5:(NSString * _Nullable)strContentMd5
                            contentType:(NSString * _Nullable)strContentType
                                strDate:(NSString * _Nonnull)strDate
                 canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                  canonicalizedResource:(NSString * _Nullable)strResource;

+ (NSString * _Nonnull)KSYAuthorizationWithAccessKey:(NSString * _Nonnull)accessKey
                                  secretKey:(NSString * _Nonnull)secretKey
                               httpVerbType:(KSS3_HTTPVerbType)httpVerb
                                 contentMd5:(NSString * _Nullable)strContentMd5
                                contentType:(NSString * _Nullable)strContentType
                                       date:(NSDate * _Nonnull)date
                     canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                      canonicalizedResource:(NSString * _Nullable)strResource;

+ (NSString * _Nonnull)strDateWithDate:(NSDate *_Nonnull)date andType:(NSString * _Nonnull)strType;

+ (void)signRequestV4:(KS3ServiceRequest *_Nonnull)serviceRequest
           urlRequest:(KS3URLRequest *_Nonnull)urlRequest
              headers:(NSMutableDictionary *_Nullable)headers
              payload:(NSString * _Nullable)payload
          credentials:(KS3Credentials *_Nullable)credentials;

+ (NSString * _Nonnull)KSYAuthorizationWithAccessKey:(NSString * _Nonnull)accessKey
                                  secretKey:(NSString * _Nonnull)secretKey
                                   httpVerb:(NSString * _Nonnull)httpVerb
                                 contentMd5:(NSString * _Nullable)strContentMd5
                                contentType:(NSString * _Nullable)strContentType
                                       date:(NSDate *)date
                     canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                      canonicalizedResource:(NSString * _Nullable)strResource;

+ (NSString * _Nonnull)KSYAuthorizationWithAccessKey:(NSString * _Nonnull)accessKey
                                  secretKey:(NSString * _Nonnull)secretKey
                                   httpVerb:(NSString * _Nonnull)httpVerb
                                 contentMd5:(NSString * _Nullable)strContentMd5
                                contentType:(NSString * _Nullable)strContentType
                                    strDate:(NSString * _Nonnull)strDate
                     canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                      canonicalizedResource:(NSString * _Nullable)strResource;

@end
