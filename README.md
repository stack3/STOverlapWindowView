STOverlapWindowView
===================

The view overlaps window. You can use the view for modal window like UIAlertView.

Usage
---

```objectivec
STOverlapWindowView *overlapView = [[STOverlapWindowView alloc] init];
// Show
[overlapView showWithAnimated:YES];
// Dismiss
[overlapView hideWithAnimated:NO];
```

Mostly you will add subviews on STOverlapWindowView. And you want to layout on Interface Builder.  
This is one of the several ways.

- Create a subclass of STOverlapWindowView.
- Create a xib file with the same name of subclass.
- Set the xib's File's Owner to the subclass.
- Connect IBOutlet subviews on the subclass to the xib.
- The Subclass loads View from xib and add it as subview.

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
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
    NSArray *objects = [nib instantiateWithOwner:self options:nil];
    UIView *view = objects.firstObject;
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
}
```
