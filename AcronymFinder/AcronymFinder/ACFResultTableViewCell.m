//
//  ACFResultTableViewCell.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFResultTableViewCell.h"
#import "ACFLongForm.h"

@implementation ACFResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setUI: (ACFLongForm *) aLongForm {
    self.longForm = aLongForm;
    self.longFormLabel.text = aLongForm.lf;
    self.sinceYearLabel.text = [NSString stringWithFormat:@"(since %d)", aLongForm.sinceDate];
}

@end
