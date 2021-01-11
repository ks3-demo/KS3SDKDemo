//
//  KS3DownLoad.h
//
//

#import "KS3Client.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class KS3Credentials;

@protocol KS3DownloadDelegate;
@interface KS3DownLoad : NSObject {

  BOOL _isFinished;
  BOOL _isStop;
  BOOL overwrite;
  NSString *url;
  NSString *fileName;
  NSString *filePath;
  unsigned long long fileSize;
@private
  NSString *destinationPath;
  NSString *temporaryPath;
  NSFileHandle *fileHandle;
  NSURLConnection *connection;
  unsigned long long offset;
}
- (instancetype _Nullable)initWithUrl:(NSString * _Nonnull)aUrl
      credentials:(KS3Credentials * _Nonnull)credentials
      bucketName:(NSString * _Nonnull)bucketName
       objectKey:(NSString * _Nonnull)objectKey;

@property(nonatomic, weak) id<KS3DownloadDelegate> delegate;

@property(strong, nonatomic, nonnull) NSString *bucketName;

@property(strong, nonatomic, nonnull) NSString *key;

@property(nonatomic, assign) BOOL overwrite;

@property(strong, nonatomic, nullable) NSString *url;

@property(strong, nonatomic, nonnull) NSString *fileName;

@property(strong, nonatomic, nullable) NSString *filePath;

@property(strong, nonatomic, nullable) NSString *httpMethod;

@property(strong, nonatomic, nullable) NSString *contentMd5;

@property(strong, nonatomic, nullable) NSString *contentType;

@property(strong, nonatomic, nullable) NSString *kSYHeader;

@property(strong, nonatomic, nullable) NSString *kSYResource;

@property(strong, nonatomic, nullable) NSString *strKS3Token;

@property(strong, nonatomic, nullable) NSDate *requestDate;

@property(strong, nonatomic, nullable) NSString *strDate;

@property NSTimeInterval timeoutInterval;

@property(nonatomic, readonly) unsigned long long fileSize;

@property(copy, nonatomic, nullable)
    KSS3DownloadProgressChangeBlock downloadProgressChangeBlock;

@property(copy, nonatomic, nullable) KSS3DownloadFailedBlock failedBlock;

@property(copy, nonatomic, nullable)
    kSS3DownloadFileCompleteionBlock downloadFileCompleteionBlock;

@property(copy, nonatomic, nullable) KSS3DownloadBeginBlock downloadBeginBlock;

- (void)start;

- (void)stop;

- (void)stopAndClear;

- (void)setStrKS3Token:(NSString * _Nullable)ks3Token;

@end

@protocol KS3DownloadDelegate <NSObject>

- (void)downloadBegin:(KS3DownLoad *)aDownload
    didReceiveResponseHeaders:(NSURLResponse *)responseHeaders;

- (void)downloadFaild:(KS3DownLoad *)aDownload
     didFailWithError:(NSError *)error;

- (void)downloadFinished:(KS3DownLoad *)aDownload filePath:(NSString * _Nullable)filePath;

- (void)downloadProgressChange:(KS3DownLoad *)aDownload
                      progress:(double)newProgress;

@end
NS_ASSUME_NONNULL_END
