//
//  DGBBookCoverCollectionViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookCoverCollectionViewController.h"
#import "DGBBookCoverHorizontalTableViewCell.h"
#import "UITableViewCell+DGBCellNameGenerator.h"
#import "DGBBookDetailViewController.h"

@interface DGBBookCoverCollectionViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Private Properties

@property (strong, nonatomic) NSArray *bookCoverCollectionTypeList;

@property (strong, nonatomic) UITableView *bookCoverHorizontalTableView;

@end

#pragma mark -

@implementation DGBBookCoverCollectionViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"홈 화면"];
    
    _bookCoverCollectionTypeList = @[@"ItemNewSpecial", @"Bestseller"];
    
    [self setUpBookCoverHorizontalTableView];
    
    [self setUpConstraints];
}

#pragma mark - Set Up Methods

- (void)setUpBookCoverHorizontalTableView {
    _bookCoverHorizontalTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                                 style:UITableViewStylePlain];
    
    [self.bookCoverHorizontalTableView setRowHeight:200.0];
    
    [self.bookCoverHorizontalTableView setDelegate:self];
    [self.bookCoverHorizontalTableView setDataSource:self];
    
    [self.bookCoverHorizontalTableView registerClass:[DGBBookCoverHorizontalTableViewCell class]
                              forCellReuseIdentifier:[DGBBookCoverHorizontalTableViewCell className]];
    
    [self.view addSubview:self.bookCoverHorizontalTableView];
}

- (void)setUpConstraints {
    [self.bookCoverHorizontalTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *rootViewSafeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[[self.bookCoverHorizontalTableView.topAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.topAnchor],
                                              [self.bookCoverHorizontalTableView.bottomAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.bottomAnchor],
                                              [self.bookCoverHorizontalTableView.leadingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.leadingAnchor],
                                              [self.bookCoverHorizontalTableView.trailingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.trailingAnchor]]];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.bookCoverCollectionTypeList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.bookCoverCollectionTypeList[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBookCoverHorizontalTableViewCell *bookCoverHorizontalTableViewCell = [tableView dequeueReusableCellWithIdentifier:[DGBBookCoverHorizontalTableViewCell className]
                                                                                                            forIndexPath:indexPath];
    
    NSString *bookCoverCollectionType = self.bookCoverCollectionTypeList[indexPath.section];
    
    __weak typeof(self) weakSelf = self;
    
    [bookCoverHorizontalTableViewCell setPresentBookDetailBlock:^(DGBBookDetailViewController *bookDetailViewController) {
        [weakSelf showViewController:bookDetailViewController
                              sender:weakSelf];
    }];
    [bookCoverHorizontalTableViewCell setUpBookCoverCollectionType:bookCoverCollectionType];
    
    return bookCoverHorizontalTableViewCell;
}

@end
