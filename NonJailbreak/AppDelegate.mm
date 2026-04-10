#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Create main window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    // Create main view controller
    UIViewController *mainVC = [[UIViewController alloc] init];
    mainVC.view.backgroundColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
    
    // Setup UI
    [self setupUIForViewController:mainVC];
    
    // Create navigation controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    navController.navigationBar.barStyle = UIBarStyleBlack;
    navController.navigationBar.tintColor = [UIColor greenColor];
    
    // Set root view controller
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupUIForViewController:(UIViewController *)vc {
    // Main scrollable container
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, vc.view.frame.size.width, vc.view.frame.size.height - 54)];
    scrollView.backgroundColor = [UIColor clearColor];
    [vc.view addSubview:scrollView];
    
    // Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, vc.view.frame.size.width - 30, 50)];
    titleLabel.text = @"iOS Cheat Engine";
    titleLabel.font = [UIFont boldSystemFontOfSize:28];
    titleLabel.textColor = [UIColor greenColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:titleLabel];
    
    // Subtitle
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, vc.view.frame.size.width - 30, 30)];
    subtitleLabel.text = @"Non-Jailbreak Version";
    subtitleLabel.font = [UIFont systemFontOfSize:14];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:subtitleLabel];
    
    // Features section
    [self addSectionWithTitle:@"Memory Tools" yOffset:120 toScrollView:scrollView];
    
    [self addToggleWithLabel:@"Memory Scan" yOffset:160 toScrollView:scrollView];
    [self addToggleWithLabel:@"Value Modify" yOffset:210 toScrollView:scrollView];
    [self addToggleWithLabel:@"Address Finder" yOffset:260 toScrollView:scrollView];
    
    // Game Features section
    [self addSectionWithTitle:@"Game Features" yOffset:320 toScrollView:scrollView];
    
    [self addToggleWithLabel:@"ESP (Local)" yOffset:360 toScrollView:scrollView];
    [self addToggleWithLabel:@"Speed Hack" yOffset:410 toScrollView:scrollView];
    [self addToggleWithLabel:@"God Mode" yOffset:460 toScrollView:scrollView];
    
    // Info section
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 530, vc.view.frame.size.width - 30, 80)];
    infoLabel.text = @"⚠️ This app works on any iOS device without jailbreak.\n\n✅ Install via SignKill/TrollStore\n❌ Cannot directly hook PUBGM\n⚠️ Limited to app sandbox";
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textColor = [UIColor yellowColor];
    infoLabel.numberOfLines = 0;
    [scrollView addSubview:infoLabel];
    
    scrollView.contentSize = CGSizeMake(vc.view.frame.size.width, 620);
}

- (void)addSectionWithTitle:(NSString *)title yOffset:(CGFloat)yOffset toScrollView:(UIScrollView *)scrollView {
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, yOffset, 200, 30)];
    sectionLabel.text = title;
    sectionLabel.font = [UIFont boldSystemFontOfSize:16];
    sectionLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:sectionLabel];
}

- (void)addToggleWithLabel:(NSString *)label yOffset:(CGFloat)yOffset toScrollView:(UIScrollView *)scrollView {
    // Label
    UILabel *toggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, yOffset, 200, 30)];
    toggleLabel.text = label;
    toggleLabel.textColor = [UIColor whiteColor];
    toggleLabel.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:toggleLabel];
    
    // Toggle Switch
    UISwitch *toggle = [[UISwitch alloc] initWithFrame:CGRectMake(280, yOffset + 2, 50, 30)];
    toggle.onTintColor = [UIColor greenColor];
    toggle.tag = yOffset; // For identification
    [toggle addTarget:self action:@selector(featureToggled:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:toggle];
}

- (void)featureToggled:(UISwitch *)sender {
    if (sender.isOn) {
        NSLog(@"Feature enabled: %@", @(sender.tag));
    } else {
        NSLog(@"Feature disabled: %@", @(sender.tag));
    }
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
