#import "MBNavigationSettings.h"

#import <MapboxCoreNavigation/MapboxCoreNavigation-Swift.h>

const NSNotificationName MBNavigationSettingsDidChangeNotification = @"MBNavigationSettingsDidChange";

NSString *const MBXMapboxSKUTokenKey = @"MBXMapboxSKUToken";

@implementation MBXNavigationSettingsBase
+ (void)load {
    [[NSUserDefaults standardUserDefaults] setObject:MBXSKUToken.navigationToken forKey:MBXMapboxSKUTokenKey];
}
@end

