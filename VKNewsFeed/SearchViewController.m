//
//  ViewController.m
//  VKNewsFeed
//
//  Created by DmitrJuga on 27.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "AppConstants.h"
#import "SearchViewController.h"
#import "DetailsViewController.h"
#import "NewsTableViewCell.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *activityBar;

@property (strong, nonatomic) VKAPIManager *manager;
@property (strong, nonatomic) NSMutableArray *arrayResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayResults = [[NSMutableArray alloc] init];
    self.manager = [VKAPIManager managerWithDelegate:self];
    
    self.activityBar.hidden = YES;
    self.activityBar.layer.cornerRadius = 10;
    
    self.tableView.estimatedRowHeight = 90;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.searchBar becomeFirstResponder];
}


#pragma mark UITableViewDataSource

// кол-во строк
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayResults.count;
}

// содержимое ячейки
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RESULT_CELL forIndexPath:indexPath];
     [cell setupCellForItem:self.arrayResults[indexPath.row]];
    return cell;
}


#pragma mark UITableViewDelagate

// нажатие на ячейку
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SEQUE_DETAILS sender:nil];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark UISearchBarDelegate

// нажатие кнопки Найти
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 2) {
        [searchBar resignFirstResponder];
        
        [self.arrayResults removeAllObjects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationFade];
        
        self.activityBar.hidden = NO;
        [self.manager newsSearchByString:searchBar.text];
    }
}

// нажатие кнопки Отмена
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (self.arrayResults.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
}

// начало редактирования - показываем кнопку Отмена
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    return YES;
}

// конец редактирования - убираем кнопку Отмена
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    return YES;
}


#pragma mark VKAPIManagerDelegate

// получен результат
-(void)manager:(VKAPIManager *)manager didSuccseedNewsSearchWithData:(NSArray *)data {
    self.activityBar.hidden = YES;
    
    if (!data || data.count == 0) {
        // ничего не найдено - возвращаемся в строку поиска
        [self.searchBar becomeFirstResponder];
    } else {
         // загружаем результат в tableView
        [self.arrayResults addObjectsFromArray:data];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
}

// получена ошибка
-(void)manager:(VKAPIManager *)manager didFailedNewsSearchWithError:(NSError *)error {
    self.activityBar.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Ошибка"
                                                   message:error.localizedDescription
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
    [self.searchBar becomeFirstResponder];
}


#pragma mark Action Handlers

// нажатие кнопки в NavigationBar
- (IBAction)btnSearchPressed:(id)sender {
    [self.searchBar becomeFirstResponder];
    [self.tableView scrollRectToVisible:self.searchBar.frame animated:YES];
}


#pragma mark Navigation

// передаём параметры в DetailsViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    vc.item = self.arrayResults[indexPath.row];
}


@end
