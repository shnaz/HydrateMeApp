//
//  StatScreenViewController.m
//  HydrateMe
//
//  Created by Shafi on 05/04/14.
//  Copyright (c) 2014 UNIGULD. All rights reserved.
//

#import "StatScreenViewController.h"
#import "GraphSubViewController.h"

@interface StatScreenViewController () <UITableViewDelegate, UITableViewDataSource>



@end

@implementation StatScreenViewController

//@synthesize amountStatLabel = _amountStatLabel;
//@synthesize fluidTypeStatLabel = _fluidTypeStatLabel;
//@synthesize timestampStatLabel = _timestampStatLabel;
NSArray *amountArray;

GraphSubViewController *graphSubViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initializing and adding Topbar view
    graphSubViewController = [[GraphSubViewController alloc] init];
    [self.graphViewContainer addSubview:graphSubViewController.view];
    
    // Do any additional setup after loading the view.
    
    //Update List
    
//    self.amounttypeArray = [[NSArray alloc]
//                      initWithObjects:@"250",
//                      @"330",
//                      @"500",
//                       nil];
    
   amountArray = [NSArray arrayWithObjects:@"250",
                                      @"330",
                                       @"500",
                                        nil];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1:(id)sender {
    self.label1.text = @"you are stat screen";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [amountArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [amountArray objectAtIndex:indexPath.row];
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
