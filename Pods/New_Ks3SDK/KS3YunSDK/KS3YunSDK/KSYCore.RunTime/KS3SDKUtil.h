//
//  KingSoftSDKUtil.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const KSYS3DefaultRunLoopMode;
@interface KS3SDKUtil : NSObject
NSDate *getCurrentDate();
+ (NSString * _Nullable)base64md5FromData:(NSData *)data;
+ (NSString * _Nullable)urlEncode:(NSString * _Nullable)input;
+ (NSString * _Nullable)applicationDocumentFilePath;
+ (BOOL)isIpString:(NSString * _Nullable)aString;
+ (BOOL)isVaildBucketName:(NSString * _Nullable)bucket;
@end

@interface NSData (WithBase64)

/**
 * Return a base64 encoded representation of the data.
 *
 * @return base64 encoded representation of the data.
 */
- (NSString * _Nullable)base64EncodedString;

/**
 * Decode a base-64 encoded string into a new NSData object.
 *
 * @param encodedString an base-64 encoded string
 *
 * @return NSData with the data represented by the encoded string.
 */
+ (NSData *)dataWithBase64EncodedString:(NSString * _Nullable)encodedString;

@end
@interface NSString (Md5)
- (NSString * _Nullable)MD5Hash;
@end
