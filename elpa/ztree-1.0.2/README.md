# ztree
Ztree is a project dedicated to implementation of several text-tree applications inside [GNU Emacs](http://www.gnu.org/software/emacs/). It consists of 2 subprojects: **ztree-diff** and **ztree-dir** (the basis of **ztree-diff**). Available in [GNU ELPA](https://elpa.gnu.org/) and [MELPA](http://melpa.org/#/).

## Installation

### Using ELPA
Press `M-x` in GNU Emacs and write `list-packages`. Find the `ztree` in the list of packages and press `i` to select this package, `x` to install the package.

### Using MELPA
Add to your `.emacs` or `.emacs.d/init.el` following lines:

```scheme
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
```
                         
Follow the installation instructions for the GNU ELPA above.

### Manual
Add the following to your .emacs file:

```scheme
(push (substitute-in-file-name "path-to-ztree-directory") load-path)
(require 'ztree)
```

## ztree-diff
**ztree-diff** is a directory-diff tool for Emacs inspired by commercial tools like Beyond Compare or Araxis Merge. It supports showing the difference between two directories; calling **Ediff** for not matching files, copying between directories, deleting file/directories, hiding/showing equal files/directories.

The comparison itself performed with the external **GNU diff** tool, so make sure to have one in the executable path. Verified on OSX and Linux.

If one wants to have a stand-alone application, consider the (WIP)[zdircmp](https://github.com/fourier/zdircmp) project based on **ztree-diff**.

Call the `ztree-diff` interactive function:

```
M-x ztree-diff
```
Then you need to specify the left and right directories to compare.

### Hotkeys supported
 * Open/close directories with double-click, `RET` or `Space` keys.
 * To jump to the parent directory, hit the `Backspace` key.
 * To toggle open/closed state of the subtree of the current directory, hit the `x` key.
 * `RET` on different files starts the **Ediff** (or open file if one absent or the same)
 * `Space` show the simple diff window for the current file instead of **Ediff** (or view file if one absent or the same)
 * `TAB` to fast switch between panels
 * `h` key to toggle show/hide identical files/directories
 * `H` key to toggle show/hide hidden/ignored files/directories
 * `C` key to copy current file or directory to the left or right panel
 * `D` key to delete current file or directory
 * `v` key to quick view the current file
 * `r` initiates the rescan/refresh of current file or subdirectory
 * `F5` forces the full rescan.

### Customizations
By default all files starting with dot (like `.gitignore`) are not shown and excluded from the difference status for directories. One can add an additional regexps to the list `ztree-diff-filter-list`. 

### Screenshots

![ztreediff emacsx11](https://github.com/fourier/ztree/raw/screenshots/screenshots/emacs_diff_xterm.png "Emacs in xterm with ztree-diff")

![ztreediff-diff emacsx11](https://github.com/fourier/ztree/raw/screenshots/screenshots/emacs_diff_simplediff_xterm.png "Emacs in xterm with ztree-diff and simple diff")

## ztree-dir

**ztree-dir** is a simple text-mode directory tree for Emacs. See screenshots below for the GUI and the terminal versions of the **ztree-dir**.

Call the `ztree-dir` interactive function:

```
M-x ztree-dir
```

### Hotkeys supported
* Open/close directories with double-click, `RET` or `Space` keys.
* To jump to the parent directory, hit the `Backspace` key.
* To toggle open/closed state of the subtree of the current directory, hit the `x` key.
* To visit a file, press `Space` key.
* To open file in other window, use `RET` key.

### Customizations
Set the `ztree-dir-move-focus` variable to `t` in order to move focus to the other window when the `RET` key is pressed; the default behavior is to keep focus in `ztree-dir` window.


![ztree emacsapp](https://github.com/fourier/ztree/raw/screenshots/screenshots/emacs_app.png "Emacs App with ztree-dir")

![ztree emacsx11](https://github.com/fourier/ztree/raw/screenshots/screenshots/emacs_xterm.png "Emacs in xterm with ztree-dir")

