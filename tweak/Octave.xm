#import "Octave.h"

static MRUNowPlayingTimeControlsView *newPlayerTimeControl;
static MRUNowPlayingTransportControlsView *newMediaControls;
static MRUNowPlayingVolumeSlider *newVolumeSlider;
static CSCoverSheetView *coverSheetView;
static CSMainPageView *mainPageView;

%hook CSCoverSheetView
- (void)setFrame:(CGRect)frame {
    %orig;
    coverSheetView = self;
}
%end

%hook MRUNowPlayingTimeControlsView

-(void)setFrame:(CGRect)frame {
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && [controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    %orig;
  } else {
    %orig(CGRectMake(coverSheetView.frame.size.width/2 - ([[UIScreen mainScreen] bounds].size.width - 60)/2, CGRectGetMaxY(mainPageView.frame) - 185, [[UIScreen mainScreen] bounds].size.width - 60, frame.size.height));
  }
}

- (void)layoutSubviews {
  %orig;
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && ![controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    newPlayerTimeControl = self;
  }
}

-(void)updateVisibility {
	%orig;
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && ![controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    self.elapsedTrack.backgroundColor = [UIColor whiteColor];
    self.knobView.backgroundColor = [UIColor whiteColor];

    if (self.remainingTrack.layer.filters.count) self.remainingTrack.layer.filters = nil;
    self.remainingTrack.backgroundColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];

    if (self.elapsedTimeLabel.layer.filters.count) self.elapsedTimeLabel.layer.filters = nil;
    if (self.remainingTimeLabel.layer.filters.count) self.remainingTimeLabel.layer.filters = nil;

    self.elapsedTimeLabel.textColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];
    self.remainingTimeLabel.textColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];
  }
}
%end

%hook MRUNowPlayingVolumeSlider

-(void)setFrame:(CGRect)frame {
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && [controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    %orig;
  } else {
    %orig(CGRectMake(mainPageView.frame.size.width/2 - frame.size.width/2, CGRectGetMaxY(mainPageView.frame) - 80, newPlayerTimeControl.frame.size.width, frame.size.height));
  }
}

- (void)layoutSubviews {
  %orig;
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && ![controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    newVolumeSlider = self;
  }
}

-(float)value {
  for (UIView *view in newVolumeSlider.subviews) {
      if ([view isMemberOfClass:%c(_UISlideriOSVisualElement)]) {
        for (UIView *subview in view.subviews) {
          if ([subview isMemberOfClass:%c(UIView)]) {
            for (UIImageView *imageView in subview.subviews) {
              if (imageView.layer.filters.count) imageView.layer.filters = nil;
              imageView.tintColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];
              [newVolumeSlider setMinimumTrackTintColor:[UIColor whiteColor]];
            }
          }
        }
      }
  }
  return %orig;
}
%end

%hook MRUNowPlayingTransportControlsView

-(void)setFrame:(CGRect)frame {
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && [controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    %orig;
  } else {
    %orig(CGRectMake(mainPageView.frame.size.width/2 - frame.size.width/2, CGRectGetMaxY(mainPageView.frame) - 135, frame.size.width, frame.size.height));
  }
}

- (void)layoutSubviews {
	%orig;
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && ![controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    %orig;
    newMediaControls = self;
  }
}

-(void)didMoveToWindow {
	%orig;
  MRUNowPlayingViewController *controller = (MRUNowPlayingViewController *)[self _viewControllerForAncestor];
  if ([controller respondsToSelector:@selector(delegate)] && ![controller.delegate isKindOfClass:%c(MRUControlCenterViewController)]) {
    %orig;
    [self.leftButton setStylingProvider:nil];
		[self.middleButton setStylingProvider:nil];
		[self.rightButton setStylingProvider:nil];

    if (self.leftButton.imageView.layer.filters.count) self.leftButton.imageView.layer.filters = nil;
    if (self.middleButton.imageView.layer.filters.count) self.middleButton.imageView.layer.filters = nil;
    if (self.rightButton.imageView.layer.filters.count) self.rightButton.imageView.layer.filters = nil;

    self.leftButton.imageView.tintColor = [UIColor whiteColor];
    self.middleButton.imageView.tintColor = [UIColor whiteColor];
    self.rightButton.imageView.tintColor = [UIColor whiteColor];
  }
}
%end

%hook CSMainPageView
%property (nonatomic, retain) UIView *octaveView;
// %property (nonatomic, retain) UIVisualEffectView *artistTitleMask;
%property (nonatomic, retain) CAGradientLayer *gradientView;
%property (nonatomic, retain) UILabel *songTitleLabel;
%property (nonatomic, retain) UILabel *artistTitleLabel;
%property (nonatomic, retain) UIImageView *artworkImageView;
%property (nonatomic, retain) UIButton *lyricsButton;
%property (nonatomic, retain) UITextView *lyricsScrollView;

-(id)initWithFrame:(CGRect)arg1 {
    id orig = %orig;
    mainPageView = self;
    return orig;
}

-(void)layoutSubviews {
    %orig;

    if (!self.octaveView) {
      self.octaveView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
      self.octaveView.backgroundColor = [UIColor clearColor];
      self.octaveView.alpha = 1;

      // gradient background
      self.gradientView = [CAGradientLayer layer];
      self.gradientView.frame = self.octaveView.bounds;
      [self.octaveView.layer insertSublayer:self.gradientView atIndex:0];

      // gradient change animation
      CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
      fadeInAnimation.fromValue = [NSNumber numberWithFloat:0.0];
      fadeInAnimation.toValue = [NSNumber numberWithFloat:1.0];
      fadeInAnimation.additive = NO;
      fadeInAnimation.removedOnCompletion = YES;
      fadeInAnimation.duration = 2.0;
      fadeInAnimation.fillMode = kCAFillModeForwards;
      [self.octaveView.layer addAnimation:fadeInAnimation forKey:nil];

      // make the gradient looks more pleasant
      UIVisualEffectView *blurEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThickMaterialDark]];
      blurEffect.frame = self.octaveView.bounds;
      blurEffect.alpha = 0.8;
      [self.octaveView addSubview:blurEffect];

      self.octaveView.hidden = YES;
    }

    if (!self.songTitleLabel) {
      self.songTitleLabel = [[UILabel alloc] init];
      [self.songTitleLabel setTextColor:[UIColor whiteColor]];
      [self.songTitleLabel setFont:[UIFont systemFontOfSize:22.0 weight:UIFontWeightMedium]];
      self.songTitleLabel.frame = CGRectMake(coverSheetView.frame.size.width/2 - ([[UIScreen mainScreen] bounds].size.width - 105)/2 - 22.5, CGRectGetMaxY(mainPageView.frame) - 243, [[UIScreen mainScreen] bounds].size.width - 105, 30);
      self.songTitleLabel.textAlignment = NSTextAlignmentLeft;
      [self.songTitleLabel setMarqueeEnabled:YES];
      [self.songTitleLabel setMarqueeRunning:YES];

      [self.octaveView addSubview:self.songTitleLabel];
    }

    if (!self.artistTitleLabel) {
      self.artistTitleLabel = [[UILabel alloc] init];
      [self.artistTitleLabel setTextColor:[UIColor colorWithRed: 0.75 green: 0.75 blue: 0.75 alpha: 1.00]];
      [self.artistTitleLabel setFont:[UIFont systemFontOfSize:21.0 weight:UIFontWeightRegular]];
      self.artistTitleLabel.frame = CGRectMake(coverSheetView.frame.size.width/2 - ([[UIScreen mainScreen] bounds].size.width - 105)/2 - 22.5, CGRectGetMaxY(mainPageView.frame) - 215, [[UIScreen mainScreen] bounds].size.width - 105, 30);
      self.artistTitleLabel.textAlignment = NSTextAlignmentLeft;

      // Vibrant text (having some weird glitches with this, will look again in the future)
      // self.artistTitleMask = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterialLight]];
      // self.artistTitleMask.frame = self.octaveView.bounds;
      // self.artistTitleMask.layer.mask = mainPageView.artistTitleLabel.layer;
      // self.artistTitleMask.layer.masksToBounds = YES;

      [self.artistTitleLabel setMarqueeEnabled:YES];
      [self.artistTitleLabel setMarqueeRunning:YES];

      [self.octaveView addSubview:self.artistTitleLabel];
    }

    if (!self.lyricsButton) {
      self.lyricsButton = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 60, CGRectGetMaxY(mainPageView.frame) - 225, 30, 30)];
	    [self.lyricsButton setImage:[[UIImage imageWithContentsOfFile:@"/Library/Application Support/Octave/lyrics_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
      self.lyricsButton.tintColor = [UIColor whiteColor];
      [self.lyricsButton addTarget:self action:@selector(presentLyrics) forControlEvents:UIControlEventTouchDown];
      [self.lyricsButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }

    if (!self.artworkImageView) {
      self.artworkImageView = [[UIImageView alloc] init];
      [self.artworkImageView setContentMode:UIViewContentModeScaleAspectFill];
      [self.artworkImageView setClipsToBounds:YES];
      self.artworkImageView.frame = CGRectMake(coverSheetView.frame.size.width/2 - ([[UIScreen mainScreen] bounds].size.width - 75)/2, CGRectGetMinY(mainPageView.frame) + 50, [[UIScreen mainScreen] bounds].size.width - 75, [[UIScreen mainScreen] bounds].size.width - 75);
      self.artworkImageView.layer.cornerRadius = 10.0;

      [self.octaveView addSubview:self.artworkImageView];
    }

    if (!self.lyricsScrollView) {
      self.lyricsScrollView = [[UITextView alloc]initWithFrame:CGRectMake(coverSheetView.frame.size.width/2 - ([[UIScreen mainScreen] bounds].size.width - 60)/2, self.artworkImageView.frame.origin.y, [[UIScreen mainScreen] bounds].size.width - 60, self.artworkImageView.frame.size.height)];
      [self.lyricsScrollView setUserInteractionEnabled:YES];
      [self.lyricsScrollView setScrollEnabled:YES];
      self.lyricsScrollView.scrollsToTop = YES;
      self.lyricsScrollView.textColor = [UIColor whiteColor];
      self.lyricsScrollView.textAlignment = NSTextAlignmentLeft;
      self.lyricsScrollView.text = @"Searching for Lyrics...";
      self.lyricsScrollView.editable = NO;
      self.lyricsScrollView.selectable = NO;
      [self.lyricsScrollView setFont:[UIFont systemFontOfSize:25.0 weight:UIFontWeightRegular]];
      self.lyricsScrollView.alpha = 0;
      self.lyricsScrollView.backgroundColor = [UIColor clearColor];
      self.lyricsScrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
      [self.lyricsScrollView setShowsHorizontalScrollIndicator:NO];
      [self.lyricsScrollView setShowsVerticalScrollIndicator:NO];
    }

    [self addSubview:self.octaveView];
    [self.octaveView addSubview:self.lyricsButton];
    [self.octaveView addSubview:self.lyricsScrollView];
    [self.octaveView addSubview:newVolumeSlider];
    [self.octaveView addSubview:newMediaControls];
    [self.octaveView addSubview:newPlayerTimeControl];

    // Player time control coloring
    newPlayerTimeControl.elapsedTrack.backgroundColor = [UIColor whiteColor];
    newPlayerTimeControl.knobView.backgroundColor = [UIColor whiteColor];

    if (newPlayerTimeControl.remainingTrack.layer.filters.count) newPlayerTimeControl.remainingTrack.layer.filters = nil;
    newPlayerTimeControl.remainingTrack.backgroundColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];

    if (newPlayerTimeControl.elapsedTimeLabel.layer.filters.count) newPlayerTimeControl.elapsedTimeLabel.layer.filters = nil;
    if (newPlayerTimeControl.remainingTimeLabel.layer.filters.count) newPlayerTimeControl.remainingTimeLabel.layer.filters = nil;

    newPlayerTimeControl.elapsedTimeLabel.textColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];
    newPlayerTimeControl.remainingTimeLabel.textColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];

    // Player control buttons coloring
    [newMediaControls.leftButton setStylingProvider:nil];
		[newMediaControls.middleButton setStylingProvider:nil];
		[newMediaControls.rightButton setStylingProvider:nil];

    if (newMediaControls.leftButton.imageView.layer.filters.count) newMediaControls.leftButton.imageView.layer.filters = nil;
    if (newMediaControls.middleButton.imageView.layer.filters.count) newMediaControls.middleButton.imageView.layer.filters = nil;
    if (newMediaControls.rightButton.imageView.layer.filters.count) newMediaControls.rightButton.imageView.layer.filters = nil;

    newMediaControls.leftButton.imageView.tintColor = [UIColor whiteColor];
    newMediaControls.middleButton.imageView.tintColor = [UIColor whiteColor];
    newMediaControls.rightButton.imageView.tintColor = [UIColor whiteColor];

    // Inefficient coloring method, but it still works
    for (UIView *view in newVolumeSlider.subviews) {
		    if ([view isMemberOfClass:%c(_UISlideriOSVisualElement)]) {
          for (UIView *subview in view.subviews) {
            if ([subview isMemberOfClass:%c(UIView)]) {
              for (UIImageView *imageView in subview.subviews) {
                if (imageView.layer.filters.count) imageView.layer.filters = nil;
                imageView.tintColor = [UIColor colorWithRed: 0.65 green: 0.65 blue: 0.65 alpha: 1.00];
                [newVolumeSlider setMinimumTrackTintColor:[UIColor whiteColor]];
              }
            }
          }
        }
		}
}

%new
-(NSString *)getLyricsForSong:(NSString *)keyword {

  // Scraping lyrics from azlyrics.com, so no API is required
  // It works most of the time, there's a little chance that it'll return a wrong lyric.

  if (!keyword) return @"Couldn't Get Song Data.";

  // Keyword cleanup
  keyword = [[NSString alloc] initWithData:[[keyword precomposedStringWithCompatibilityMapping] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding]; // unfold characters
  
  keyword = [keyword stringByReplacingOccurrencesOfString:@"\\(.*\\)\\s?" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, keyword.length)]; // remove parentheses
  keyword = [keyword stringByReplacingOccurrencesOfString:@"\\[.*\\]\\s?" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, keyword.length)]; // remove parentheses

  NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://search.azlyrics.com/search.php?q=%@", [keyword stringByReplacingOccurrencesOfString:@" " withString:@"+"]]];
  NSString *searchData = [NSString stringWithContentsOfURL:searchURL encoding:NSUTF8StringEncoding error:nil];

  // Check if IP temporary banned
  if ([searchData rangeOfString:@"Our systems have detected unusual activity from your IP address"].location != NSNotFound) return @"Could not get lyrics for this song at the moment. Please wait for a few hours, and try again.";

  // Get song results
  NSRange range = [searchData rangeOfString:@"Song results:"];
  if (range.location == NSNotFound) return @"No Lyrics Available.";

  searchData = [searchData substringFromIndex:range.location];

  // Get song lyrics URL
  searchData = [searchData substringFromIndex:[searchData rangeOfString:@"https://www.azlyrics.com/lyrics/"].location];
  searchData = [searchData substringToIndex:([searchData rangeOfString:@".html"].location + 5)];
  NSURL *lyricsURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", searchData]];
  NSString *lyricsData = [NSString stringWithContentsOfURL:lyricsURL encoding:NSUTF8StringEncoding error:nil];

  // Get lyrics
  NSString *lyrics = [lyricsData substringFromIndex:[lyricsData rangeOfString:@"<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->"].location];
  lyrics = [lyrics stringByReplacingOccurrencesOfString:@"<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->" withString:@""];
  lyrics = [lyrics substringToIndex:[lyrics rangeOfString:@"</div>"].location];

  // Clean up lyrics
  lyrics = [lyrics stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
  lyrics = [lyrics stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
  lyrics = [lyrics stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
  lyrics = [lyrics stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
  lyrics = [lyrics stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

  if (lyrics) {
    return lyrics;
  } else {
    return @"No Lyrics Available.";
  }
}

%new
-(void)presentLyrics {
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    if (self.lyricsScrollView.alpha == 1) {
      [self.lyricsButton setImage:[[UIImage imageWithContentsOfFile:@"/Library/Application Support/Octave/lyrics_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    } else {
      [self.lyricsButton setImage:[[UIImage imageWithContentsOfFile:@"/Library/Application Support/Octave/lyrics_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
  } completion:nil];

  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.lyricsScrollView.alpha = self.lyricsScrollView.alpha == 1 ? 0 : 1;
    self.artworkImageView.alpha = self.artworkImageView.alpha == 1 ? 0 : 1;
  } completion:nil];

  [UIView animateWithDuration:0.16 delay:0 usingSpringWithDamping:400 initialSpringVelocity:40 options:UIViewAnimationOptionCurveEaseIn animations:^{ // bounce animation
        self.lyricsButton.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.16 delay:0 usingSpringWithDamping:1000 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.lyricsButton.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }];
}

%new
-(void)updateLyricsView {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSString *lyrics = [self getLyricsForSong:[NSString stringWithFormat:@"%@ %@", self.songTitleLabel.text, self.artistTitleLabel.text]]; // Remove other artists if multiple exists
    dispatch_async(dispatch_get_main_queue(), ^{
      if (![oldLyrics isEqualToString:lyrics]) { // Prevent refreshing multiple times (workaround)
        [self.lyricsScrollView setContentOffset:CGPointZero animated:YES];

        [UIView transitionWithView:self.lyricsScrollView duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.lyricsScrollView.text = lyrics;
        } completion:nil];

        // Fix rendering bug
        self.lyricsScrollView.scrollEnabled = NO;
        self.lyricsScrollView.scrollEnabled = YES;
        oldLyrics = lyrics;
      }
    });
  });
}

%end

// Hide the ugly default music player

%hook CSAdjunctItemView
-(void)_updateSizeToMimic {
	%orig;
  [self.heightAnchor constraintEqualToConstant:0].active = true;
  self.hidden = YES;
}
%end

%hook CSAdjunctListView
-(void)layoutSubviews {
	%orig;
  self.hidden = YES;
}
%end

// Hide the default music name / artist / artwork

%hook MediaControlsHeaderView
-(void)layoutSubviews{
	%orig;

	MRPlatterViewController *controller = (MRPlatterViewController *)[self _viewControllerForAncestor];
	if ([controller respondsToSelector:@selector(delegate)] && [controller.delegate isKindOfClass:%c(CSMediaControlsViewController)]) {
    self.hidden = YES;
	}
}
%end

%hook SBMediaController

// From Litten's Lobelias tweak
// https://github.com/Litteeen/Lobelias/

- (void)setNowPlayingInfo:(id)arg1 {
  %orig;
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
        if (information) {
            NSDictionary* dict = (__bridge NSDictionary *)information;
            NSString *songTitle = [NSString stringWithFormat:@"%@", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle]];
            NSString *artistTitle = [NSString stringWithFormat:@"%@", [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist]];
            UIImage *currentArtwork = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]];

            mainPageView.songTitleLabel.text = songTitle;
            mainPageView.artistTitleLabel.text = artistTitle;

            if (dict) {
              if (dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData]) {
                [UIView transitionWithView:mainPageView.artworkImageView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    mainPageView.artworkImageView.image = currentArtwork;
                } completion:nil];

                  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSArray *rawColor = [[[CCColorCube alloc] init] extractColorsFromImage:currentArtwork flags:CCOnlyDistinctColors count:3];
                    NSMutableArray *imgColors = [rawColor mutableCopy];
                    [imgColors removeObjectIdenticalTo:[NSNull null]];

                    dispatch_async(dispatch_get_main_queue(), ^{
                      if ([imgColors count] == 1) {
                        mainPageView.gradientView.colors = [NSArray arrayWithObjects: (id)[[imgColors objectAtIndex:0] CGColor], nil];
                      } else if ([imgColors count] == 2) {
                        mainPageView.gradientView.colors = [NSArray arrayWithObjects: (id)[[imgColors objectAtIndex:0] CGColor], (id)[[imgColors objectAtIndex:1] CGColor], nil];
                      } else if ([imgColors count] == 3) {
                        mainPageView.gradientView.colors = [NSArray arrayWithObjects: (id)[[imgColors objectAtIndex:0] CGColor], (id)[[imgColors objectAtIndex:1] CGColor], [[imgColors objectAtIndex:2] CGColor], nil];
                      }
                    });
                  });
              }

              mainPageView.octaveView.hidden = NO;
              [mainPageView updateLyricsView];
            }
        } else {
            mainPageView.octaveView.hidden = YES;
        }
    });
}

- (void)_mediaRemoteNowPlayingApplicationIsPlayingDidChange:(id)arg1 {
    %orig;
    if ([self isPaused]) {
      [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:120 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseIn animations:^{
        mainPageView.artworkImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
      } completion:nil];
    } else {
      [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:150 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseIn animations:^{
        mainPageView.artworkImageView.transform = CGAffineTransformMakeScale(1, 1);
      } completion:nil];
    }

}

-(void)_nowPlayingAppDidExit:(id)arg1 {
  mainPageView.octaveView.hidden = YES;
}
%end

/* %hook SBDashBoardIdleTimerProvider
- (BOOL)isIdleTimerEnabled {
    return NO;
}
%end */
