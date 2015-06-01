//
//  DetailsViewController.m
//  VKNewsFeed
//
//  Created by DmitrJuga on 01.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "UIKit+AFNetworking.h"
#import "AppConstants.h"
#import "DetailsViewController.h"
#import "TextTableViewCell.h"
#import "PhotoTableViewCell.h"
#import "AttachTableViewCell.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *newsDateTime;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // заголовок
    self.ownerName.text = self.item.ownerName;
    [self.ownerImageView setImageWithURL:self.item.ownerImageURL
                        placeholderImage:[UIImage imageNamed:@"dummy"]];
    self.newsDateTime.text = self.item.formatedDate;
    
    // "круглая аватарка"
    self.ownerImageView.layer.cornerRadius = self.ownerImageView.bounds.size.width / 2;
    self.ownerImageView.clipsToBounds = YES;

    // динамический размер ячеек таблицы
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


#pragma mark UITableViewDataSource

// кол-во строк
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item.attachments.count + 1;
}

// содержимое ячейки
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // текст
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TEXT_CELL forIndexPath:indexPath];
        cell.text.text = self.item.text;
        return cell;
    } else {
        Attachment *attach = self.item.attachments[indexPath.row - 1];
        // фото
        if ([attach.type isEqualToString:@"photo"]) {
            PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PHOTO_CELL forIndexPath:indexPath];
            // загрузка фото с отложенным отображением в ячейке
            NSURL *url = [NSURL URLWithString:attach.URLString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            __weak PhotoTableViewCell *weakCell = cell;
            __weak UITableView *weakTableView = tableView;
            [cell.photoView setImageWithURLRequest:request placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               weakCell.photoView.image = image;
                                               if ([weakTableView.visibleCells containsObject:weakCell]) {
                                                   [weakTableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
                                               }
                                           } failure:nil];
            cell.titleLabel.text = attach.title;
            return cell;
        } else {
            // неподдерживаемый контент
            AttachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ATTACH_CELL forIndexPath:indexPath];
            cell.typeLabel.text = [NSString stringWithFormat:@"[неподдерживаемый контент: %@]", attach.type];
            cell.titleLabel.text = attach.title;
            return cell;
        }
    }
}

@end
