//
//  PhotoTableViewCell.h
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
