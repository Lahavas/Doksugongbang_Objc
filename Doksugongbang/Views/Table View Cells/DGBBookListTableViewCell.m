//
//  DGBBookListTableViewCell.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookListTableViewCell.h"
#import "DGBBookMainView.h"

@implementation DGBBookListTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUpBookMainView];
        
        [self setUpConstraints];
    }
    
    return self;
}

#pragma mark - Cell Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.bookMainView resetBookCoverView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.bookMainView resetBookCoverView];
}

#pragma mark - Set Up Methods

- (void)setUpBookMainView {
    _bookMainView = [[DGBBookMainView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.bookMainView];
}

- (void)setUpConstraints {
    [self.bookMainView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[[self.bookMainView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [self.bookMainView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
                                              [self.bookMainView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                              [self.bookMainView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]]];
}

@end
