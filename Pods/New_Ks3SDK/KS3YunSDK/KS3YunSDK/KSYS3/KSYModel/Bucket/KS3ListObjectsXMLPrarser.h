//
//  KSS3ListObjectsXMLPrarser.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KS3ListObjectsResult;
@interface KS3ListObjectsXMLPrarser : NSObject <NSXMLParserDelegate>
@property(strong, nonatomic, nullable) KS3ListObjectsResult *listBuctkResult;
- (void)kSS3XMLarse:(NSData *)dataXml;

@end
