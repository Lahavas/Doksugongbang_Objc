//
//  DGBBookListViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookListViewController.h"
#import "UITableViewCell+DGBCellNameGenerator.h"
#import "DGBBook.h"
#import "DGBBookMainView.h"
#import "DGBBookListTableViewCell.h"
#import "DGBBookDetailViewController.h"
#import "DGBDataLoader.h"
#import "AladinAPI.h"

@interface DGBBookListViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Private Properties

@property (strong, nonatomic) UITableView *bookListTableView;

@end

#pragma mark -

@implementation DGBBookListViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:self.bookListTitle];
    
    [self setUpBookListTableView];
    [self setUpConstraints];
}

#pragma mark - Set Up Methods

- (void)setUpBookListTableView {
    self.bookListTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStylePlain];
    
    [self.bookListTableView setDelegate:self];
    [self.bookListTableView setDataSource:self];
    
    [self.bookListTableView setEstimatedRowHeight:160.0];
    [self.bookListTableView setRowHeight:UITableViewAutomaticDimension];
    
    UINib *bookListCellNib = [UINib nibWithNibName:[DGBBookListTableViewCell className]
                                            bundle:nil];
    [self.bookListTableView registerNib:bookListCellNib
                 forCellReuseIdentifier:[DGBBookListTableViewCell className]];
    
    [self.view addSubview:self.bookListTableView];
}

- (void)setUpConstraints {
    [self.bookListTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *rootViewSafeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
    
    NSLayoutConstraint *bookListTableViewTopConstraint = [self.bookListTableView.topAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.topAnchor];
    NSLayoutConstraint *bookListTableViewBottomConstraint = [self.bookListTableView.bottomAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.bottomAnchor];
    NSLayoutConstraint *bookListTableViewLeadingConstraint = [self.bookListTableView.leadingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.leadingAnchor];
    NSLayoutConstraint *bookListTableViewTrailingConstraint = [self.bookListTableView.trailingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[bookListTableViewTopConstraint,
                                              bookListTableViewBottomConstraint,
                                              bookListTableViewLeadingConstraint,
                                              bookListTableViewTrailingConstraint]];
}

#pragma mark - Private Methods

- (void)presentBookDetailViewControllerWithISBN:(NSString *)isbnString {
    __weak typeof(self) weakSelf = self;
    
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemLookUp
                                          parameters:@{@"ItemId": isbnString,
                                                       @"ItemIdType": @"ISBN13"}];
    [[DGBDataLoader sharedInstance] fetchDataWithURL:url
                                          completion:^(NSData *data) {
                                              DGBBook *book = [AladinAPI bookParsingFromJSONData:data];
                                              
                                              DGBBookDetailViewController *bookDetailViewController = [[DGBBookDetailViewController alloc] init];
                                              [bookDetailViewController setBook:book];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [weakSelf showViewController:bookDetailViewController
                                                                        sender:weakSelf];
                                              });
                                          }];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBook *book = self.bookList[indexPath.row];
    [self presentBookDetailViewControllerWithISBN:book.isbn];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DGBBookListTableViewCell className]
                                                                     forIndexPath:indexPath];
    
    DGBBook *book = self.bookList[indexPath.row];
    
    [cell.bookMainView setContentsWithBook:book];
    
    return cell;
}

@end
