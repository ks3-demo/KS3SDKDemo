
#KS3 SDK for iOS 签名相关使用指南
---
###Ks3Client初始化
Ks3Client初始化包含以下两种：

- 直接利用AccessKeyID、AccessKeySecret初始化（***不安全,仅建议测试时使用***）
- 实现授权回调（AuthListener）获取Token（签名），即由客户app端向客户业务服务器发送带签名参数的请求，业务服务器实现签名算法并返回Token（签名），SDK及对应Demo中的**AuthUtils**类提供了该算法的Java实现。之后SDK会将onCalculateAuth（）方法返回的Token（签名）带入所有请求，用户正常调用SDK提供的API即可（***推荐使用***）

###请求签名
方法: 在请求中加入名为 Authorization 的 Header，值为签名值。形如：
Authorization: KSS P3UPCMORAFON76Q6RTNQ:vU9XqPLcXd3nWdlfLWIhruZrLAM=

*签名生成规则*
```

		Authorization = “KSS YourAccessKeyID:Signature”

 		Signature = Base64(HMAC-SHA1(YourAccessKeyIDSecret, UTF-8-Encoding-Of( StringToSign ) ) );

 		StringToSign = HTTP-Verb + "\n" +
               Content-MD5 + "\n" +
               Content-Type + "\n" +
               Date + "\n" +
               CanonicalizedKssHeaders +
               CanonicalizedResource;

```

**关于签名的必要说明：**


对于使用AuthListener以Token方式初始化SDK的用户，需要注意onCalculateAuth（）回调方法中的参数，即为计算StringToSign的参数，服务器端应根据上述签名生成规则，利用AccessKeyID及AccessKeySecret**计算出签名并正确返回给SDK**。

onCalculateAuth（）回调方法的参数Content-MD5, Content-Type, CanonicalizedKssHeaders参数**可为空**。若为空，则SDK会使用空字符串("")替代, 但Date和CanonicalizedResource不能为空。

为保证请求时间的一致性，需要App客户端及客户业务服务器保证各自的时间正确性，否则用**错误的时间**尝试请求，会返回403Forbidden错误。

onCalculateAuth（）回调方法参数说明：

* Content-MD5 表示请求内容数据的MD5值, 使用Base64编码
* Content-Type 表示请求内容的类型
* Date 表示此次操作的时间,且必须为 HTTP1.1 中支持的 GMT 格式，客户端应**务必**保证本地时间正确性
* CanonicalizedKssHeaders 表示HTTP请求中的以x-kss开头的Header组合
* CanonicalizedResource 表示用户访问的资源

对应的初始化代码如下：

***For AccessKeyID、AccessKeySecret***

```

		/* Directly using ak&sk */
	    client = new Ks3Client(Constants.ACCESS_KEY_ID,Constants.ACCESS_KEY_SECRET, DummyActivity.this);
	    configuration = Ks3ClientConfiguration.getDefaultConfiguration();
		client.setConfiguration(configuration);
		client.setEndpoint("ks3-cn-beijing.ksyun.com");

```

***For iOS 参考示例***  

```
//获取服务端token 上传文件
- (void)singleUploadByAppServer
{
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"7.6M" ofType:@"mov"];
    __block NSData *bodyData = [NSData dataWithContentsOfFile:fileName options:NSDataReadingMappedIfSafe error:nil];
    __block NSString *md5Str = [KS3SDKUtil base64md5FromData:bodyData];
    _fileSize = bodyData.length;
    NSArray* canonicalizedKssHeaders = @[@"x-kss-acl:public-read-write"];
    NSString *testPrefix = @"ks3DemoTest/";//只开放了桶下这个前缀的权限 测试的时候可以换成自己的ak sk
    [UploadApi getTokenByFileMsg:md5Str contentType:@"application/octet-stream" objectKey:[NSString stringWithFormat:@"%@7.6M.mov",testPrefix] canonicalizedKssHeaders:canonicalizedKssHeaders completionHandler: ^ (NSData * data, NSURLResponse * response, NSError * error) {
        if (error) {
            NSLog(@ "%@", error);
        } else {
            
            NSError * parseError = nil;
            NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData: data options: 0 error: & parseError];
            NSString * signature = [[responseDictionary objectForKey:@"data"] objectForKey:@"signature"];
            NSString * bucketName = [[responseDictionary objectForKey:@"data"] objectForKey:@"bucket"];
            NSString * objectKey = [[responseDictionary objectForKey:@"data"] objectForKey:@"objectKey"];
            NSDictionary * headers = [[responseDictionary objectForKey:@"data"] objectForKey:@"headers"];
            NSString * stringToSign = [[responseDictionary objectForKey:@"data"] objectForKey:@"stringToSign"];
            NSString * region = [[responseDictionary objectForKey:@"data"] objectForKey:@"region"];
   
            KS3PutObjectRequest *putObjRequest = [[KS3PutObjectRequest alloc] initWithName:bucketName withAcl:nil grantAcl:nil];
            putObjRequest.data = bodyData;
            putObjRequest.filename = objectKey;
            putObjRequest.contentMd5 = md5Str;
            putObjRequest.strDate = [[responseDictionary objectForKey:@"data"] objectForKey:@"date"];
            [[KS3Client initialize] setBucketDomain:[NSString stringWithFormat:@"%@.%@",bucketName,region]];
            for (NSString * key in headers) {
                [putObjRequest.urlRequest setValue:[headers objectForKey:key] forHTTPHeaderField:key];
            }
            //使用token签名时从Appserver获取token后设置token，使用Ak sk则忽略，不需要调用
            [putObjRequest setStrKS3Token:signature];
            [putObjRequest setCompleteRequest];
          
            NSLog(@"Request Headers is %@",putObjRequest.urlRequest.allHTTPHeaderFields);
            NSLog(@"signature is %@",putObjRequest.strKS3Token);
            
            KS3PutObjectResponse *response = [[KS3Client initialize] putObject:putObjRequest];
            NSLog(@"%@",[[NSString alloc] initWithData:response.body encoding:NSUTF8StringEncoding]);
            if (response.httpStatusCode == 200) {
                NSLog(@"Put object success");
            }
            else {
                NSLog(@"Put object failed");
            }
        }
    }];

}
		
```
***For php参考示例***  

```
		 /**
     * 生成ks3签名
     *
     * @param array $queryParams
     * @return array
     */
    public function getSignature(array $queryParams)
    {
        $contentMd5 = $queryParams['contentMd5'] ?? '';
        $contentType = $queryParams['contentType'] ?? "application/ocet-stream";
        $fileName = $queryParams['objectKey'];
        $canonicalizedKS3Headers = $queryParams['canonicalizedKS3Headers'];

        $httpMethod = 'PUT';
        $date = gmdate(Form::DATE_FORMAT_DATE_TIME_GMT);
        $ak = $this->getAk();
        $sk = $this->getSk();
        $bucket = $this->getBucket();
        $region = $this->getRegion();

        $signHeaders = array();
        $canonicalizedResource = '/' . $bucket . '/' . $fileName;
        $authorization = 'KSS ';
        $reqHeaders = array();
        $canonicalizedKS3HeadersStr = "";
        if ($canonicalizedKS3Headers) {
             $signList = array(
                $httpMethod,
                $contentMd5,
                $contentType,
                $date
            );
            sort($canonicalizedKS3Headers,SORT_STRING);
            for($i=0;$i<sizeof($canonicalizedKS3Headers);$i++){
                $dict  = explode(':',$canonicalizedKS3Headers[$i]);
                $key   = current($dict);
                $value = end($dict);
              	$reqHeaders[$key]=$value;
              	array_push($signList,$canonicalizedKS3Headers[$i]);
              }
        	array_push($signList,$canonicalizedResource);
        } else {
            $signList = array(
                $httpMethod,
                $contentMd5,
                $contentType,
                $date,
                $canonicalizedResource
            );
        }

        $stringToSign = join("\n", $signList);
        $signature = base64_encode(hash_hmac('sha1', $stringToSign, $sk, true));
        //生成ks3签名
        $authorization .= $ak . ':' . $signature;
        return [
            'signList' => $signList,
            'stringToSign' => $stringToSign,
            'signature' => $authorization,
            'bucket' => $bucket,
            'objectKey' => $fileName,
            'date' => $date,
            'headers' => $reqHeaders,
            'region' => $region
        ];
    }
```



接口地址->GET -http://www.cqc.cool/file/get_signature

以下可以终端直接访问

```
curl --location --request GET 'http://www.cqc.cool/file/get_signature' \
--data-raw '{
    "contentType": "application/octet-stream",
    "contentMd5": "yWWDKbCCV2TBujZ/q5Tw5w==",
    "objectKey": "ks3DemoTest/7.6M.mov",
    "canonicalizedKS3Headers": [
        "x-kss-acl:public-read-write"
    ]
}'
```



RequestBody:

```
{
    "contentType": "application/octet-stream",
    "contentMd5": "yWWDKbCCV2TBujZ/q5Tw5w==",
    "objectKey": "ks3DemoTest/7.6M.mov",
    "canonicalizedKS3Headers": [
        "x-kss-acl:public-read-write"
    ]
}
```



ResponseBody:

```
{
    "errno": 10000,
    "errmsg": "OK",
    "data": {
        "signList": [
            "PUT",
            "yWWDKbCCV2TBujZ/q5Tw5w==",
            "application/octet-stream",
            "Mon, 11 Jan 2021 11:51:16 GMT",
            "x-kss-acl:public-read-write",
            "/ks3tools-test/ks3DemoTest/7.6M.mov"
        ],
        "stringToSign": "PUT\nyWWDKbCCV2TBujZ/q5Tw5w==\napplication/octet-stream\nMon, 11 Jan 2021 11:51:16 GMT\nx-kss-acl:public-read-write\n/ks3tools-test/ks3DemoTest/7.6M.mov",
        "signature": "KSS AKLT2fGMS1bKRXizdrYZ4_uBBA:DzHqep1zRM4OaoF6wg7lzyl+4Ts=",
        "bucket": "ks3tools-test",
        "objectKey": "ks3DemoTest/7.6M.mov",
        "date": "Mon, 11 Jan 2021 11:51:16 GMT",
        "headers": {
            "x-kss-acl": "public-read-write"
        },
        "region": "ks3-cn-shanghai.ksyun.com"
    },
    "request_id": "fc904568-1043-40d0-b940-d016f27f1bb5"
}
```



