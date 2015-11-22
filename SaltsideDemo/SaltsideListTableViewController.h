//
//  SaltsideListTableViewController.h
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaltsideListTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>{
}
@property (nonatomic,strong) NSMutableArray *listData;
@end

