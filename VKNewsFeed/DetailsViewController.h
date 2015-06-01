//
//  DetailsViewController.h
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface DetailsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NewsItem *item;

@end
