//
//  KSS3ListBucketsXMLParser.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3ListBucketsXMLParser.h"
#import "KS3Bucket.h"
#import "KS3Owner.h"
@interface KS3ListBucketsXMLParser ()
@property(strong, nonatomic, nullable) NSMutableString *currentTag;
@property(strong, nonatomic, nullable) NSMutableString *currentText;
@property(strong, nonatomic, nullable) KS3Bucket *bucket;
@end

@implementation KS3ListBucketsXMLParser

- (void)kSS3XMLarse:(NSData *)dataXml {
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataXml];
  [parser setDelegate:self];
  [parser parse];
}

#pragma mark - Xml delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  _listBuctkResult = [[KS3ListBucketsResult alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
  if (nil != _currentText) {
    _currentText = nil;
  }

  if ([elementName isEqualToString:@"Owner"]) {
    _listBuctkResult.owner = [KS3Owner new];
  }
  if ([elementName isEqualToString:@"Bucket"]) {
    if (nil != _bucket) {
      _bucket = nil;
    }
    _bucket = [KS3Bucket new];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  if (nil == _currentText) {
    _currentText = [[NSMutableString alloc] init];
  }
  [_currentText appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
  if ([elementName isEqualToString:@"ID"]) {
    _listBuctkResult.owner.ID = _currentText;
  }
  if ([elementName isEqualToString:@"DisplayName"]) {
    _listBuctkResult.owner.displayName = _currentText;
  }

  if ([elementName isEqualToString:@"Name"]) {
    _bucket.name = _currentText;
  }
  if ([elementName isEqualToString:@"CreationDate"]) {
    _bucket.creationDate = _currentText;
  }
  if ([elementName isEqualToString:@"Bucket"]) {
    [_listBuctkResult.buckets addObject:_bucket];
    _bucket = nil;
  }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
}

@end
