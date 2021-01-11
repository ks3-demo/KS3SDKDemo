//
//  KSS3InitiateMultipartUploadXMLParser.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3InitiateMultipartUploadXMLParser.h"
#import "KS3MultipartUpload.h"
@interface KS3InitiateMultipartUploadXMLParser ()
@property(strong, nonatomic, nullable) KS3MultipartUpload *multipartUpload;
@property(strong, nonatomic, nullable) NSString *currentTag;
@property(strong, nonatomic, nullable) NSMutableString *currentText;
@end

@implementation KS3InitiateMultipartUploadXMLParser

- (void)kSS3XMLarse:(NSData *)dataXml {
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataXml];
  [parser setDelegate:self];
  [parser parse];
}

#pragma mark - Xml delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  _listBuctkResult = [[KS3InitiateMultipartUploadResult alloc] init];
  _multipartUpload = [[KS3MultipartUpload alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
  if (nil != _currentText) {
    _currentText = nil;
  }
  _currentTag = elementName;

  if ([elementName isEqualToString:@"Bucket"]) {
  }
  if ([elementName isEqualToString:@"Key"]) {
  }
  if ([elementName isEqualToString:@"UploadId"]) {
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
  if (nil == _currentText) {
    _currentText = [[NSMutableString alloc] init];
  }
  [_currentText appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
  if ([elementName isEqualToString:@"Bucket"]) {
    _multipartUpload.bucket = _currentText;
  }
  if ([elementName isEqualToString:@"Key"]) {

    _multipartUpload.key = _currentText;
  }
  if ([elementName isEqualToString:@"UploadId"]) {
    _multipartUpload.uploadId = _currentText;
  }
  if ([elementName isEqualToString:@"InitiateMultipartUploadResult"]) {
    _listBuctkResult.multipartUpload = _multipartUpload;
  }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
}

@end
