//
//  KSS3BucketACLXMLParser.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3BucketACLResult.h"
#import <Foundation/Foundation.h>

@interface KS3BucketACLXMLParser : NSObject <NSXMLParserDelegate>
@property(strong, nonatomic, nullable) KS3BucketACLResult *listBuctkResult;
- (void)kSS3XMLarse:(NSData *)dataXml;

@end
