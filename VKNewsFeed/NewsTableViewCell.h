//
//  NewsTableViewCell.h
//  VKNewsFeed
//
//  Created by DmitrJuga on 27.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface NewsTableViewCell : UITableViewCell

- (void)setupCellForItem:(NewsItem *)item;

@end
