//
//  CLAnimationViewController.m
//  Colors
//
//  Created by Evan Coleman on 7/20/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "CLAnimationViewController.h"

#import "CLAnimationsViewModel.h"

#import "CLAPIClient.h"

@interface CLAnimationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) CLAnimationsViewModel *viewModel;

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UISlider *speedSlider;
@property (nonatomic) UISlider *brightnessSlider;

@property (nonatomic) NSInteger currentAnimation;

@end

@implementation CLAnimationViewController

- (instancetype)initWithViewModel:(CLAnimationsViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _viewModel = viewModel;
        self.tabBarItem.image = [UIImage imageNamed:@"aperture"];
        self.title = @"Animations";
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _speedSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _brightnessSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _currentAnimation = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor darkGrayColor];
	
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.speedSlider.minimumValueImage = [UIImage imageNamed:@"turtle"];
    self.speedSlider.maximumValueImage = [UIImage imageNamed:@"rabbit"];
    self.speedSlider.minimumValue = 1.0f;
    self.speedSlider.maximumValue = 200.0f;
    self.speedSlider.value = 170.0;
    self.speedSlider.continuous = NO;
    [self.view addSubview:self.speedSlider];
    
    self.brightnessSlider.minimumValueImage = [UIImage imageNamed:@"dark"];
    self.brightnessSlider.maximumValueImage = [UIImage imageNamed:@"bright"];
    self.brightnessSlider.minimumValue = 100.0f;
    self.brightnessSlider.maximumValue = 255.0f;
    self.brightnessSlider.value = 255.0;
    self.brightnessSlider.continuous = NO;
    [self.view addSubview:self.brightnessSlider];
    
    [[RACObserve(self, viewModel.animations)
     mapReplace:self.tableView]
     subscribeNext:^(UITableView *tableView) {
         [tableView reloadData];
     }];
    
    @weakify(self);
    [[[self.speedSlider rac_signalForControlEvents:UIControlEventValueChanged]
        mapReplace:@(self.speedSlider.value)]
        subscribeNext:^(NSNumber *value) {
            @strongify(self);
            RACTuple *tupleToSend = [RACTuple tupleWithObjects:@(self.currentAnimation), @(self.speedSlider.maximumValue - self.speedSlider.value), @(self.brightnessSlider.value), nil];
            [self.viewModel.sendAnimationCommand execute:tupleToSend];
        }];
    
    [[[self.brightnessSlider rac_signalForControlEvents:UIControlEventValueChanged]
        mapReplace:@(self.brightnessSlider.value)]
        subscribeNext:^(NSNumber *value) {
            @strongify(self);
            RACTuple *tupleToSend = [RACTuple tupleWithObjects:@(self.currentAnimation), @(self.speedSlider.maximumValue - self.speedSlider.value), @(self.brightnessSlider.value), nil];
            [self.viewModel.sendAnimationCommand execute:tupleToSend];
        }];
    
    [[[[[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)]
        doNext:^(RACTuple *tuple) {
            RACTupleUnpack(UITableView *tableView, NSIndexPath *indexPath) = tuple;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }]
        reduceEach:^NSIndexPath *(id _, NSIndexPath *indexPath) {
            return indexPath;
        }]
        map:^NSNumber *(NSIndexPath *indexPath) {
            return @(indexPath.row + 1);
        }]
        subscribeNext:^(NSNumber *animation) {
            @strongify(self);
            self.currentAnimation = [animation integerValue];
            RACTuple *tupleToSend = [RACTuple tupleWithObjects:animation, @(self.speedSlider.maximumValue - self.speedSlider.value), @(self.brightnessSlider.value), nil];
            [self.viewModel.sendAnimationCommand execute:tupleToSend];
        }];
    
    [self.tableView autoPinToTopLayoutGuideOfViewController:self withInset:0];
    [self.tableView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
    [self.tableView autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(self.view.frame) / 2];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    [self.speedSlider autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView withOffset:35];
    [self.speedSlider autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15];
    [self.speedSlider autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15];
    
    [self.brightnessSlider autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.speedSlider withOffset:45];
    [self.brightnessSlider autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:20];
    [self.brightnessSlider autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-20];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.animations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *animation = self.viewModel.animations[indexPath.row];
    cell.textLabel.text = animation;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
