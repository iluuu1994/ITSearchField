ITSearchField
=============

`ITSearchField` is a subclass of `NSSearchField`, which can collapse and expand if you click the search icon.
Note that `ITSearchField` works with autolayout, so you can only deploy to Mac OS X 10.7 or later.

Usage
-----

You can use `ITSearchField` even for commercial use, isn't that cool??

### Copy files

You have to copy the following files in order to get ITPathbar working:

* `ITSearchField.h`
* `ITSearchField.m`
* `ITSearchFieldCell.h`
* `ITSearchFieldCell.m`

Make sure to copy them to the project, and to add them to the target.
You can also copy the images for the search icon.

### Use in a project

Drag and drop a `NSSearchField` onto your window.
Select it and in the Identity Inspector under **Custom Class** set it to `ITSearchField`.
Click another time on the search field, until you can see `NSSearchFieldCell` under **Custom Class**.
Set this one to `ITSearchFieldCell`.

That's it. 

You can also connect an outlet to it and set the two custom properties `animationDuration`
`expandedWidth`.

    [self.searchField setAnimationDuration:0.4];
    [self.searchField setExpandedWidth:300];

If you have any questions, feel free to let me know at support@ilijatovilo.ch
