//
//  QCHttpHandler.m
//  News
//
//  Created by QC.L on 15/1/16.
//  Copyright (c) 2015年 QC.L. All rights reserved.
//

#import "QCHttpHandler.h"
#import "AFNetworking.h"

@implementation QCHttpHandler

+ (void)get:(NSString *)url body:(NSDictionary *)body result:(QCHTTPStyle)QCHTTPStyle success:(void (^)(id result))success  failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 2.判断网络数据形式
    switch (QCHTTPStyle) {
        case QCHttp:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case QCJson:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case QCXml:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    // 3.将url进行文字处理
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // 4.发送GET请求
    [manager GET:url parameters:body
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             
//             if (QCHTTPStyle == QCHttp) {
//                 id result = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];
//                 success(result);
//             } else {
                 success(responseObj);
//             }
             
             
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

+ (void)post:(NSString *)url body:(NSDictionary *)body success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:body
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}
@end
