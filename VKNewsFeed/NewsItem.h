//
//  NewsItem.h
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

@interface NewsItem : NSObject

@property (strong, nonatomic) NSURL *ownerImageURL;
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *formatedDate;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) Attachment *attachment;
@property (strong, nonatomic) NSArray *attachments;

+ (instancetype)objectFromDictionary:(NSDictionary *)dict;

@end
