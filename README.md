STOverlapWindowView
===================

The view overlaps window. You can use the view for modal like UIAlertView.

Usage
---

```objectivec
STOverlapWindowView *overlapView = [[STOverlapWindowView alloc] init];
// Show
[overlapView showWithAnimated:YES];
// Dismiss
[overlapView dismissWithAnimated:NO];
```

Mostly you will add subviews on STOverlapWindowView. And you want to layout on Interface Builder.  
This is one of the several ways.

- Create a subclass view of STOverlapWindowView.
- Create a xib file with the same name of subclass view.
- Set the File's Owner of xib to the subclass view.
- Connect IBOutlet subviews on the subclass view to the xib.
- The subclass view loads view from xib and add it as subview.

```objectivec
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // Load view from xib.
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
    NSArray *objects = [nib instantiateWithOwner:self options:nil];
    UIView *view = objects.firstObject;
	// Loaded view fills self.  Self view also fills window.
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
}
```
