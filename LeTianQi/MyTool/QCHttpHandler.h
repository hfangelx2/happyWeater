//
//  QCHttpHandler.h
//  News
//
//  Created by QC.L on 15/1/16.
//  Copyright (c) 2015年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QCHTTPStyle) {
    QCHttp, // 返回Data数据
    QCXml,  // 返回XML数据
    QCJson  // 返回JSON数据
};

@interface QCHttpHandler : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param body    请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)get:(NSString *)url body:(NSDictionary *)body result:(QCHTTPStyle)QCHTTPStyle success:(void (^)(id result))success  failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param body    请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+ (void)post:(NSString *)url body:(NSDictionary *)body success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
