//
//  KS3Client.m
//  NEW_KSCSDK
//
//  Created by ks3 on 2020/08/06.
//  Copyright (c) 2020 kingsoft. All rights reserved.
//

#import "KS3Client.h"
#import "KS3AbortMultipartUploadRequest.h"
#import "KS3AbortMultipartUploadResponse.h"
#import "KS3AccessControlList.h"
#import "KS3AuthUtils.h"
#import "KS3ClientException.h"
#import "KS3CompleteMultipartUploadRequest.h"
#import "KS3CompleteMultipartUploadResponse.h"
#import "KS3CreateBucketRequest.h"
#import "KS3CreateBucketResponse.h"
#import "KS3Credentials.h"
#import "KS3DeleteBucketRequest.h"
#import "KS3DeleteBucketResponse.h"
#import "KS3DeleteBucketResponse.h"
#import "KS3DeleteObjectRequest.h"
#import "KS3DeleteObjectResponse.h"
#import "KS3DownLoad.h"
#import "KS3ErrorHandler.h"
#import "KS3GetACLRequest.h"
#import "KS3GetACLResponse.h"
#import "KS3GetBucketLoggingRequest.h"
#import "KS3GetBucketLoggingResponse.h"
#import "KS3GetObjectACLRequest.h"
#import "KS3GetObjectACLResponse.h"
#import "KS3GetObjectRequest.h"
#import "KS3GetObjectResponse.h"
#import "KS3HeadBucketRequest.h"
#import "KS3HeadBucketResponse.h"
#import "KS3HeadObjectRequest.h"
#import "KS3HeadObjectResponse.h"
#import "KS3InitiateMultipartUploadRequest.h"
#import "KS3InitiateMultipartUploadResponse.h"
#import "KS3ListBucketsRequest.h"
#import "KS3ListBucketsResponse.h"
#import "KS3ListBucketsResult.h"
#import "KS3ListObjectsRequest.h"
#import "KS3ListObjectsResponse.h"
#import "KS3ListObjectsResult.h"
#import "KS3ListPartsRequest.h"
#import "KS3ListPartsResponse.h"
#import "KS3PutObjectCopyRequest.h"
#import "KS3PutObjectCopyResponse.h"
#import "KS3PutObjectRequest.h"
#import "KS3PutObjectResponse.h"
#import "KS3SDKUtil.h"
#import "KS3SetACLRequest.h"
#import "KS3SetACLResponse.h"
#import "KS3SetBucketLoggingRequest.h"
#import "KS3SetBucketLoggingResponse.h"
#import "KS3SetGrantACLRequest.h"
#import "KS3SetGrantACLResponse.h"
#import "KS3SetObjectACLRequest.h"
#import "KS3SetObjectACLResponse.h"
#import "KS3SetObjectGrantACLRequest.h"
#import "KS3SetObjectGrantACLResponse.h"
#import "KS3UploadPartRequest.h"
#import "KS3UploadPartResponse.h"
#import <AssetsLibrary/AssetsLibrary.h>
static NSString *const KingSoftYun_Host_Name =
@"http://ks3-cn-beijing.ksyun.com";
static NSTimeInterval const KingSoftYun_RequestTimeout = 600; // in seconds

@interface KS3Client () <NSURLConnectionDataDelegate>

@property(assign, nonatomic) KS3BucketDomainRegion bucketDomainRegion;
@property(copy, nonatomic, nonnull) NSString *bucketDomainIp;
@property(strong, nonatomic, nullable) NSString *customBucketDomain; //用户自定义的domain
@property(strong, nonatomic, nullable) ALAssetsLibrary *assetsLibrary;

@end

@implementation KS3Client

+ (KS3Client * _Nullable)initialize {
    static KS3Client *shareObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[self alloc] init];
        shareObj.bucketDomainRegion = KS3BucketBeijing;
        shareObj.bucketDomainIp = @"ks3-cn-beijing.ksyun.com";
        shareObj.assetsLibrary = [[ALAssetsLibrary alloc] init];
        shareObj.enableHTTPS = YES;
    });
    return shareObj;
}

#pragma mark - Request Protocol
- (NSString * _Nullable)requestProtocol {
    return self.enableHTTPS ? @"https" : @"http";
}

#pragma mark - Init credentials

- (void)connectWithAccessKey:(NSString * _Nonnull)accessKey
               withSecretKey:(NSString * _Nonnull)secretKey {
    if (_credentials == nil) {
        _credentials = [[KS3Credentials alloc] initWithAccessKey:accessKey
                                                   withSecretKey:secretKey];
    }
}

- (void)setBucketDomainWithRegion:(KS3BucketDomainRegion)domainRegion {
    _bucketDomainRegion = domainRegion;
}

- (NSString * _Nonnull)getBucketDomain {
    if (_customBucketDomain != nil) {
        return _customBucketDomain;
    }

    if (_bucketDomainRegion == KS3BucketBeijing) {
        return @"ks3-cn-beijing.ksyun.com";
    }
    if (_bucketDomainRegion == KS3BucketAmerica) {
        return @"ks3-us-west-1.ksyun.com";
    }
    if (_bucketDomainRegion == KS3BucketHongkong) {
        return @"ks3-cn-hk-1.ksyun.com";
    }
    if (_bucketDomainRegion == KS3BucketShanghai) {
        return @"ks3-cn-shanghai.ksyun.com";
    }
    if (_bucketDomainRegion == KS3BucketQingdao) {
        return @"ks3-cn-qingdao.ksyun.com";
    }
    return @"ks3-cn-beijing.ksyun.com";
}

- (NSString * _Nullable)getCustomBucketDomain {
    if (_customBucketDomain && _bucketDomainRegion != KS3BucketPrivate) {
        return _customBucketDomain;
    } else {
        return nil;
    }
}

- (void)setBucketDomain:(NSString * _Nullable)domainRegion {
    _customBucketDomain = domainRegion;
}

#pragma mark - Buckets

- (NSArray * _Nullable)listBuckets:(KS3ListBucketsRequest * _Nonnull)listBucketsRequest {
    KS3ListBucketsResponse *listResponse =
    (KS3ListBucketsResponse * _Nullable)[self invoke:listBucketsRequest];
    if (listResponse.error == nil) {
        if (![listResponse respondsToSelector:@selector(listBucketsResult)]) {
            return nil;
        }
        if (listResponse.listBucketsResult != nil &&
            listResponse.listBucketsResult.buckets != nil) {
            return [NSArray arrayWithArray:listResponse.listBucketsResult.buckets];
        }
    }
    return nil;
}

- (KS3CreateBucketResponse * _Nullable)createBucket:(KS3CreateBucketRequest * _Nonnull)createBucketRequest {
    return (KS3CreateBucketResponse * _Nullable)[self invoke:createBucketRequest];
}

- (KS3DeleteBucketResponse * _Nullable)deleteBucket:(KS3DeleteBucketRequest * _Nonnull)deleteBucketRequest {
    return (KS3DeleteBucketResponse * _Nullable)[self invoke:deleteBucketRequest];
}

- (KS3HeadBucketResponse * _Nullable)headBucket:(KS3HeadBucketRequest * _Nonnull)headBucketRequest;
{ return (KS3HeadBucketResponse * _Nullable)[self invoke:headBucketRequest]; }

- (KS3GetACLResponse * _Nullable)getBucketACL:(KS3GetACLRequest * _Nonnull)getACLRequest {
    return (KS3GetACLResponse * _Nullable)[self invoke:getACLRequest];
}

- (KS3SetACLResponse * _Nullable)setBucketACL:(KS3SetACLRequest * _Nonnull)bucketACLRequest {
    return (KS3SetACLResponse * _Nullable)[self invoke:bucketACLRequest];
}

- (KS3GetBucketLoggingResponse * _Nullable)getBucketLogging:(KS3GetBucketLoggingRequest * _Nonnull)getBucketLoggingRequest {
    return (KS3GetBucketLoggingResponse * _Nullable)[self invoke:getBucketLoggingRequest];
}

- (KS3SetBucketLoggingResponse * _Nullable)setBucketLogging:(KS3SetBucketLoggingRequest * _Nonnull)setBucketTaggingRequest {
    return (KS3SetBucketLoggingResponse * _Nullable)[self invoke:setBucketTaggingRequest];
}

#pragma mark - Objects

- (KS3ListObjectsResponse * _Nullable)listObjects:(KS3ListObjectsRequest * _Nonnull)listObjectsRequest {
    return (KS3ListObjectsResponse * _Nullable)[self invoke:listObjectsRequest];
}

- (KS3GetObjectResponse * _Nullable)getObject:(KS3GetObjectRequest * _Nonnull)getObjectRequest {
    return (KS3GetObjectResponse * _Nullable)[self invoke:getObjectRequest];
}

- (KS3DeleteObjectResponse * _Nullable)deleteObject:(KS3DeleteObjectRequest * _Nonnull)deleteObjectRequest {
    return (KS3DeleteObjectResponse * _Nullable)[self invoke:deleteObjectRequest];
}

- (KS3HeadObjectResponse * _Nullable)headObject:(KS3HeadObjectRequest * _Nonnull)headObjectRequest {
    return (KS3HeadObjectResponse * _Nullable)[self invoke:headObjectRequest];
}

- (KS3PutObjectResponse * _Nullable)putObject:(KS3PutObjectRequest * _Nonnull)putObjectRequest {
    return (KS3PutObjectResponse * _Nullable)[self invoke:putObjectRequest];
}

- (KS3PutObjectCopyResponse * _Nullable)putObjectCopy:(KS3PutObjectCopyRequest * _Nonnull)putObjectCopyRequest {
    return (KS3PutObjectCopyResponse * _Nullable)[self invoke:putObjectCopyRequest];
}

- (KS3GetObjectACLResponse * _Nullable)getObjectACL:(KS3GetObjectACLRequest * _Nonnull)getObjectACLRequest {
    return (KS3GetObjectACLResponse * _Nullable)[self invoke:getObjectACLRequest];
}

- (KS3SetObjectACLResponse * _Nullable)setObjectACL:(KS3SetObjectACLRequest * _Nonnull)setObjectACLRequest {
    return (KS3SetObjectACLResponse * _Nullable)[self invoke:setObjectACLRequest];
}

- (KS3SetObjectGrantACLResponse * _Nullable)setObjectGrantACL:(KS3SetObjectGrantACLRequest * _Nonnull)setObjectGrantACLRequest {
    return (KS3SetObjectGrantACLResponse * _Nullable)[self invoke:setObjectGrantACLRequest];
}

- (KS3SetGrantACLResponse * _Nullable)setGrantACL:(KS3SetGrantACLRequest * _Nonnull)setGrantACLRequest {
    return (KS3SetGrantACLResponse * _Nullable)[self invoke:setGrantACLRequest];
}

#pragma mark - MultipartUpload

- (KS3MultipartUpload * _Nullable)initiateMultipartUploadWithRequest:(KS3InitiateMultipartUploadRequest * _Nonnull)request {
    KS3InitiateMultipartUploadResponse *response =
    (KS3InitiateMultipartUploadResponse * _Nullable)[self invoke:request];
    return response.multipartUpload;
}

- (KS3InitiateMultipartUploadResponse * _Nullable)initiateMultipartUploadWithRequestAndResponse:(KS3InitiateMultipartUploadRequest * _Nonnull)request {
    KS3InitiateMultipartUploadResponse *response = (KS3InitiateMultipartUploadResponse * _Nullable)[self invoke:request];
    return response;
}

- (KS3UploadPartResponse * _Nullable)uploadPart:(KS3UploadPartRequest * _Nonnull)uploadPartRequest {
    return (KS3UploadPartResponse * _Nonnull)[self invoke:uploadPartRequest];
}

- (NSData * _Nullable)getUploadPartDataWithPartNum:(NSInteger)partNum
                              partLength:(NSInteger)partlength
                              alassetURL:(NSURL * _Nullable)alassetURL {
    if (alassetURL == nil || alassetURL.absoluteString.length == 0) {
        NSLog(@"请检查AlassetURL");
        return nil;
    }
    if (partlength < 5 * 1024 * 1024) {
        NSLog(@"分块上传最小块为5MB");
        return nil;
    }
    if (partNum < 0) {
        NSLog(@"partNum不合法，请检查");
        return nil;
    }

    ALAsset *alasset =
    [[KS3Client initialize] getAlassetFromAlassetURL:alassetURL];
    return [self getUploadPartDataWithPartNum:partNum
                                   partLength:partlength
                                      Alasset:alasset];
}

- (NSData * _Nullable)getUploadPartDataWithPartNum:(NSInteger)partNum
                              partLength:(NSInteger)partlength
                                 Alasset:(ALAsset * _Nullable)assets {

    if (assets == nil) {
        NSLog(@"请检查Alasset");
        return nil;
    }
    if (partlength < 5 * 1024 * 1024) {
        NSLog(@"分块上传最小块为5MB");
        return nil;
    }
    if (partNum < 1) {
        NSLog(@"partNum不合法，请检查");
        return nil;
    }
    BOOL endOfStreamReached = NO;
    NSUInteger currentOffset = (partNum - 1) * partlength; //当前偏移量
    NSError *error;
    NSMutableData *mData = [[NSMutableData alloc] init];
    while (!endOfStreamReached) {
        NSInteger maxLength = 256 * 1024;
        uint8_t readBuffer[maxLength];
        NSInteger bytesRead = [assets.defaultRepresentation getBytes:readBuffer
                                                          fromOffset:currentOffset
                                                              length:maxLength
                                                               error:&error];
        if (bytesRead <= 0) {
            //读取完了或者读取地址不正确，导致读取为空
            endOfStreamReached = YES;
            if (mData.length > 0) {
                return mData;
            }
        } else {
            [mData appendBytes:readBuffer length:bytesRead];
            currentOffset += bytesRead;
            //正在读取,满5M则本地存储分块
            if (mData.length >= partlength) {
                return mData;
            }
        }
    }
    return mData;
}

- (ALAsset * _Nullable)getAlassetFromAlassetURL:(NSURL * _Nonnull)alassetURL {

    __block ALAsset *assets;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t concurrentQueue =
    dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(concurrentQueue, ^{

        [self.assetsLibrary assetForURL:alassetURL
                            resultBlock:^(ALAsset *asset) {
                                //本地存储的上传文件
                                assets = asset;
                                dispatch_semaphore_signal(sem);
                            }
                           failureBlock:^(NSError *error) {
                               NSLog(@"读取AssetURL出错,%@", error.localizedDescription);
                               dispatch_semaphore_signal(sem);
                           }];

    });
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    return assets;
}
- (KS3ListPartsResponse * _Nullable)listParts:(KS3ListPartsRequest * _Nonnull)listPartsRequest {
    return (KS3ListPartsResponse * _Nullable)[self invoke:listPartsRequest];
}

- (KS3CompleteMultipartUploadResponse * _Nullable)completeMultipartUpload:
(KS3CompleteMultipartUploadRequest * _Nonnull)completeMultipartUploadRequest {
    return (KS3CompleteMultipartUploadResponse * _Nullable)[self
                                                  invoke:completeMultipartUploadRequest];
}

- (KS3AbortMultipartUploadResponse * _Nullable)abortMultipartUpload:
(KS3AbortMultipartUploadRequest * _Nonnull)abortMultipartRequest {
    return (KS3AbortMultipartUploadResponse * _Nullable)[self invoke:abortMultipartRequest];
}

+ (instancetype _Nullable)constructResponseFromRequest:(KS3Request * _Nullable)request {
    NSString *requestClassName = NSStringFromClass([request class]);
    NSString *responseClassName =
    [[requestClassName substringToIndex:[requestClassName length] - 7]
     stringByAppendingFormat:@"Response"];
    id response = [[NSClassFromString(responseClassName) alloc] init];
    if (nil == response) {
        if ([requestClassName isEqualToString:@"KS3UploadRequest"]) {
            response = [[KS3InitiateMultipartUploadResponse alloc] init];
        } else {
            response = [[KS3Response alloc] init];
        }
    }
    return response;
}

- (NSMutableURLRequest * _Nullable)signKSS3Request:(KS3Request * _Nullable)request {
    request.credentials = _credentials;
    KS3URLRequest *urlRequest = [request configureURLRequest];
    return urlRequest;
}

- (NSTimeInterval)getRequestTimeOut:(KS3Request * _Nullable)request {
    NSTimeInterval ksyRequestTimeOut = request.timeoutInterval;
    if (ksyRequestTimeOut == 0 || ksyRequestTimeOut < 0) {
        ksyRequestTimeOut = KingSoftYun_RequestTimeout;
    }
    return ksyRequestTimeOut;
}
- (KS3Response * _Nullable)invoke:(KS3Request * _Nullable)request {
    NSString *message = nil;
    if ((_credentials.accessKey == nil || _credentials.secretKey == nil) &&
        _credentials != nil) {
        NSLog(@"######### 使用本地AK/SK签名, 请正确配置本地AK/SK #############");
        message = @"请正确配置本地AK/SK";
    }
    if (message) {
        KS3Response *response = [KS3Response new];
        response.error =
        [KS3ErrorHandler errorFromExceptionWithThrowsExceptionOption:
         [KS3ClientException exceptionWithMessage:message]];
        return response;
    }

    if (nil == request) {
        KS3Response *response = [KS3Response new];
        response.error = [KS3ErrorHandler
                          errorFromExceptionWithThrowsExceptionOption:
                          [KS3ClientException
                           exceptionWithMessage:@"Request cannot be nil."]];
        return response;
    }
    KS3ClientException *clientException = [request validate];
    if (clientException != nil) {
        KS3Response *response = [KS3Response new];
        response.error = [KS3ErrorHandler
                          errorFromExceptionWithThrowsExceptionOption:((NSException * _Nullable)
                                                                       clientException)];
        return response;
    }
    NSMutableURLRequest *urlRequest = [self signKSS3Request:request];

    [urlRequest setTimeoutInterval:[self getRequestTimeOut:request]];
    return [self startURLRequest:urlRequest
                      KS3Request:request
                           token:request.strKS3Token];
}

- (KS3Response * _Nullable)startURLRequest:(NSMutableURLRequest * _Nullable)urlRequest
                      KS3Request:(KS3Request * _Nullable)request
                           token:(NSString * _Nullable)strToken {
    if (strToken != nil) {
        [urlRequest setValue:strToken forHTTPHeaderField:@"Authorization"];
    }
    KS3Response *response = [KS3Client constructResponseFromRequest:request];
    [response setRequest:request];
    if ([request delegate] != nil) {
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest
                                                                         delegate:response
                                                                 startImmediately:NO];
        request.urlConnection = urlConnection;

        [NSTimer scheduledTimerWithTimeInterval:[self getRequestTimeOut:request]
                                         target:response
                                       selector:@selector(timeout)
                                       userInfo:nil
                                        repeats:NO];

        dispatch_async(dispatch_get_main_queue(), ^{
            [urlConnection start];
        });
        return nil;
    }
    NSURLConnection *urlConnection =
    [[NSURLConnection alloc] initWithRequest:urlRequest
                                    delegate:response
                            startImmediately:NO];
    [urlConnection scheduleInRunLoop:[NSRunLoop currentRunLoop]
                             forMode:KSYS3DefaultRunLoopMode];
    request.urlConnection = urlConnection;
    [urlConnection start];

    NSTimer *timeoutTimer =
    [NSTimer timerWithTimeInterval:[self getRequestTimeOut:request]
                            target:response
                          selector:@selector(timeout)
                          userInfo:nil
                           repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timeoutTimer
                                 forMode:KSYS3DefaultRunLoopMode];
    while (!response.isFinishedLoading) {
        [[NSRunLoop currentRunLoop]
         runMode:KSYS3DefaultRunLoopMode
         beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
    return response;
}

#pragma mark - Download

- (KS3DownLoad * _Nullable)
        downloadObjectWithBucketName:(NSString * _Nonnull)bucketName
        key:(NSString * _Nonnull)key
        downloadBeginBlock:(KSS3DownloadBeginBlock _Nullable)downloadBeginBlock
    downloadFileCompleteion:(kSS3DownloadFileCompleteionBlock _Nullable)downloadFileCompleteion
downloadProgressChangeBlock:(KSS3DownloadProgressChangeBlock _Nullable)downloadProgressChangeBlock
failedBlock:(KSS3DownloadFailedBlock _Nullable)failedBlock {
    if (!bucketName || !key) {
        NSLog(@"bucket 或 key 不能为空");
        return nil;
    }

    if ((_credentials.accessKey == nil || _credentials.secretKey == nil) &&
        _credentials != nil) {
        NSLog(@"######### 使用本地AK/SK签名, 请正确配置本地AK/SK #############");
        return nil;
    }
    NSLog(@"====== downloadObjectWithBucketName ======");
    NSString *strHost = [NSString
                         stringWithFormat:@"%@://%@.%@/%@",
                         [[KS3Client initialize] requestProtocol], bucketName,
                         [[KS3Client initialize] getBucketDomain], key];
    KS3DownLoad *downLoad = [[KS3DownLoad alloc] initWithUrl:strHost credentials:_credentials bucketName:bucketName objectKey:key];
    downLoad.downloadBeginBlock = downloadBeginBlock;
    downLoad.downloadFileCompleteionBlock = downloadFileCompleteion;
    downLoad.downloadProgressChangeBlock = downloadProgressChangeBlock;
    downLoad.failedBlock = failedBlock;
    
    return downLoad;
}

+ (NSString *_Nonnull)apiVersion {
    return @"1.0.2";
}

@end
