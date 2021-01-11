//
//  KingSoftServiceResponse.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class KS3ServiceRequest;
@interface KS3ServiceResponse : NSObject {
  NSMutableData *body;
}
@property(nonatomic, readonly,nullable) NSData *body;
@property(nonatomic, readonly) BOOL isFinishedLoading;
@property(nonatomic, readonly) BOOL didTimeout;
@property(strong, nonatomic, nullable) NSDictionary *responseHeader;
@property(nonatomic) int32_t httpStatusCode;

@property(readonly, copy,nullable) NSURL *URL;

@property(readonly, copy,nullable) NSString *MIMEType;

@property(readonly) long long expectedContentLength;

@property(readonly, copy,nullable) NSString *textEncodingName;

@property(readonly, copy,nullable) NSString *suggestedFilename;

@property(strong, nonatomic, nullable) NSError *error;

@property(strong, nonatomic, nullable) KS3ServiceRequest *request;
- (void)timeout;
@end
NS_ASSUME_NONNULL_END
