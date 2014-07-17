//
//  XYBookInfoController.m
//  BStoreMobile
//
//  Created by Julie on 14-7-17.
//  Copyright (c) 2014年 SJTU. All rights reserved.
//

#import "XYBookInfoController.h"
#import "XYBookInfoMainCell.h"

@interface XYBookInfoController ()

enum BookInfoStatus {
    details, comments, recommends
};

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property enum BookInfoStatus status;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation XYBookInfoController

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

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
    // Do any additional setup after loading the view.
    [self setExtraCellLineHidden:self.tableView];
    [self prepareForToolBar];
}

- (void)prepareForToolBar
{
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    NSArray *segItemsArray = [NSArray arrayWithObjects: @"详细信息", @"读者评论", @"相关推荐", nil];
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:segItemsArray];
    segControl.frame = CGRectMake(16, 7, 287, 30);
    segControl.selectedSegmentIndex = 0;
    self.status = details;
    [segControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segItem = [[UIBarButtonItem alloc] initWithCustomView:segControl];
    NSArray *barArray = [NSArray arrayWithObjects:segItem, nil];
    [self.toolBar setItems:barArray];
    // backgroudColor不起作用 ???
    self.toolBar.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *mainCellID = @"BookInfoCellIdentifier";
        XYBookInfoMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
        if (cell == nil) {
            // XYSaleItemCell.xib as NibName
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"XYBookInfoMainCell" owner:nil options:nil];
            //第一个对象就是BookInfoCellIdentifier了（xib所列子控件中的最高父控件，BookInfoCellIdentifier）
            cell = [nib objectAtIndex:0];
        }
        cell.title.text = @"BI1-USA";
        cell.detail.text = @"克林顿，布什，奥巴马";
        cell.coverImage.image = [UIImage imageNamed:@"USA.png"];
        [cell.buyButton setTitle:@"￥234.56" forState: UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NSString *detailCellID = @"BookDetailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 119.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44.0f;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        // 每次reload tableview时，均要调用，因此不能在此处alloc/init toolbar，应当将toolbar作为一个成员变量，只初始化一次
        return self.toolBar;
    }
    return nil;
}

- (IBAction)valueChanged:(id)sender
{
    NSInteger index = ((UISegmentedControl *)sender).selectedSegmentIndex;
    switch (index) {
        case 0:
            NSLog(@"Seg Control valued changed to 0");
            self.status = details;
            break;
        case 1:
            NSLog(@"Seg Control valued changed to 1");
            self.status = comments;
            break;
        case 2:
            NSLog(@"Seg Control valued changed to 2");
            self.status = recommends;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

@end
