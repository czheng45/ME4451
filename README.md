# ME4451
Pathplanning from an image for ME4451 Project

code is pretty rough so it may break pretty easily.
this cannot handle transparency, the image must have a solid background.

will add more documentation as time goes on.

To change:
1) make the blacklist ray-tracer less janky
2) experiment with by reference GPU arrays
3) experiment with removing the GPU entirely
4) if CPU, experiment with multithreading
5) replace nearestRadialNeighbors with a fixed number of neighbors nNearestNeighbors
6) add a node marked as start and end
7) decrease border node concentration, use detectHarrisFeatures to get nodes located at each corner instead
