//
//  KingSoftServiceRequest.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Credentials.h"
#import "KS3URLRequest.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KS3ServiceResponse;
@class KS3ClientException;
@protocol KingSoftServiceRequestDelegate;
@interface KS3ServiceRequest : NSObject
@property(strong, nonatomic, nullable) KS3Credentials *credentials;
@property(strong, nonatomic, nonnull) KS3URLRequest *urlRequest;
@property(strong, nonatomic, nullable) NSString *httpMethod;
@property(strong, nonatomic, nonnull) NSURLConnection *urlConnection;
@property(strong, readonly, nonatomic,nullable) NSURL *url;
@property(strong, nonatomic, nonnull) NSString *host;
@property(strong, nonatomic, nullable) NSString *contentMd5;
@property(strong, nonatomic, nullable) NSString *contentType;
@property(strong, nonatomic, nonnull) NSString *kSYResource;
@property(strong, nonatomic, nullable) NSDate *requestDate;
@property(strong, nonatomic, nullable) NSString *strDate;
@property(strong, nonatomic, nonnull) NSString *strKS3Token;
@property NSTimeInterval timeoutInterval;
@property(weak, nonatomic,nullable) id<KingSoftServiceRequestDelegate> delegate;

- (KS3URLRequest * _Nonnull)configureURLRequest;
- (void)sign;
- (KS3ClientException * _Nullable)validate;
- (void)cancel;
- (NSString * _Nullable)URLEncodedString:(NSString * _Nullable)str;
- (void)setCompleteRequest;

- (NSString * _Nullable)kSYHeader;
@end

@protocol KingSoftServiceRequestDelegate <NSObject>

@optional

- (void)request:(KS3ServiceRequest * _Nullable)request
    didReceiveResponse:(NSURLResponse * _Nullable)response;

- (void)request:(KS3ServiceRequest * _Nullable)request didReceiveData:(NSData * _Nullable)data;

- (void)request:(KS3ServiceRequest * _Nullable)request
    didCompleteWithResponse:(KS3ServiceResponse * _Nullable)response;

- (void)request:(KS3ServiceRequest * _Nullable)request
                  didSendData:(long long)bytesWritten
            totalBytesWritten:(long long)totalBytesWritten
    totalBytesExpectedToWrite:(long long)totalBytesExpectedToWrite;

- (void)request:(KS3ServiceRequest * _Nullable)request didFailWithError:(NSError * _Nullable)error;

- (void)request:(KS3ServiceRequest * _Nullable)request
    didFailWithServiceException:(NSException * _Nullable)exception
    __attribute__((deprecated));

@end

NS_ASSUME_NONNULL_END
