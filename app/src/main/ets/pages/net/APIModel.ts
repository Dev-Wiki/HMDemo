import { BusinessError } from '@ohos.base';

export class  APIQuery extends Map<string, string|number|boolean> { }

export interface APIHeader {
  [key: string]: string;
}

export enum APIRequestMethod {
  GET, POST, PUT, DELETE
}

export class APIRequest {
  url: string = "";
  method: APIRequestMethod = APIRequestMethod.POST;
  extraData?: string | Object | ArrayBuffer;
  header?: APIHeader[];
}

export class APIResult<T> {
  httpCode: number;
  businessError?: BusinessError;
  error?: APIError;
  data?: T;
}

export interface APIError{
  errors: string[];
  message: string;
  url: string;
}

export interface Organization {
  id: number;
  name: string;
  full_name: string;
  email: string;
  avatar_url: string;
  description: string;
  website: string;
  location: string;
  visibility: string;
  repo_admin_change_team_access: boolean;
  username: string;
}