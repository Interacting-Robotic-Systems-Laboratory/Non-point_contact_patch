# Non-point_contact_patch
This package is used for the rigid-body motion prediction with planar non-point contact patch. We have examples of the "T-shaped Bar" and the "four-legged tables". In this package, there are folders of (1) "Non_point_contact_patches_interface", which contains the main script of the examples. (2) The "funjac" folder, which contains the function and jacobian evaluation file for each scenario. (3) the "symbolic_computation" folder, (4) the "utility" folder, (5) the "pathmexmaci64" folder and the (6) "visualize" folder. In the following, we will introduce the "Non_point_contact_patches_interface" folder in detail.

The "Non_point_contact_patches_interface" folder contains

(1) The main script file.

(2) The "planner_xxx.m" files provide the applied impulses to the object at each time step.

(3) The "path.opt" file contains the options and parameters for the PATH solver.
