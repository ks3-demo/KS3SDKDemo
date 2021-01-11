//
//  KingSoftMD5Util.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3MD5Util.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation KS3MD5Util

+ (NSString * _Nullable)hexEncode:(NSString * _Nullable)key text:(NSString * _Nullable)text {
  const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
  const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
  uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
  NSData *HMAC =
      [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
  NSString *strHash = @"";
  if ([HMAC respondsToSelector:@selector(base64EncodedDataWithOptions:)]) {
    strHash = [HMAC base64EncodedStringWithOptions:
                        NSDataBase64Encoding64CharacterLineLength];
  } else {
    strHash = [HMAC base64Encoding];
  }

  return strHash;
}

@end
