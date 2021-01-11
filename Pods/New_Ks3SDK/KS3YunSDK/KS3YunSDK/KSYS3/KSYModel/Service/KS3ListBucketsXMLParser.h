//
//  KSS3ListBucketsXMLParser.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListBucketsResult.h"
#import "KS3Owner.h"
#import <Foundation/Foundation.h>

@interface KS3ListBucketsXMLParser : NSObject <NSXMLParserDelegate>
@property(strong, nonatomic, nullable) KS3ListBucketsResult *listBuctkResult;
- (void)kSS3XMLarse:(NSData *)dataXml;
@end
