//
//  DGBBookCoverHorizontalTableViewCell.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookCoverHorizontalTableViewCell.h"
#import "DGBBook.h"
#import "DGBBookCoverCollectionViewCell.h"
#import "DGBBookCoverView.h"
#import "DGBBookDetailViewController.h"
#import "UICollectionViewCell+DGBCellNameGenerator.h"
#import "DGBDataLoader.h"
#import "AladinAPI.h"

@interface DGBBookCoverHorizontalTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

#pragma mark - Private Properties

@property (strong, nonatomic) NSArray<DGBBook *> *bookList;

@property (strong, nonatomic) UICollectionView *bookCoverCollectionView;

@end

#pragma mark -

@implementation DGBBookCoverHorizontalTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUpBookCoverCollectionView];
        
        [self setUpConstraints];
    }
    
    return self;
}

#pragma mark - Set Up Methods

- (void)setUpBookCoverCollectionView {
    CGFloat bookCoverCellWidth = 100.0;
    CGFloat bookCoverCellHeight = 185.0;
    CGSize bookCoverCellSize = CGSizeMake(bookCoverCellWidth,
                                          bookCoverCellHeight);
    
    CGFloat bookCoverCellSpace = 10.0;
    CGFloat bookCoverLineSpace = 10.0;
    
    CGFloat bookCoverTopSectionInset = 0.0;
    CGFloat bookCoverLeftSectionInset = 20.0;
    CGFloat bookCoverBottomSectionInset = 0.0;
    CGFloat bookCoverRightSectionInset = 20.0;
    UIEdgeInsets bookCoverSectionInset = UIEdgeInsetsMake(bookCoverTopSectionInset,
                                                          bookCoverLeftSectionInset,
                                                          bookCoverBottomSectionInset,
                                                          bookCoverRightSectionInset);
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [collectionViewFlowLayout setItemSize:bookCoverCellSize];
    [collectionViewFlowLayout setMinimumInteritemSpacing:bookCoverCellSpace];
    [collectionViewFlowLayout setMinimumLineSpacing:bookCoverLineSpace];
    [collectionViewFlowLayout setSectionInset:bookCoverSectionInset];
    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _bookCoverCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                  collectionViewLayout:collectionViewFlowLayout];
    
    [self.bookCoverCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.bookCoverCollectionView setShowsHorizontalScrollIndicator:NO];
    
    [self.bookCoverCollectionView registerClass:[DGBBookCoverCollectionViewCell class]
                     forCellWithReuseIdentifier:[DGBBookCoverCollectionViewCell className]];
    
    [self.bookCoverCollectionView setDelegate:self];
    [self.bookCoverCollectionView setDataSource:self];
    
    [self.contentView addSubview:self.bookCoverCollectionView];
}

- (void)setUpConstraints {
    [self.bookCoverCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[[self.bookCoverCollectionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [self.bookCoverCollectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
                                              [self.bookCoverCollectionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                              [self.bookCoverCollectionView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]]];
}

#pragma mark - Public Methods

- (void)setUpBookCoverCollectionType:(NSString *)bookCoverCollectionType {
    [self updateBookListInAladinWithQueryType:bookCoverCollectionType];
//    switch (bookCoverCollectionType) {
//        case DGBBookCoverCollectionItemNew:
//            [self updateBookListInAladinWithQueryType:@"ItemNewSpecial"];
//            break;
//
//        case DGBBookCoverCollectionBestseller:
//            [self updateBookListInAladinWithQueryType:@"Bestseller"];
//            break;
//
//        case DGBBookCoverCollectionReadingBook:
//            break;
//
//        case DGBBookCoverCollectionReadBook:
//            break;
//
//        case DGBBookCoverCollectionFavoriteBook:
//            break;
//    }
}

#pragma mark - Book List Setting Methods

- (void)updateBookListInAladinWithQueryType:(NSString *)queryType {
    __weak typeof(self) weakSelf = self;
    
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemList
                                          parameters:@{@"QueryType": queryType,
                                                       @"SearchTarget": @"Book",
                                                       @"MaxResults": @"8"}];
    [[DGBDataLoader sharedInstance] fetchDataWithURL:url
                                          completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              weakSelf.bookList = [AladinAPI bookListParsingFromJSONData:data];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [weakSelf.bookCoverCollectionView reloadData];
                                              });
                                          }];
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DGBBook *book = self.bookList[indexPath.row];
    
    DGBBookDetailViewController *bookDetailViewController = [[DGBBookDetailViewController alloc] init];
    [bookDetailViewController setIsbn:book.isbn];
    
    self.presentBookDetailBlock(bookDetailViewController);
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bookList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DGBBookCoverCollectionViewCell *bookCoverCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:[DGBBookCoverCollectionViewCell className]
                                                                                                            forIndexPath:indexPath];
    
    DGBBook *book = self.bookList[indexPath.row];
    
    NSURL *coverURL = [NSURL URLWithString:book.coverURL];
    NSString *title = book.title;
    NSString *isbn = book.isbn;
    
    [bookCoverCollectionViewCell.bookCoverView updateImageWithURL:coverURL
                                                             isbn:isbn];
    [bookCoverCollectionViewCell.titleLabel setText:title];
    
    return bookCoverCollectionViewCell;
}

@end
