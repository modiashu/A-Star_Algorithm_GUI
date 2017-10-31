#############################################################################################################
Application name: A* (A-Star)
Author: Palak Dave, Ashutosh Modi
#############################################################################################################

This readme explains system requirement and the steps involved in using the application.
For details about how to use the functionality please refer to the report "A_Star_report.pdf".

-------------------------------------------------------------------------------------------------------------

Configuration of the system used for the development and testing:
Microsoft Windows [Version 10.0.16299.19] 
CPU: Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
RAM: 8GB DDR3 (1600 MHz)
MATLAB: R2016a

-------------------------------------------------------------------------------------------------------------

Extracted package should have following files
- AStar.m
- AStarApplication.fig
- AStarApplication.m
- ConnectionsReading.m
- CreateDirectionalGraph.m
- CreateGraphEntities.m
- Euclidean.m
- LocationReading.m
- mouseButtonDownCallback.m
- mouseButtonUpCallback.m
- mouseMotionCallback.m
- NodeExclusionInclusion.m
- TracePath.m
- UpdateGraph.m
- ValidateData.m
- locations.txt
- connections.txt
- Readme
- A_Star_report.pdf

-------------------------------------------------------------------------------------------------------------

Steps to run the application
1.	Extract all contents of the zip folder in same directory
2.	Open file AStarApplication.m in matlab
3.	Change workspace path to the zip extracted location
4.	Use Run button from Editor tab of press F5 to start the application
5.	GUI, a new window should get opened.
6.	Select connections and location files using browse buttons present on the “Input Network” panel
7.	Choose start node, destination node and heuristic from “Where and How?” panel.
8.	Check box checked: Step by step visualization; unchecked: final path
9.	Reset button to get original network
10.	Node can be moved using mouse by clicking and dragging them.
11.	Node can be excluded from considering path finding algorithm by using mouse right click on them.
12.	Excluded node can again be reused by right click on them.


