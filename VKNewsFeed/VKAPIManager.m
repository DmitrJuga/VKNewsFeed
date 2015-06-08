//
//  VKAPIManager.m
//  VKNewsFeed
//
//  Created by DmitrJuga on 30.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "VKAPIManager.h"
#import "NewsItem.h"

#define     SERVER_URL    @"https://api.vk.com/method/"
#define     METHOD_NEWS_SEARCH     @"newsfeed.search"

@interface VKAPIManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation VKAPIManager

// инициализатор
- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *URL = [NSURL URLWithString:SERVER_URL];
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:URL];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

// возвращает менеджер с делегатом
+ (VKAPIManager *)managerWithDelegate:(id<VKAPIManagerDelegate>)aDelegate {
    VKAPIManager *manager = [[VKAPIManager alloc] init];
    manager.delegate = aDelegate;
    return manager;
}

// Осуществляет поиск новостей по заданной подстроке
- (void)newsSearchByString:(NSString *)string {
    NSDictionary *params = @{ @"q" : string,
                              @"extended" : @"1" };
    [self.manager GET:METHOD_NEWS_SEARCH parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  if ([responseObject[@"response"] isKindOfClass:[NSArray class]]) {
                      // маппинг ответа
                      NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:30];
                      for (id val in responseObject[@"response"]) {
                          if ([val isKindOfClass:[NSDictionary class]]) {
                              [result addObject:[NewsItem objectFromDictionary:val]];
                          }
                      }
                      [self.delegate manager:self didSucceedSearchWithData:result];
                  } else {
                      [self.delegate manager:self didSucceedSearchWithData:nil];
                  }
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   if ([self.delegate respondsToSelector:@selector(manager:didFailedSearchWithError:)]) {
                      [self.delegate manager:self didFailedSearchWithError:error];
                  } else {
                      NSLog(@"Error: %@", error);
                  }
              }];
}


@end

