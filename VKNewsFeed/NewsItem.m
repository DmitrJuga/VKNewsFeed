//
//  NewsItem.m
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "AppConstants.h"
#import "NewsItem.h"

@implementation NewsItem

// маппинг сущности NewsItem из NSDictionary
+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    NewsItem *item = [[NewsItem alloc] init];
    
    // owner
    NSDictionary *owner = dict[@"group"] ?: dict[@"user"];
    if (![owner isKindOfClass:[NSNull class]]) {
        item.ownerName = owner[@"name"] ? : [NSString stringWithFormat:@"%@ %@", owner[@"last_name"], owner[@"first_name"]];
        item.ownerImageURL = [NSURL URLWithString:owner[@"photo"]];
    }
    // content
    item.date = [NSDate dateWithTimeIntervalSince1970:[dict[@"date"] integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = DATETIME_FORMAT;
    item.formatedDate = [formatter stringFromDate:item.date];
    item.text = [dict[@"text"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    item.text = (item.text.length > 8192) ? [item.text substringToIndex:8192] : item.text;
    
    // attachment
    NSDictionary *attach = dict[@"attachment"];
    if (attach) {
        item.attachment = [Attachment objectFromDictionary:attach];
    }
    // attachments
    NSArray *attaches = dict[@"attachments"];
    NSMutableArray *resArray = [[NSMutableArray alloc] initWithCapacity:attaches.count];
    if (attaches) {
        for (NSDictionary *dict in attaches) {
            [resArray addObject:[Attachment objectFromDictionary:dict]];
        }
        item.attachments = resArray;
    }
    return item;
}

@end
