//
//  KingSoftAuthUtils.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3AuthUtils.h"
#import "KS3Constants.h"
#import "KS3MD5Util.h"
#import "KS3ServiceRequest.h"

@implementation KS3AuthUtils

+ (NSString * _Nonnull)strAuthorizationWithHTTPVerb:(NSString * _Nullable)accessKey
                                 secretKey:(NSString * _Nullable)secretKey
                                  httpVerb:(KSS3_HTTPVerbType)httpVerb
                                contentMd5:(NSString * _Nullable)strContentMd5
                               contentType:(NSString * _Nullable)strContentType
                                      date:(NSDate *)date
                    canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                     canonicalizedResource:(NSString * _Nullable)strResource {
    NSString *strAuthorization = @"KSS ";
    strAuthorization = [strAuthorization stringByAppendingString:accessKey];
    strAuthorization = [strAuthorization stringByAppendingString:@":"];
    NSString *strSignature = [self strSignatureWithHTTPVerb:secretKey
                                                   httpVerb:httpVerb
                                                 contentMd5:strContentMd5
                                                contentType:strContentType
                                                       date:date
                                     canonicalizedKssHeader:strHeaders
                                      canonicalizedResource:strResource];
    strAuthorization = [strAuthorization stringByAppendingString:strSignature];
    return strAuthorization;
}

+ (NSString * _Nonnull)strSignatureWithHTTPVerb:(NSString * _Nullable)secretKey
                              httpVerb:(KSS3_HTTPVerbType)httpVerb
                            contentMd5:(NSString * _Nullable)strContentMd5
                           contentType:(NSString * _Nullable)strContentType
                                  date:(NSDate *)date
                canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                 canonicalizedResource:(NSString * _Nullable)strResource {
    // **** Http verb
    NSString *strHttpVerb = @"GET";
    switch (httpVerb) {
        case KSS3_HTTPVerbGet:
            strHttpVerb = @"GET";
            break;
        case KSS3_HTTPVerbPost:
            strHttpVerb = @"POST";
            break;
        case KSS3_HTTPVerbPut:
            strHttpVerb = @"PUT";
            break;
        case KSS3_HTTPVerbDelete:
            strHttpVerb = @"DELETE";
            break;
        default:
            break;
    }
    strHttpVerb = [strHttpVerb stringByAppendingString:@"\n"];

    // **** Content md5
    strContentMd5 = [strContentMd5 stringByAppendingString:@"\n"];

    // **** Content type
    strContentType = [strContentType stringByAppendingString:@"\n"];

    // **** Date
    NSString *strDate = [self strDateWithDate:date andType:@"GMT"];
    strDate = [strDate stringByAppendingString:@"\n"];

    // **** Header & Resource
    //    strHeaders = [strHeaders stringByAppendingString:@"\n"];

    // **** Signature
    NSString *strToSig = [strHttpVerb stringByAppendingString:strContentMd5];
    strToSig = [strToSig stringByAppendingString:strContentType];
    strToSig = [strToSig stringByAppendingString:strDate];
    strToSig = [strToSig stringByAppendingString:strHeaders];
    strToSig = [strToSig stringByAppendingString:strResource];
    strToSig = [KS3MD5Util hexEncode:secretKey text:strToSig];
    return strToSig;
}

+ (NSString * _Nonnull)strDateWithDate:(NSDate * _Nonnull)date andType:(NSString * _Nonnull)strType {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss"];
    NSString *str = [dateFormatter stringFromDate:date];
    NSString *strTime = [str stringByAppendingFormat:@" %@", strType];
    return strTime;
}

+ (NSString * _Nonnull)KSYSignatureWithSecretKey:(NSString * _Nonnull)secretKey
                               httpVerb:(NSString * _Nonnull)httpVerb
                             contentMd5:(NSString * _Nullable)strContentMd5
                            contentType:(NSString * _Nullable)strContentType
                                   date:(NSDate *_Nonnull)date
                 canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                  canonicalizedResource:(NSString * _Nullable)strResource {
    return [KS3AuthUtils KSYSignatureWithSecretKey:secretKey
                                          httpVerb:httpVerb
                                        contentMd5:strContentMd5
                                       contentType:strContentType
                                           strDate:[self strDateWithDate:date andType:@"GMT"]
                            canonicalizedKssHeader:strHeaders
                             canonicalizedResource:strResource];
}

+ (NSString * _Nonnull)KSYSignatureWithSecretKey:(NSString * _Nonnull)secretKey
                               httpVerb:(NSString * _Nonnull)httpVerb
                             contentMd5:(NSString * _Nullable)strContentMd5
                            contentType:(NSString * _Nullable)strContentType
                                strDate:(NSString * _Nonnull)strDate
                 canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                  canonicalizedResource:(NSString * _Nullable)strResource {
    // **** Signature
    NSString *strToSig = httpVerb;
    strToSig = [strToSig stringByAppendingString:@"\n"];

    if(strContentMd5) {
        strToSig = [strToSig stringByAppendingString:strContentMd5];
    }
    strToSig = [strToSig stringByAppendingString:@"\n"];

    if(strContentType) {
        strToSig = [strToSig stringByAppendingString:strContentType];
    }
    strToSig = [strToSig stringByAppendingString:@"\n"];

    strToSig = [strToSig stringByAppendingString:strDate];
    strToSig = [strToSig stringByAppendingString:@"\n"];

    if ([strHeaders stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
        strToSig = [strToSig stringByAppendingString:strHeaders];
        strToSig = [strToSig stringByAppendingString:@"\n"];
    }

    strToSig = [strToSig stringByAppendingString:strResource];

    NSLog(@"StringToSign: %@", strToSig);

    strToSig = [KS3MD5Util hexEncode:secretKey text:strToSig];
    return strToSig;
}

+ (NSString * _Nonnull)KSYAuthorizationWithAccessKey:(NSString * _Nonnull)accessKey
                                  secretKey:(NSString * _Nonnull)secretKey
                               httpVerbType:(KSS3_HTTPVerbType )httpVerb
                                 contentMd5:(NSString * _Nullable)strContentMd5
                                contentType:(NSString * _Nullable)strContentType
                                       date:(NSDate * _Nonnull)date
                     canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                      canonicalizedResource:(NSString * _Nullable)strResource {
    NSString *strHttpVerb = @"GET";
    switch (httpVerb) {
        case KSS3_HTTPVerbGet:
            strHttpVerb = @"GET";
            break;
        case KSS3_HTTPVerbPost:
            strHttpVerb = @"POST";
            break;
        case KSS3_HTTPVerbPut:
            strHttpVerb = @"PUT";
            break;
        case KSS3_HTTPVerbDelete:
            strHttpVerb = @"DELETE";
            break;
        default:
            break;
    }

    return [self KSYAuthorizationWithAccessKey:accessKey
                                     secretKey:secretKey
                                      httpVerb:strHttpVerb
                                    contentMd5:strContentMd5
                                   contentType:strContentType
                                          date:date
                        canonicalizedKssHeader:strHeaders
                         canonicalizedResource:strResource];
}

+ (NSString * _Nonnull)KSYAuthorizationWithAccessKey:(NSString * _Nonnull)accessKey
                                  secretKey:(NSString * _Nonnull)secretKey
                                   httpVerb:(NSString * _Nonnull)httpVerb
                                 contentMd5:(NSString * _Nullable)strContentMd5
                                contentType:(NSString * _Nullable)strContentType
                                       date:(NSDate *)date
                     canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                      canonicalizedResource:(NSString * _Nullable)strResource {
    NSString *strAuthorization = @"KSS ";
    strAuthorization = [strAuthorization stringByAppendingString:accessKey];
    strAuthorization = [strAuthorization stringByAppendingString:@":"];
    NSString *strSignature = [self KSYSignatureWithSecretKey:secretKey
                                                    httpVerb:httpVerb
                                                  contentMd5:strContentMd5
                                                 contentType:strContentType
                                                        date:date
                                      canonicalizedKssHeader:strHeaders
                                       canonicalizedResource:strResource];
    strAuthorization = [strAuthorization stringByAppendingString:strSignature];
    return strAuthorization;
}

+ (NSString * _Nonnull)KSYAuthorizationWithAccessKey:(NSString * _Nonnull)accessKey
                                  secretKey:(NSString * _Nonnull)secretKey
                                   httpVerb:(NSString * _Nonnull)httpVerb
                                 contentMd5:(NSString * _Nullable)strContentMd5
                                contentType:(NSString * _Nullable)strContentType
                                    strDate:(NSString * _Nonnull)strDate
                     canonicalizedKssHeader:(NSString * _Nullable)strHeaders
                      canonicalizedResource:(NSString * _Nullable)strResource {
    NSString *strAuthorization = @"KSS ";
    strAuthorization = [strAuthorization stringByAppendingString:accessKey];
    strAuthorization = [strAuthorization stringByAppendingString:@":"];
    NSString *strSignature = [self KSYSignatureWithSecretKey:secretKey
                                                    httpVerb:httpVerb
                                                  contentMd5:strContentMd5
                                                 contentType:strContentType
                                                     strDate:strDate
                                      canonicalizedKssHeader:strHeaders
                                       canonicalizedResource:strResource];
    strAuthorization = [strAuthorization stringByAppendingString:strSignature];
    return strAuthorization;
}

+ (void)signRequestV4:(KS3ServiceRequest *_Nonnull)serviceRequest
           urlRequest:(KS3URLRequest *_Nonnull)urlRequest
              headers:(NSMutableDictionary *_Nullable)headers
              payload:(NSString * _Nullable)payload
          credentials:(KS3Credentials *_Nullable)credentials {
    [urlRequest setValue:serviceRequest.strDate forHTTPHeaderField:@"Date"];
    NSString *strAuthorization = serviceRequest.strKS3Token;
    if (strAuthorization == nil && credentials.accessKey != nil && credentials.secretKey != nil) {
        strAuthorization = [KS3AuthUtils
                            KSYAuthorizationWithAccessKey:serviceRequest.credentials.accessKey
                            secretKey:serviceRequest.credentials.secretKey
                            httpVerb:serviceRequest.httpMethod
                            contentMd5:serviceRequest.contentMd5
                            contentType:serviceRequest.contentType
                            date:serviceRequest.requestDate
                            canonicalizedKssHeader:serviceRequest.kSYHeader
                            canonicalizedResource:serviceRequest.kSYResource];
    }
    [urlRequest setValue:strAuthorization forHTTPHeaderField:@"Authorization"];
    [urlRequest setURL:[NSURL URLWithString:serviceRequest.host]];
    [urlRequest setHTTPMethod:serviceRequest.httpMethod];
}

@end
