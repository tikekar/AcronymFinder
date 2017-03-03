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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setUI: (ACFLongForm *) aLongForm {
    self.longForm = aLongForm;
   
    self.longFormLabel.text = aLongForm.lf;
    NSString *labelText_ = @"";
    if(aLongForm.freq > 0) {
        labelText_ = [labelText_ stringByAppendingString:[NSString stringWithFormat:@"Frequency %d", aLongForm.freq]];
    }
    if(aLongForm.sinceDate > 0) {
        labelText_ = [labelText_ stringByAppendingString:[NSString stringWithFormat:@", since %d", aLongForm.sinceDate]];
    }

    self.sinceYearLabel.text = labelText_;
}


@end
