import http from '@ohos.net.http';
import { Log } from '@devwiki/base/Index';
import { APIError, APIHeader, APIQuery, APIRequestMethod, Organization } from './APIModel';
import { APIRequest } from './APIModel';
import { APIResult } from './APIModel';

const TAG = '[RestAPI]'

export class RestAPI {

  private baseUrl: string ='https://gitea.com/api/v1';
  private readonly timeout = 10000;
  private baseQuery: string = '?=0';
  private defaultHeaders: APIHeader[] = [
    { "connection" : "keep-alive" },
    { 'accept-encoding' : 'gzip, deflate, br, zstd' },
    { 'accept-language' : 'zh-CN,zh;q=0.9,en;q=0.8' }
  ];

  public getAllOrganizations(callback: (result: APIResult<Organization[]>) => void) {
    let path = '/orgs'
    let url = this.getUrl(path);
    Log.info(TAG, 'getOrgByName url:' + url);
    this.request({
      url: url,
      method: APIRequestMethod.GET
    }, callback);
  }

  public getAllOrganizationsByPage(page: number, limit: number, callback: (result: APIResult<Organization[]>) => void) {
    let path = '/orgs'
    let extraQuery = new APIQuery()
    extraQuery.set('page', page);
    extraQuery.set('limit', limit);
    let url = this.getUrl(path, extraQuery);
    Log.info(TAG, 'getOrgByName url:' + url);
    this.request({
      url: url,
      method: APIRequestMethod.GET
    }, callback);
  }

  public getOrgByName(name: string, callback: (result: APIResult<Organization>) => void) {
    let path = `/orgs/${name}`;
    let url = this.getUrl(path);
    Log.info(TAG, 'getOrgByName url:' + url);
    this.request({
      url: url,
      method: APIRequestMethod.GET
    }, callback);
  }

  request<T>(apiReq: APIRequest, callback: (result: APIResult<T>) => void) {
    Log.info(TAG, 'request, url:' + apiReq.url)
    let httpRequest = http.createHttp();
    let option:http.HttpRequestOptions = this.createHttpRequestOption(apiReq);
    httpRequest.request(apiReq.url, option, (error, resp) =>{
      let result: APIResult<T> = new APIResult();
      if (!error) {
        Log.info(TAG, 'result, httpCode:' + result.httpCode + ', data:' + resp.result?.toString())
        result.httpCode = resp.responseCode;
        try {
          if (resp.responseCode == http.ResponseCode.OK) {
            result.data = JSON.parse(resp.result?.toString()) as T
          } else {
            result.error = JSON.parse(resp.result?.toString()) as APIError;
          }
        } catch (e) {
          Log.error(TAG, 'result json parse error:' + e)
        }
        callback?.(result);
      } else {
        result.businessError = error;
        callback?.(result);
        Log.error(TAG, `request ${apiReq.url} failed, code:${error.code}, message:${error.message}`)
      }
      httpRequest.destroy();
    });
  }

  private createHttpRequestOption(apiReq: APIRequest): http.HttpRequestOptions{
    let headers: APIHeader[] = this.defaultHeaders;
    if (apiReq.header) {
      apiReq.header.forEach((header) =>{
        headers.push(header);
      })
    }
    let method: http.RequestMethod = http.RequestMethod.GET;
    if (apiReq.method == APIRequestMethod.POST) {
      method = http.RequestMethod.POST;
    } else if (apiReq.method == APIRequestMethod.PUT) {
      method = http.RequestMethod.PUT;
    } else if (apiReq.method == APIRequestMethod.DELETE) {
      method = http.RequestMethod.DELETE;
    } else {
      method = http.RequestMethod.GET;
    }
    return {
      method: method,
      extraData : apiReq.extraData,
      readTimeout : this.timeout,
      connectTimeout: this.timeout,
      expectDataType: http.HttpDataType.STRING,
      header: headers,
      usingProtocol: http.HttpProtocol.HTTP1_1
    };
  }

  private getUrl(path: string, extraQuery?: APIQuery): string {
    let url = `${this.baseUrl}${path}${this.baseQuery}`;
    if (extraQuery) {
      for (let key of extraQuery.keys()) {
        url += `&${key}=${extraQuery.get(key)}`
      }
    }
    Log.debug(TAG, `get url, path: ${path}, url:${url}`)
    return url;
  }

}

