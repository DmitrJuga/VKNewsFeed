//
//  Attachment.m
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "Attachment.h"

@implementation Attachment

// маппинг сущности Attachment из NSDictionary
+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    Attachment *attach = [[Attachment alloc] init];
    
    attach.type = dict[@"type"];
    if ([attach.type isEqualToString:@"photo"]) {
        attach.URLString = dict[@"photo"][@"src_big"];
        attach.title = dict[@"photo"][@"text"];
    } else if ([attach.type isEqualToString:@"video"]) {
        attach.title = dict[@"video"][@"title"];
    } if ([attach.type isEqualToString:@"link"]) {
        attach.title = [NSString stringWithFormat:@"%@\n%@", dict[@"link"][@"title"], dict[@"link"][@"url"]];
    } else if ([attach.type isEqualToString:@"note"]) {
        attach.title = dict[@"note"][@"title"];
    } else if ([attach.type isEqualToString:@"audio"]) {
        attach.title = [NSString stringWithFormat:@"%@ - %@", dict[@"audio"][@"artist"], dict[@"audio"][@"title"]];
    } else if ([attach.type isEqualToString:@"doc"]) {
        attach.title = dict[@"doc"][@"title"];
    } else if ([attach.type isEqualToString:@"page"]) {
        attach.title = dict[@"page"][@"title"];
    }
    if (attach.title) {
        attach.title = [attach.title stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    }
    return attach;
}

@end
