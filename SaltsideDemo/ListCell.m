//
//  ListCell.m
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.font = [UIFont systemFontOfSize:13 weight:100];
        titleView.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLblView = titleView;
        [self.contentView addSubview:titleView];
        
        UILabel *desciprionLblView = [[UILabel alloc] initWithFrame:CGRectZero];
        desciprionLblView.font = [UIFont systemFontOfSize:13.0f];
        desciprionLblView.lineBreakMode = NSLineBreakByTruncatingTail;
        self.descriptionLblView = desciprionLblView;
        [self.contentView addSubview:desciprionLblView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize viewSize = self.bounds.size;
    CGFloat viewWidth = viewSize.width - 20;
    self.titleLblView.frame = CGRectMake(10, 5, viewWidth, 15);
    self.descriptionLblView.frame = CGRectMake(10, 20, viewWidth, viewSize.height-20);
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.titleLblView = nil;
    self.descriptionLblView = nil;
    self.cellData = nil;
}
@end
