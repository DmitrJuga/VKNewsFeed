//
//  VKAPIManager.h
//  VKNewsFeed
//
//  Created by DmitrJuga on 30.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VKAPIManagerDelegate;


@interface VKAPIManager : NSObject

@property (weak, nonatomic) id<VKAPIManagerDelegate> delegate;

+ (VKAPIManager *)managerWithDelegate:(id<VKAPIManagerDelegate>)aDelegate;
- (void)newsSearchByString:(NSString *)string;

@end


@protocol VKAPIManagerDelegate <NSObject>

@optional
- (void)manager:(VKAPIManager *)manager didSuccseedNewsSearchWithData:(NSArray *)data;
- (void)manager:(VKAPIManager *)manager didFailedNewsSearchWithError:(NSError *)error;

@end