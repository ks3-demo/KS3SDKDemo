//
//  KS3UploadManager.h
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KS3Client;
@class KS3Request;
@class KS3Response;
@class KS3UploadRequest;
@class KS3Upload;

#define kKB 1024
#define kMB 1048576

typedef void (^KS3UploadErrorHandler)(KS3Upload * _Nullable upload, NSError *_Nullable error);
typedef void (^KS3UploadCompletionHandler)(KS3Upload * _Nullable upload, KS3Response * _Nullable response);
typedef void (^KS3UploadProgressHandler)(NSString * _Nullable key, double percent);
typedef BOOL (^KS3UploadCancellationSignal)(NSString * _Nullable key);
typedef NSString * _Nullable (^KS3AuthCalculateHandler)(KS3Request * _Nullable request);

@interface KS3UploadManager : NSObject

- (instancetype _Nonnull)initWithClient:(KS3Client * _Nonnull)client authHandler:(KS3AuthCalculateHandler _Nullable)authHandler;

+ (instancetype _Nonnull)sharedInstanceWithClient:(KS3Client * _Nonnull)client authHandler:(KS3AuthCalculateHandler _Nullable)authHandler;

- (void)putData:(NSData *_Nonnull)data
        request:(KS3UploadRequest *_Nonnull)request
      blockSize:(NSInteger)size
       progress:(KS3UploadProgressHandler _Nullable)progressHandler
   cancelSignal:(KS3UploadCancellationSignal _Nullable)cancelSignal
       complete:(KS3UploadCompletionHandler _Nullable)completionHandler
          error:(KS3UploadErrorHandler _Nullable)errorHandler;

- (void)resumeUpload:(NSData * _Nonnull)data
              upload:(KS3Upload * _Nonnull)upload
            progress:(KS3UploadProgressHandler _Nullable)progressHandler
        cancelSignal:(KS3UploadCancellationSignal _Nullable)cancelSignal
            complete:(KS3UploadCompletionHandler _Nullable)completionHandler
               error:(KS3UploadErrorHandler _Nullable)errorHandler;

@end
NS_ASSUME_NONNULL_END
