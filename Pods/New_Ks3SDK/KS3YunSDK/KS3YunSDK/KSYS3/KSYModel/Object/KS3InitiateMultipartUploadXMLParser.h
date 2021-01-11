//
//  KSS3InitiateMultipartUploadXMLParser.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3InitiateMultipartUploadResult.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3InitiateMultipartUploadXMLParser : NSObject <NSXMLParserDelegate>
@property(strong, nonatomic, nullable) KS3InitiateMultipartUploadResult *listBuctkResult;
- (void)kSS3XMLarse:(NSData *)dataXml;

@end
NS_ASSUME_NONNULL_END
