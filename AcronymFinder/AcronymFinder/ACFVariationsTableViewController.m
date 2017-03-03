//
//  ACFVariationsTableViewController.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/3/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFVariationsTableViewController.h"
#import "ACFResultTableViewCell.h"

@interface ACFVariationsTableViewController ()

@property (nonatomic, strong) NSArray *variations;

@end

@implementation ACFVariationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 125;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.navigationItem.title = @"Variations";
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.variations = self.longForm.vars;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.variations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACFResultTableViewCell* cell = (ACFResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if(!cell) {
        cell = [[ACFResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
    }
    [cell setUI:self.variations[indexPath.row]];
    return cell;
}


@end
