//
//  ConfigurationsTableViewController.m
//  PsyPad
//
//  Created by David Lawson on 16/04/2015.
//  Copyright (c) 2015 David Lawson. All rights reserved.
//

#import "ConfigurationsTableViewController.h"
#import "TestConfiguration.h"
#import "MBProgressHUD.h"
#import "ServerManager.h"
#import "ConfigurationTableViewCell.h"
#import "AvailableConfiguration.h"
#import "UIAlertView+Blocks.h"
#import "DatabaseManager.h"

enum {
    sDownloadedConfigurations = 0,
    sRefreshConfigurations = 1,
    sUpdatesAvailable = 2,
    sAvailableConfigurations = 3
};

@interface ConfigurationsTableViewController ()

@property (nonatomic, strong) NSArray *downloadedConfigurations;
@property (nonatomic, strong) NSArray *updatableConfigurations;
@property (nonatomic, strong) NSArray *availableConfigurations;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ConfigurationsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshLocalConfigurations];
}

- (void)refreshLocalConfigurations
{
    self.downloadedConfigurations = [TestConfiguration MR_findByAttribute:TestConfigurationAttributes.is_gallery_configuration withValue:@YES andOrderBy:TestConfigurationAttributes.name ascending:@YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self reloadConfigurations];
}

- (void)reloadConfigurations
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    self.hud.labelText = @"Loading Configurations...";
    
    __weak typeof (self) weakSelf = self;
    [[ServerManager sharedManager] loadConfigurationsWithSuccess:^(NSArray *updatableConfigurations, NSArray *downloadableConfigurations)
    {
        weakSelf.updatableConfigurations = updatableConfigurations;
        weakSelf.availableConfigurations = downloadableConfigurations;
        [weakSelf.hud hide:YES];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSString *error)
    {
        [weakSelf.hud hide:YES];
        [[[UIAlertView alloc] initWithTitle:@"Failed to Load Configurations"
                                   message:error
                                  delegate:nil
                         cancelButtonTitle:@"Close"
                          otherButtonTitles:nil] show];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sDownloadedConfigurations)
        return self.downloadedConfigurations.count > 0 ? 80 : 44;
    else if (indexPath.section == sRefreshConfigurations)
        return 44;
    else if (indexPath.section == sUpdatesAvailable)
        return self.updatableConfigurations.count > 0 ? 80 : 44;
    else // if (indexPath.section == sAvailableConfigurations)
        return self.availableConfigurations.count > 0 ? 80 : 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == sDownloadedConfigurations)
        return @"Downloaded Configurations";
    else if (section == sRefreshConfigurations)
        return nil;
    else if (section == sUpdatesAvailable)
        return @"Updates Available";
    else // if (section == sAvailableConfigurations)
        return @"Available Configurations";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == sDownloadedConfigurations)
        return MAX(1, self.downloadedConfigurations.count);
    else if (section == sRefreshConfigurations)
        return 1;
    else if (section == sUpdatesAvailable)
        return MAX(1, self.updatableConfigurations.count);
    else // if (section == sAvailableConfigurations)
        return MAX(1, self.availableConfigurations.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfigurationTableViewCell *cell;
    
    if (indexPath.section == sDownloadedConfigurations)
    {
        if (self.downloadedConfigurations.count == 0)
        {
            UITableViewCell *noCell = [tableView dequeueReusableCellWithIdentifier:@"NoCell" forIndexPath:indexPath];
            noCell.textLabel.text = @"No Downloaded Configurations";
            return noCell;
        }
        
        cell = (ConfigurationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DownloadedConfigurationCell" forIndexPath:indexPath];
        cell.playButton.tag = indexPath.row;
        cell.deleteButton.tag = indexPath.row;
        
        TestConfiguration *config = self.downloadedConfigurations[indexPath.row];
        
        NSMutableAttributedString *label = [[NSMutableAttributedString alloc] init];
        
        [label appendAttributedString:[[NSAttributedString alloc] initWithString:config.name
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
        
        if (config.configuration_description && config.configuration_description.length > 0)
            [label appendAttributedString:[[NSAttributedString alloc] initWithString:[@"\n" stringByAppendingString:config.configuration_description]
                                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}]];
        
        cell.textLabel.attributedText = label;
    }
    else if (indexPath.section == sRefreshConfigurations)
    {
        cell = (ConfigurationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RefreshCell" forIndexPath:indexPath];
    }
    else if (indexPath.section == sUpdatesAvailable)
    {
        if (self.updatableConfigurations.count == 0)
        {
            UITableViewCell *noCell = [tableView dequeueReusableCellWithIdentifier:@"NoCell" forIndexPath:indexPath];
            noCell.textLabel.text = @"No Updates Available";
            return noCell;
        }
        
        cell = (ConfigurationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UpdatableConfigurationCell" forIndexPath:indexPath];
        cell.updateButton.tag = indexPath.row;
        
        AvailableConfiguration *config = self.updatableConfigurations[indexPath.row];
        
        NSMutableAttributedString *label = [[NSMutableAttributedString alloc] init];
        
        [label appendAttributedString:[[NSAttributedString alloc] initWithString:config.name
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
        
        if (config.configurationDescription && config.configurationDescription.length > 0)
            [label appendAttributedString:[[NSAttributedString alloc] initWithString:[@"\n" stringByAppendingString:config.configurationDescription]
                                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}]];
        
        cell.textLabel.attributedText = label;
    }
    else // if (indexPath.section == sAvailableConfigurations)
    {
        if (self.availableConfigurations.count == 0)
        {
            UITableViewCell *noCell = [tableView dequeueReusableCellWithIdentifier:@"NoCell" forIndexPath:indexPath];
            noCell.textLabel.text = @"No Available Configurations";
            return noCell;
        }
        
        cell = (ConfigurationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AvailableConfigurationCell" forIndexPath:indexPath];
        cell.downloadButton.tag = indexPath.row;
        
        AvailableConfiguration *config = self.availableConfigurations[indexPath.row];
        
        NSMutableAttributedString *label = [[NSMutableAttributedString alloc] init];
        
        [label appendAttributedString:[[NSAttributedString alloc] initWithString:config.name
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}]];
        
        if (config.configurationDescription && config.configurationDescription.length > 0)
            [label appendAttributedString:[[NSAttributedString alloc] initWithString:[@"\n" stringByAppendingString:config.configurationDescription]
                                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}]];
        
        cell.textLabel.attributedText = label;
    }
    
    return cell;
}

- (IBAction)pressedDownload:(UIButton *)sender
{
    AvailableConfiguration *configuration = self.availableConfigurations[sender.tag];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Downloading configuration...";
    
    __weak typeof(self) weakSelf = self;
    
    [[ServerManager sharedManager] downloadConfiguration:configuration.configID
                                                   atURL:configuration.url
                                                progress:^(NSString *status, float progress)
     {
         weakSelf.hud.labelText = status;
         weakSelf.hud.progress = progress;
         
     } success:^(TestConfiguration *configuration)
     {
         [weakSelf.hud hide:YES];
         [weakSelf.hud removeFromSuperview];
         
         [weakSelf refreshLocalConfigurations];
         [weakSelf.tableView reloadData];
         
         [weakSelf reloadConfigurations];
         
         [[[UIAlertView alloc] initWithTitle:@""
                                     message:@"Configuration downloaded successfully."
                                    delegate:nil
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] show];
         
     } failure:^(NSString *error)
     {
         [weakSelf.hud hide:YES];
         [weakSelf.hud removeFromSuperview];
         
         [[[UIAlertView alloc] initWithTitle:@"Failed to Download Configuration"
                                     message:error
                                    delegate:nil
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] show];
     }];
}

- (IBAction)pressedUpdate:(UIButton *)sender
{
    AvailableConfiguration *configuration = self.updatableConfigurations[sender.tag];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Updating configuration...";
    
    __weak typeof(self) weakSelf = self;
    
    [[ServerManager sharedManager] downloadConfiguration:configuration.configID
                                                   atURL:configuration.url
                                                progress:^(NSString *status, float progress)
     {
         weakSelf.hud.labelText = status;
         weakSelf.hud.progress = progress;
         
     } success:^(TestConfiguration *configuration)
     {
         [weakSelf.hud hide:YES];
         [weakSelf.hud removeFromSuperview];
         
         [weakSelf refreshLocalConfigurations];
         [weakSelf.tableView reloadData];
         
         [weakSelf reloadConfigurations];
         
         [[[UIAlertView alloc] initWithTitle:@""
                                     message:@"Configuration updated successfully."
                                    delegate:nil
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] show];
         
     } failure:^(NSString *error)
     {
         [weakSelf.hud hide:YES];
         [weakSelf.hud removeFromSuperview];
         
         [[[UIAlertView alloc] initWithTitle:@"Failed to Update Configuration"
                                     message:error
                                    delegate:nil
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] show];
     }];
}

- (IBAction)pressedRun:(UIButton *)sender
{
    [self.parentVC performSegueWithIdentifier:@"Test" sender:self.downloadedConfigurations[sender.tag]];
}

- (IBAction)pressedDelete:(UIButton *)sender
{
    TestConfiguration *configuration = self.downloadedConfigurations[sender.tag];
    
    __weak typeof(self) weakSelf = self;
    
    RIButtonItem *delete = [RIButtonItem itemWithLabel:@"Delete"];
    delete.action = ^
    {
        [configuration MR_deleteEntity];
        [DatabaseManager save];
        
        [weakSelf refreshLocalConfigurations];
        [weakSelf.tableView reloadData];
        
        if (weakSelf.updatableConfigurations || weakSelf.availableConfigurations)
            [weakSelf reloadConfigurations];
    };
    
    [[[UIAlertView alloc] initWithTitle:@""
                                message:@"Are you sure you want to delete the local copy of this configuration?"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"Cancel"]
                       otherButtonItems:delete, nil] show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == sRefreshConfigurations)
    {
        [self reloadConfigurations];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
