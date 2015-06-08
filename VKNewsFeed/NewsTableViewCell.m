//
//  NewsTableViewCell.m
//  VKNewsFeed
//
//  Created by DmitrJuga on 27.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "UIKit+AFNetworking.h"
#import "AppConstants.h"
#import "NewsTableViewCell.h"

@interface NewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsDateTime;

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *showAll;

@end
    
@implementation NewsTableViewCell

// Заполнение кастомной ячейки
- (void)setupCellForItem:(NewsItem *)item {
    // owner
    self.ownerName.text = item.ownerName;
    [self.ownerImageView setImageWithURL:item.ownerImageURL
                        placeholderImage:[UIImage imageNamed:@"dummy"]];
    // content
    self.newsDateTime.text = item.formatedDate;
    if (item.text.length > SHORT_TEXT_LENGTH) {
        self.text.text = [[item.text substringToIndex:SHORT_TEXT_LENGTH] stringByAppendingString:@"..."];
        self.showAll.text = @"Показать полностью...";
    } else {
        self.text.text = item.text;
        self.showAll.text = @"";
    }
    
    // "круглая аватарка"
    self.ownerImageView.layer.cornerRadius = self.ownerImageView.bounds.size.width / 2;
    self.ownerImageView.clipsToBounds = YES;
}

@end
