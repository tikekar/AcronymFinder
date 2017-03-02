//
//  ACFResultTableViewCell.h
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFLongForm.h"

@interface ACFResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *longFormLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinceYearLabel;

@property (nonatomic, strong) ACFLongForm *longForm;
-(void) setUI:(ACFLongForm *) aLongForm;

@end
