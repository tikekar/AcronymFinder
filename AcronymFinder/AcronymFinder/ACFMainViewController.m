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
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.shortForm searchLongFormsFor:searchBar.text block:^(NSArray *results, NSError *error) {
        self.results = results;
        [self.resultsTableView reloadData];
    }];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACFResultTableViewCell* cell = (ACFResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if(!cell) {
        cell = [[ACFResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
    }
    [cell setUI:self.results[indexPath.row]];
    return cell;
}

@end
