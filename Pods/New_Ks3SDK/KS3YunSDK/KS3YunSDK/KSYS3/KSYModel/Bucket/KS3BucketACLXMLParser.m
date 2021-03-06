//
//  KSS3BucketACLXMLParser.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3BucketACLXMLParser.h"
#import "KS3Grant.h"
@interface KS3BucketACLXMLParser ()
@property(strong, nonatomic, nullable) NSString *currentTag;
@property(strong, nonatomic, nullable) NSMutableString *currentText;
@property(strong, nonatomic, nullable) KS3Grant *grant;
@property(strong, nonatomic, nullable) KS3Grantee *grantee;
@property(nonatomic) BOOL isOwnerParser;
@property(nonatomic) BOOL isGrantParser;

@end
@implementation KS3BucketACLXMLParser
- (void)kSS3XMLarse:(NSData *)dataXml {
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataXml];
  [parser setDelegate:self];
  [parser parse];
}

#pragma mark - Xml delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  _listBuctkResult = [[KS3BucketACLResult alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
  if (nil != _currentText) {
    _currentText = nil;
  }
  _currentTag = elementName;

  if ([elementName isEqualToString:@"Owner"]) {
    _listBuctkResult.owner = [KS3Owner new];
    _isOwnerParser = YES;
    _isGrantParser = NO;
  }
  if ([elementName isEqualToString:@"Grant"]) {
    if (nil != _grant) {
      _grant = nil;
    }
    if (nil != _grantee) {
      _grantee = nil;
    }
    _grantee = [KS3Grantee new];
    _grant = [KS3Grant new];

    _isGrantParser = YES;
    _isOwnerParser = NO;
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  if (nil == _currentText) {
    _currentText = [[NSMutableString alloc] init];
  }
  [_currentText appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
  if (_isOwnerParser) {
    if ([elementName isEqualToString:@"ID"]) {
      _listBuctkResult.owner.ID = _currentText;
    }
    if ([elementName isEqualToString:@"DisplayName"]) {
      _listBuctkResult.owner.displayName = _currentText;
    }
  }
  if (_isGrantParser) {
    if ([elementName isEqualToString:@"ID"]) {
      _grantee.ID = _currentText;
    }
    if ([elementName isEqualToString:@"DisplayName"]) {
      _grantee.displayName = _currentText;
    }
    if ([elementName isEqualToString:@"URI"]) {
      _grantee.URI = _currentText;
    }
    if ([elementName isEqualToString:@"Permission"]) {
      _grant.permission = _currentText;
    }
  }
  if ([elementName isEqualToString:@"Owner"]) {
    _isOwnerParser = NO;
  }
  if ([elementName isEqualToString:@"Grant"]) {
    _isGrantParser = NO;
    _grant.grantee = _grantee;
    [_listBuctkResult.accessControlList addObject:_grant];
  }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
}

@end
