//
//  KSS3ListPartsResultXMLParser.h
//  NEW_KSCSDK
//
//  Created by ks3 on 12/16/14.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListPartsResult.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface KS3ListPartsResultXMLParser : NSObject <NSXMLParserDelegate>

@property(strong, nonatomic, nullable) KS3ListPartsResult *listPartsResult;

- (void)kSS3XMLarse:(NSData *)dataXml;

@end
NS_ASSUME_NONNULL_END
