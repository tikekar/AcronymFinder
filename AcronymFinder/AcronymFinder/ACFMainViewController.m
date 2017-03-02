//
//  ViewController.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFMainViewController.h"
#import "ACFShortForm.h"
#import "ACFLongForm.h"
#import "ACFResultTableViewCell.h"
#import "MBProgressHUD.h"

@interface ACFMainViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) ACFShortForm *shortForm;

@end

@implementation ACFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shortForm = [[ACFShortForm alloc] init];
    self.resultsTableView.estimatedRowHeight = 83;
    self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    __block MBProgressHUD *hud_ = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud_.mode = MBProgressHUDModeIndeterminate;
    hud_.labelText = @"Finding Acronyms";
    [self.shortForm searchLongFormsFor:searchBar.text block:^(NSArray *results, NSError *error) {
        [hud_ hide:YES];
        hud_ = nil;
        self.results = results;
        [self.resultsTableView reloadData];
    }];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.results.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACFResultTableViewCell* cell = (ACFResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if(!cell) {
        cell = [[ACFResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
    }
    [cell setUI:self.results[indexPath.section]];
    return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ACFLongForm *longForm_ = self.results[indexPath.section];
    
    CGSize textSize = [[NSString stringWithFormat:@"%@",longForm_.lf] sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0] }];
    return textSize.height + 120;
    
    
}*/


@end
