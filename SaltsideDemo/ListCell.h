//
//  ListCell.h
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLblView;
@property (nonatomic,strong) UILabel *descriptionLblView;
@property (nonatomic, strong) NSDictionary *cellData;
@end
