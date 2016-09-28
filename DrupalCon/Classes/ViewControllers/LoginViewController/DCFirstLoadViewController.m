
#import "DCFirstLoadViewController.h"
#import "DCMainProxy.h"
#import "UIImage+Extension.h"
#import "DCAppFacade.h"

@interface DCFirstLoadViewController ()

@property(weak, nonatomic) IBOutlet UIImageView* backgroundImageView;

@end

@implementation DCFirstLoadViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
  //hack sleep for 2 seconds before launching app
  [NSThread sleepForTimeInterval:2.0f];
    
  [UIApplication sharedApplication].keyWindow.backgroundColor =
      [UIColor whiteColor];

  self.backgroundImageView.image =
      [UIImage splashImageForOrientation:UIInterfaceOrientationPortrait];

  [[DCMainProxy sharedProxy]
      setDataReadyCallback:^(DCMainProxyState mainProxyState) {

        if (mainProxyState == DCMainProxyStateDataUpdated ||
            mainProxyState == DCMainProxyStateDataReady ||
            mainProxyState == DCmainProxyStateDataNotChange)
          dispatch_async(dispatch_get_main_queue(), ^{
            [[DCAppFacade shared]
                    .mainNavigationController goToSideMenuContainer:NO];
          });
      }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
