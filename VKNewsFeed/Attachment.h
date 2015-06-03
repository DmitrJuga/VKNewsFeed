//
//  Attachment.h
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Attachment : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *imageURLString;
@property (assign, nonatomic) CGSize imageOriginSize;
@property (strong, nonatomic) NSString *title;

+ (instancetype)objectFromDictionary:(NSDictionary *)dict;

@end
