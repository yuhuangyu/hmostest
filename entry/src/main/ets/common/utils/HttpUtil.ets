/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { http } from '@kit.NetworkKit';
import { NewsData } from '../../viewmodel/NewsData';
import ResponseResult from '../../viewmodel/ResponseResult';
import { CommonConstants as Const, ContentType } from '../constants/CommonConstants';
import Logger from './Logger';
import { BusinessError } from '@kit.BasicServicesKit';

/*
*//**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 *//*
export function httpRequestGet(url: string): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: Const.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: Const.HTTP_READ_TIMEOUT,
    extraData: {}
  });
  let serverData: ResponseResult = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === Const.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.code === Const.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = $r('app.string.http_error_message');
    return serverData;
  })
}*/


/**
 * Initiate an HTTP GET request to the specified URL.
 *
 * @param url URL for initiating an HTTP request.
 */
export function httpRequestGet(url: string) {
  return httpRequest(url, http.RequestMethod.GET);
}

/**
 * Initiate an HTTP POST request to the specified URL.
 *
 * @param url URL for initiating an HTTP request
 * @param newsData Additional data of the request
 * @returns
 */
export function httpRequestPost(url: string, newsData: NewsData) {
  return httpRequest(url, http.RequestMethod.POST, newsData);
}

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request
 * @param method Request method.
 * @param extraData Additional data of the request.
 * @returns Returns {@link ResponseResult}.
 */
function httpRequest(url: string, method: http.RequestMethod, params?: NewsData): Promise<ResponseResult> {
  // 每一个httpRequest对应一个HTTP请求任务，不可复用
  let httpRequest = http.createHttp();
  // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
  // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
  httpRequest.on('headersReceive', (header) => {
    Logger.info('header: ' + JSON.stringify(header));
  });
  let responseResult = httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    url, {
    method: method,  // 可选，默认为http.RequestMethod.GET
    // 开发者根据自身业务需要添加header字段
    header: {
      'Content-Type': ContentType.JSON
    },
    readTimeout: Const.HTTP_READ_TIMEOUT,  // 可选，默认为60000ms
    connectTimeout: Const.HTTP_READ_TIMEOUT,  // 可选，默认为60000ms
    // usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
    // usingProxy: false, // 可选，默认不使用网络代理，自API 10开始支持该属性
    // caPath:'/path/to/cacert.pem', // 可选，默认使用系统预制证书，自API 10开始支持该属性
    // clientCert: { // 可选，默认不使用客户端证书，自API 11开始支持该属性
    //   certPath: '/path/to/client.pem', // 默认不使用客户端证书，自API 11开始支持该属性
    //   keyPath: '/path/to/client.key', // 若证书包含Key信息，传入空字符串，自API 11开始支持该属性
    //   certType: http.CertType.PEM, // 可选，默认使用PEM，自API 11开始支持该属性
    //   keyPassword: "passwordToKey" // 可选，输入key文件的密码，自API 11开始支持该属性
    // },
    // multiFormDataList: [ // 可选，仅当Header中，'content-Type'为'multipart/form-data'时生效，自API 11开始支持该属性
    //   {
    //     name: "Part1", // 数据名，自API 11开始支持该属性
    //     contentType: 'text/plain', // 数据类型，自API 11开始支持该属性
    //     data: 'Example data', // 可选，数据内容，自API 11开始支持该属性
    //     remoteFileName: 'example.txt' // 可选，自API 11开始支持该属性
    //   }, {
    //   name: "Part2", // 数据名，自API 11开始支持该属性
    //   contentType: 'text/plain', // 数据类型，自API 11开始支持该属性
    //   // data/app/el2/100/base/com.example.myapplication/haps/entry/files/fileName.txt
    //   filePath: `${getContext(this).filesDir}/fileName.txt`, // 可选，传入文件路径，自API 11开始支持该属性
    //   remoteFileName: 'fileName.txt' // 可选，自API 11开始支持该属性
    // }
    // ],
    // usingCache: true, // 可选，默认为true
    // expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型,expectDataType字段指定返回数据的类型，系统不一定会返回指定的类型。
    extraData: params   //  当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定
  }
  /*, (err: BusinessError, data: http.HttpResponse) => {

  }*/
  );
  let serverData = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    // data.result为HTTP响应内容，可根据业务需要进行解析
    // data.header为HTTP响应头，可根据业务需要进行解析

    if (value.responseCode === Const.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.code === Const.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = $r('app.string.http_error_message');
    return serverData;
  });
}