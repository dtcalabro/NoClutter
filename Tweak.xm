#import "Tweak.h"
#import <rootless.h>
#import <HBLog.h>

NSString *carrierName;

// NoPadlock -- Works
%hook BSUICAPackageView
- (void)didMoveToWindow {
	if (padlock)
		self.hidden = YES;
	%orig;
}
%end

// NoCCBar -- Works
// NoSwipeText -- Works
%hook CSTeachableMomentsContainerView
- (void)didMoveToWindow {
	if (ccbar && self.controlCenterGrabberContainerView)
		self.controlCenterGrabberContainerView.hidden = YES;
	%orig;
}
- (void)_layoutCallToActionLabel {
	SBUILegibilityLabel* label = MSHookIvar<SBUILegibilityLabel *>(self, "_callToActionLabel");
	if (swipetext)
		label.hidden = YES;
	%orig;
}
%end

// NoScrollBar -- Works
%hook _UIScrollViewScrollIndicator
- (void)layoutSubviews {
	if (scrollbar)
		self.hidden = YES;
	%orig;
}
%end

// HideDock -- Works
// HideDockBackground -- Works
// DisableDock -- Doesn't work
%hook SBDockView
- (void)layoutSubviews {
	if (dock || dock_disable) {
		self.hidden = YES;
	}

	if (dockbackground) {
		UIView *bgView = MSHookIvar<UIView *>(self, "_backgroundView");
		bgView.alpha = 0;
		bgView.hidden = YES;
	}
	%orig;
}

- (double)dockHeight {
	return %orig;
	if (dock_disable)
		return 0.0;
}
%end

%hook SBFloatingDockPlatterView
- (void)layoutSubviews {
	if (dock || dock_disable)
		self.hidden = YES;
	%orig;
}

- (double)dockHeight {
	return %orig;
	if (dock_disable)
		return 0.0;
}
%end

// NoSBTime -- Works
// NoSBCellular -- Works
// NoSBCellularText
%hook _UIStatusBarStringView
- (void)didMoveToWindow {
	if ([self.text containsString:@"LTE"] || [self.text containsString:@"5G"] || [self.text containsString:@"5Ge"] || [self.text containsString:@"4G"] || [self.text containsString:@"3G"] || [self.text containsString:@"SOS"]) {
		if (sbcellular)
			self.hidden = YES;
		hidesbtime = YES;
	}

	if ([self.text isEqualToString:carrierName]) {
		if (sbcellulartext)
			self.hidden = YES;
		hidesbtime = YES;
	}

	if (!hidesbtime && sbtime)
		self.hidden = YES;
	%orig;
}
%end

// NoSBSignal -- Works
%hook _UIStatusBarCellularSignalView
- (void)didMoveToWindow {
	%orig;
	if (sbsignal) {
		self.alpha = 0.0f;
		self.hidden = YES;
	}
}
%end

// NoSBWifi -- Works
%hook _UIStatusBarWifiSignalView
- (void)didMoveToWindow {
	%orig;
	if (sbwifi) {
		self.alpha = 0.0f;
		self.hidden = YES;
	}
}
%end

// NoSBBattery -- Works
%hook _UIBatteryView
- (void)didMoveToWindow {
	%orig;
	if (sbbattery) {
		self.alpha = 0.0f;
		self.hidden = YES;
	}
}
%end

%hook SparkBatteryView
- (void)didMoveToWindow {
	%orig;
	if (sbbattery)
		self.hidden = YES;
}
%end

// NoQuickActionToggles -- Works
// NoQuickActionTorch -- Works
// NoQuickActionCamera -- Works
%hook CSQuickActionsView
- (void)didMoveToWindow {
	%orig;
	if (quickactiontoggles) {
		self.hidden = YES;
	} else {
		if (cameraquickactiontoggles)
			self.subviews[0].hidden = YES;
		if (torchquickactiontoggles)
			self.subviews[1].hidden = YES;
	}
}
%end

// NoNotificationCenterText -- Works
%hook NCNotificationListHeaderTitleView
- (void)didMoveToWindow {
	%orig;
	if (notificationcentertext)
		self.hidden = YES;
}
%end

// NoHomeBar -- Works
%hook MTLumaDodgePillSettings
- (void)setHeight:(double)arg1 {
	if (homebar){
		%orig(0);
		return;
	}
	%orig;
}
- (void)setMinWidth:(double)arg1 {
	if (homebar) {
		%orig(0);
		return;
	}
	%orig;
}
%end

// NoSafarisSarchBG -- Doesn't work
%hook _SFNavigationBarURLButton
- (void)didMoveToWindow {
	%orig;
	if (safarisearchbg)
		self.subviews[0].hidden = YES;
}
%end

// NoSafariCloseTabButton -- Doesn't work
%hook _SFDimmingButton
- (void)didMoveToWindow {
	%orig;
	if (safariclosetabbutton)
		self.hidden = YES;
}
%end

// NoSettingsArrow -- Works
%hook _UITableCellAccessoryButton
- (void)layoutSubviews {
	%orig;
	if (settingsarrow)
		self.subviews[0].hidden = YES;
}
%end

// NoBreadcrumbs -- Works
%hook SBDeviceApplicationSceneStatusBarBreadcrumbProvider
+ (_Bool)_shouldAddBreadcrumbToActivatingSceneEntity:(id)arg1 sceneHandle:(id)arg2 withTransitionContext:(id)arg3 {
	return !breadcrumb;
}
%end

// NoAppSwitcherHeader -- Works
%hook SBFluidSwitcherItemContainerHeaderView
- (void)didMoveToWindow {
	%orig;
	if (appswitcherheader)
		self.hidden = YES;
}
%end

// NoAppSwitcherIcons -- Works (now)
%hook SBFluidSwitcherIconImageContainerView
- (BOOL)isHidden {
    if (appswitchericons)
        return YES;
    return %orig;
}
- (void)setHidden:(BOOL)arg1 {
    if (appswitchericons)
        arg1 = YES;
    %orig(arg1);
}
%end

// NoCCStatusBar -- Works
%hook CCUIStatusBar
- (void)didMoveToWindow {
	%orig;
	if (ccstatusbar)
		self.hidden = YES;
}
%end

// NoStatusBar -- Works
%hook _UIStatusBar
- (void)didMoveToWindow {
	%orig;
	if (statusbar)
		self.hidden = YES;
}
%end

// NoFolderTitle -- Works
%hook SBFolderTitleTextField
- (void)didMoveToWindow {
	%orig;
	if (foldertitle)
		self.hidden = YES;
}
%end

// NoFolderBackground -- Works
%hook SBFolderBackgroundView
- (void)didMoveToWindow {
	%orig;
	if (folderbackground)
		self.hidden = YES;
}
%end

// NoFolderBlur -- Works
%hook SBFolderControllerBackgroundView
- (void)didMoveToWindow {
	%orig;
	if (folderblur)
		self.hidden = YES;
}
%end

// NoIconBadge -- Works
%hook SBIconBadgeView
- (void)didMoveToWindow {
	%orig;
	if (iconbadge)
		self.hidden = YES;
}
%end

// NoEditingDoneButton -- Works
%hook SBHEditingDoneButton
- (void)didMoveToWindow {
	%orig;
	if (editingdonebutton)
		self.hidden = YES;
}
%end

// NoFavicon
%hook TabIconAndTitleView
- (void)didMoveToWindow {
	%orig;
	if ([self.subviews count] > 0)
		self.subviews[0].hidden = safarifavicon;
}
%end

// NoXDeleteButton
%hook SBXCloseBoxView
- (void)didMoveToWindow {
	%orig;
	if (xdeletebutton)
		self.hidden = YES;
}
%end

// NoSeparator -- Works
%hook _UIInterfaceActionVibrantSeparatorView
- (void)layoutSubviews {
	%orig;
	if (separator)
		self.hidden = YES;
}
%end
%hook _UITableViewCellSeparatorView
- (void)layoutSubviews {
	%orig;
	if (separator)
		self.hidden = YES;
}
%end
%hook _UIInterfaceActionBlankSeparatorView
- (void)layoutSubviews {
	%orig;
	if (separator)
		self.hidden = YES;
}
%end

// NoWidgetFooter
%hook WGWidgetListFooterView
- (void)didMoveToWindow {
	%orig;
	if (widgetfooter)
		self.hidden = YES;
}
%end

// NoStatusBarPill
%hook _UIStatusBarPillView
- (void)didMoveToWindow {
	%orig;
	if (sbpill)
		self.hidden = YES;
}
%end

// NoNoOlderNotification
%hook NCNotificationListSectionRevealHintView
- (void)didMoveToWindow {
	%orig;
	SBUILegibilityLabel* label = MSHookIvar<SBUILegibilityLabel *>(self, "_revealHintTitle");
	if (nooldernotifications)
		label.hidden = YES;
}
%end

// NoFaceIDGlyph
%hook SBUIProudLockIconView
- (void)layoutSubviews {
	%orig;
	if (nofaceidglyph)
		self.hidden = YES;
}
%end

// NoDNDBanner -- Doesn't work
// TODO: Fix this
%hook DNDNotificationsService
- (void)_queue_postOrRemoveNotificationWithUpdatedBehavior:(BOOL)arg1 significantTimeChange:(BOOL)arg2 {
	if (dnd) return;
	%orig;
}
%end

// NoDNDLSIndicator -- Works
%hook NCNotificationListCountIndicatorView
%property (nonatomic, assign) BOOL hiddenByNoClutter;

- (void)adjustForLegibilitySettingsChange:(id)arg0 {
    %orig;
    if (dndLSIndicator && [self.titleString isEqualToString:@"Do Not Disturb"]) {
        self.hidden = YES;
        self.hiddenByNoClutter = YES;
    } else if (!dndLSIndicator && self.hiddenByNoClutter) {
        self.hidden = NO;
        self.hiddenByNoClutter = NO;
    }
}
%end

// NoTabLabel -- Works
%hook UITabBarButtonLabel
- (void)layoutSubviews {
	%orig;
	if (tablabel)
		self.hidden = YES;
}
%end

// NoBetaDots -- Works
%hook SBIconBetaLabelAccessoryView
- (struct CGSize )intrinsicContentSize {
    if (betadots)
        self.hidden = YES;

    return %orig;
}
%end

// NoUpdateDots -- Works
%hook SBApplication
- (bool)_isRecentlyUpdated {
	if (updatedots) {
		return NO;
	}
	return %orig;
}
- (void)_setRecentlyUpdated:(bool)arg1 {
	if (updatedots) {
		%orig(NO);
	} else {
		%orig;
	}
}
%end

// NoPageDots -- Kinda works
// TODO: Fix this
// Hook SBHSearchPillView (should be search pill)
%hook SBIconListPageControl
- (id)initWithFrame:(CGRect)arg1 {
	if (pagedots)
		return nil;
	return %orig;
}
%end

// NoHSBackdrop -- Works
%hook SBHomeScreenBackdropView
- (void)didMoveToWindow {
	%orig;
	if (hsbackdrop)
		self.hidden = YES;
}
%end

// NoAppLabels (inspired from anynon/HideLabels13) -- Works
%hook SBIconView
- (void)setLabelHidden:(BOOL)arg1 {
	%orig;
	if (applabels)
		%orig(YES);
}
%end

// NoSBImageViews -- Works
%hook _UIStatusBarImageView
- (void)didMoveToWindow {
	%orig;
	if (sbicons)
		self.hidden = YES;
}
%end

// NoOffloadedIcon -- Works (now)
%hook SBIconCloudLabelAccessoryView
- (CGRect)frame {
    CGRect ret = %orig;
    if (offloadedicon)
        self.hidden = YES;
    return ret;
}
%end

// HideTodayView -- Doesn't work
// TODO: Fix this
%hook WGWidgetWrapperView
- (void)layoutSubviews {
	%orig;
	if (todayview)
		self.hidden = true;
}
%end
%hook SBSearchBar
- (void)layoutSubviews {
	%orig;
	if (todayview)
		self.hidden = true;
}
%end
%hook WGWidgetListFooterView
- (void)layoutSubviews {
	%orig;
	if (todayview)
		self.hidden = true;
}
%end

// NoTwitterAds -- Doesn't work
// TODO: Fix this
/*
 * Hook T1StandardStatusView
 * Get subviews --> T1InfoTextView.titleLabel == "Promoted"
 * Remove cell and profit?
 */
%hook TFNItemsDataViewController
- (id)tableViewCellForItem:(id)arg1 atIndexPath:(id)arg2 {
	UITableViewCell *tbvCell = %orig;
	id item = [self itemAtIndexPath: arg2];
	return tbvCell;
	if ([item respondsToSelector: @selector(isPromoted)] && [item performSelector:@selector(isPromoted)] && twitterads)
		[tbvCell setHidden: YES];
}

- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2 {
	id item = [self itemAtIndexPath: arg2];
	return %orig;
	if ([item respondsToSelector: @selector(isPromoted)] && [item performSelector:@selector(isPromoted)] && twitterads)
		return 0;
}
%end

// NoRedditAds -- Doesn't work
// TODO: Fix this
%hook Post
- (bool)isHidden {
	return %orig;
	if ([NSStringFromClass([self classForCoder]) isEqual:@"AdPost"] && redditads) {
		return YES;
	}
}
%end

static void loadPrefs() {
    NSLog(@"[NoClutter] Loading preferences");
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.dcproducts.noclutterprefs.plist")];

	if (prefs) {
		enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled);
		padlock = ([prefs objectForKey:@"padlock"] ? [[prefs objectForKey:@"padlock"] boolValue] : padlock);
		ccbar = ([prefs objectForKey:@"ccbar"] ? [[prefs objectForKey:@"ccbar"] boolValue] : ccbar);
		pagedots = ([prefs objectForKey:@"pagedots"] ? [[prefs objectForKey:@"pagedots"] boolValue] : pagedots);
		scrollbar = ([prefs objectForKey:@"scrollbar"] ? [[prefs objectForKey:@"scrollbar"] boolValue] : scrollbar);
		dock = ([prefs objectForKey:@"dock"] ? [[prefs objectForKey:@"dock"] boolValue] : dock);
		dockbackground = ([prefs objectForKey:@"dockbackground"] ? [[prefs objectForKey:@"dockbackground"] boolValue] : dockbackground);
		sbbattery = ([prefs objectForKey:@"sbbattery"] ? [[prefs objectForKey:@"sbbattery"] boolValue] : sbbattery);
		sbwifi = ([prefs objectForKey:@"sbwifi"] ? [[prefs objectForKey:@"sbwifi"] boolValue] : sbwifi);
		sbsignal = ([prefs objectForKey:@"sbsignal"] ? [[prefs objectForKey:@"sbsignal"] boolValue] : sbsignal);
		sbtime = ([prefs objectForKey:@"sbtime"] ? [[prefs objectForKey:@"sbtime"] boolValue] : sbtime);
		homebar = ([prefs objectForKey:@"homebar"] ? [[prefs objectForKey:@"homebar"] boolValue] : homebar);
		safarisearchbg = ([prefs objectForKey:@"safarisearchbg"] ? [[prefs objectForKey:@"safarisearchbg"] boolValue] : safarisearchbg);
		safariclosetabbutton = ([prefs objectForKey:@"safariclosetabbutton"] ? [[prefs objectForKey:@"safariclosetabbutton"] boolValue] : safariclosetabbutton);
		settingsarrow = ([prefs objectForKey:@"settingsarrow"] ? [[prefs objectForKey:@"settingsarrow"] boolValue] : settingsarrow);
		quickactiontoggles = ([prefs objectForKey:@"quickactiontoggles"] ? [[prefs objectForKey:@"quickactiontoggles"] boolValue] : quickactiontoggles);
		notificationcentertext = ([prefs objectForKey:@"notificationcentertext"] ? [[prefs objectForKey:@"notificationcentertext"] boolValue] : notificationcentertext);
		breadcrumb = ([prefs objectForKey:@"breadcrumb"] ? [[prefs objectForKey:@"breadcrumb"] boolValue] : breadcrumb);
		appswitchericons = ([prefs objectForKey:@"appswitchericons"] ? [[prefs objectForKey:@"appswitchericons"] boolValue] : appswitchericons);
		appswitcherlabels = ([prefs objectForKey:@"appswitcherlabels"] ? [[prefs objectForKey:@"appswitcherlabels"] boolValue] : appswitcherlabels);
		ccstatusbar = ([prefs objectForKey:@"ccstatusbar"] ? [[prefs objectForKey:@"ccstatusbar"] boolValue] : ccstatusbar);
		foldertitle = ([prefs objectForKey:@"foldertitle"] ? [[prefs objectForKey:@"foldertitle"] boolValue] : foldertitle);
		folderbackground = ([prefs objectForKey:@"folderbackground"] ? [[prefs objectForKey:@"folderbackground"] boolValue] : folderbackground);
		folderblur = ([prefs objectForKey:@"folderblur"] ? [[prefs objectForKey:@"folderblur"] boolValue] : folderblur);
		iconbadge = ([prefs objectForKey:@"iconbadge"] ? [[prefs objectForKey:@"iconbadge"] boolValue] : iconbadge);
		editingdonebutton = ([prefs objectForKey:@"editingdonebutton"] ? [[prefs objectForKey:@"editingdonebutton"] boolValue] : editingdonebutton);
		safarifavicon = ([prefs objectForKey:@"safarifavicon"] ? [[prefs objectForKey:@"safarifavicon"] boolValue] : safarifavicon);
		xdeletebutton = ([prefs objectForKey:@"xdeletebutton"] ? [[prefs objectForKey:@"xdeletebutton"] boolValue] : xdeletebutton);
		separator = ([prefs objectForKey:@"separator"] ? [[prefs objectForKey:@"separator"] boolValue] : separator);
		appswitcherheader = ([prefs objectForKey:@"appswitcherheader"] ? [[prefs objectForKey:@"appswitcherheader"] boolValue] : appswitcherheader);
		statusbar = ([prefs objectForKey:@"statusbar"] ? [[prefs objectForKey:@"statusbar"] boolValue] : statusbar);
		sbcellular = ([prefs objectForKey:@"sbcellular"] ? [[prefs objectForKey:@"sbcellular"] boolValue] : sbcellular);
		widgetfooter = ([prefs objectForKey:@"widgetfooter"] ? [[prefs objectForKey:@"widgetfooter"] boolValue] : widgetfooter);
		sbpill = ([prefs objectForKey:@"sbpill"] ? [[prefs objectForKey:@"sbpill"] boolValue] : sbpill);
		nooldernotifications = ([prefs objectForKey:@"nooldernotifications"] ? [[prefs objectForKey:@"nooldernotifications"] boolValue] : nooldernotifications);
		nofaceidglyph = ([prefs objectForKey:@"nofaceidglyph"] ? [[prefs objectForKey:@"nofaceidglyph"] boolValue] : nofaceidglyph);
		dnd = ([prefs objectForKey:@"dnd"] ? [[prefs objectForKey:@"dnd"] boolValue] : dnd);
		dndLSIndicator = ([prefs objectForKey:@"dndLSIndicator"] ? [[prefs objectForKey:@"dndLSIndicator"] boolValue] : dndLSIndicator);
		tablabel = ([prefs objectForKey:@"tablabel"] ? [[prefs objectForKey:@"tablabel"] boolValue] : tablabel);
		betadots = ([prefs objectForKey:@"betadots" ] ? [[prefs objectForKey:@"betadots"] boolValue] : betadots);
		updatedots = ([prefs objectForKey:@"updatedots" ] ? [[prefs objectForKey:@"updatedots"] boolValue] : updatedots);
		sbcellulartext = ([prefs objectForKey:@"sbcellulartext" ] ? [[prefs objectForKey:@"sbcellulartext"] boolValue] : sbcellulartext);
		swipetext = ([prefs objectForKey:@"swipetext" ] ? [[prefs objectForKey:@"swipetext"] boolValue] : swipetext);
		hsbackdrop = ([prefs objectForKey:@"hsbackdrop" ] ? [[prefs objectForKey:@"hsbackdrop"] boolValue] : hsbackdrop);
		applabels = ([prefs objectForKey:@"applabels" ] ? [[prefs objectForKey:@"applabels"] boolValue] : applabels);
		sbicons = ([prefs objectForKey:@"sbicons" ] ? [[prefs objectForKey:@"sbicons"] boolValue] : sbicons);
		offloadedicon = ([prefs objectForKey:@"offloadedicon" ] ? [[prefs objectForKey:@"offloadedicon"] boolValue] : offloadedicon);
		todayview = ([prefs objectForKey:@"todayview" ] ? [[prefs objectForKey:@"todayview"] boolValue] : todayview);
		twitterads = ([prefs objectForKey:@"twitterads" ] ? [[prefs objectForKey:@"twitterads"] boolValue] : twitterads);
		redditads = ([prefs objectForKey:@"redditads" ] ? [[prefs objectForKey:@"redditads"] boolValue] : redditads);
		shuttersound = ([prefs objectForKey:@"shuttersound" ] ? [[prefs objectForKey:@"shuttersound"] boolValue] : shuttersound);
		cameraquickactiontoggles = ([prefs objectForKey:@"cameraquickactiontoggles" ] ? [[prefs objectForKey:@"cameraquickactiontoggles"] boolValue] : cameraquickactiontoggles);
		torchquickactiontoggles = ([prefs objectForKey:@"torchquickactiontoggles" ] ? [[prefs objectForKey:@"torchquickactiontoggles"] boolValue] : torchquickactiontoggles);
		videoshuttersound = ([prefs objectForKey:@"videoshuttersound" ] ? [[prefs objectForKey:@"videoshuttersound"] boolValue] : videoshuttersound);
	}
}

%ctor {
    NSLog(@"[NoClutter] We in this SOB");
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.dcproducts.noclutterprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadPrefs();
	if ([[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"/Application"] || [[[[NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"SpringBoard.app"]) {
		//CTCarrier *carrier = [[[CTTelephonyNetworkInfo alloc] init] subscriberCellularProvider];
		//carrierName = [carrier carrierName];

        /*
        AMSTelephonyDataCache *telephonyDataCache = [AMSTelephonyDataCache sharedCache];
        NSArray *carrierNames = [telephonyDataCache carrierNames];
        if (carrierNames.count > 0) {
            carrierName = carrierNames[0];
        }

        NSLog(@"[NoClutter] Carrier Name: %@", carrierName);
        */

        //return;

		if (enabled) {
			%init;

            /*
			// NoShutterSound
			if (shuttersound) {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/photoShutter.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/photoShutter.caf" toPath:@"/System/Library/Audio/UISounds/photoShutter.caf.bkp" error:nil];
				}
			} else {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/photoShutter.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/photoShutter.caf.bkp" toPath:@"/System/Library/Audio/UISounds/photoShutter.caf" error:nil];
				}
			}

			// NoVideoShutterSound
			if (shuttersound) {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/begin_record.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/begin_record.caf" toPath:@"/System/Library/Audio/UISounds/begin_record.caf.bkp" error:nil];
				}
			} else {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/begin_record.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/begin_record.caf.bkp" toPath:@"/System/Library/Audio/UISounds/begin_record.caf" error:nil];
				}
			}

			// NoChargeSound
			if (chargesound) {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/connect_power.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/connect_power.caf" toPath:@"/System/Library/Audio/UISounds/connect_power.caf.bkp" error:nil];
				}
			} else {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/connect_power.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/connect_power.caf.bkp" toPath:@"/System/Library/Audio/UISounds/connect_power.caf" error:nil];
				}
			}

			// NoVideoEndShutterSound
			if (endvideoshuttersound) {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/end_record.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/end_record.caf" toPath:@"/System/Library/Audio/UISounds/end_record.caf.bkp" error:nil];
				}
			} else {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/end_record.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/end_record.caf.bkp" toPath:@"/System/Library/Audio/UISounds/end_record.caf" error:nil];
				}
			}

			// NoKeyPressSound
			if (endvideoshuttersound) {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/key_press_click.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/key_press_click.caf" toPath:@"/System/Library/Audio/UISounds/key_press_click.caf.bkp" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/key_press_delete.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/key_press_delete.caf" toPath:@"/System/Library/Audio/UISounds/key_press_delete.caf.bkp" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/key_press_modifier.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/key_press_modifier.caf" toPath:@"/System/Library/Audio/UISounds/key_press_modifier.caf.bkp" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/keyboard_press_clear.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/keyboard_press_clear.caf" toPath:@"/System/Library/Audio/UISounds/keyboard_press_clear.caf.bkp" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/keyboard_press_delete.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/keyboard_press_delete.caf" toPath:@"/System/Library/Audio/UISounds/keyboard_press_delete.caf.bkp" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/keyboard_press_normal.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/keyboard_press_normal.caf" toPath:@"/System/Library/Audio/UISounds/keyboard_press_normal.caf.bkp" error:nil];
				}
			} else {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/key_press_click.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/key_press_click.caf.bkp" toPath:@"/System/Library/Audio/UISounds/key_press_click.caf" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/key_press_delete.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/key_press_delete.caf.bkp" toPath:@"/System/Library/Audio/UISounds/key_press_delete.caf" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/key_press_modifier.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/key_press_modifier.caf.bkp" toPath:@"/System/Library/Audio/UISounds/key_press_modifier.caf" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/keyboard_press_clear.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/keyboard_press_clear.caf.bkp" toPath:@"/System/Library/Audio/UISounds/keyboard_press_clear.caf" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/keyboard_press_delete.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/keyboard_press_delete.caf.bkp" toPath:@"/System/Library/Audio/UISounds/keyboard_press_delete.caf" error:nil];
				}
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/keyboard_press_normal.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/keyboard_press_normal.caf.bkp" toPath:@"/System/Library/Audio/UISounds/keyboard_press_normal.caf" error:nil];
				}
			}

			// NoLockSound
			if (endlocksound) {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/lock.caf"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/lock.caf" toPath:@"/System/Library/Audio/UISounds/lock.caf.bkp" error:nil];
				}
			} else {
				if([[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/Audio/UISounds/lock.caf.bkp"]){
                    [[NSFileManager defaultManager] moveItemAtPath:@"/System/Library/Audio/UISounds/lock.caf.bkp" toPath:@"/System/Library/Audio/UISounds/lock.caf" error:nil];
				}
			}
            */
		}
	}
}
