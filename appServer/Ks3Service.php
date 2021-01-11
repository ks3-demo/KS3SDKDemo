<?php

namespace App\Domain\UploadFile;

use App\ApiView;
use App\Config\Form;
use App\Support\Ks3;
use PocFramework\IoC;
use PocFramework\Support\Config;
use PocFramework\Support\Log;
use Psr\Container\ContainerInterface;
use Ramsey\Uuid\Uuid;

/**
 * Class Ks3Service
 * @package App\Domain\UploadFile
 *
 * @property ApiView apiView
 */
class Ks3Service extends IoC
{
    const EXPIRES = 3600;
    const SERVER_NAME = 'ks3';

    private $config;

    private $client = null;

    /**
     * Ks3Service constructor.
     * @param ContainerInterface $container
     */
    public function __construct(ContainerInterface $container)
    {
        parent::__construct($container);

        $this->config = (new Config('api'))->toArray()[self::SERVER_NAME];
    }

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

    public function getAk()
    {
        return $this->config['ak'];
    }

    public function getSk()
    {
        return $this->config['sk'];
    }

    public function getBucket()
    {
          return $this->config['bucket'];
    }

    public function getPrefix()
    {
        return $this->config['prefix'];
    }

    public function getRegion()
    {
        return $this->config['endPoint'];
    }
}