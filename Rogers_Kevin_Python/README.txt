Kevin Rogers
11/18/19


Code: Python


FILES:
filters.py - contains all code for 'range_filter' and 'temporal_median_filter'
main.py - contains test code to run filters.py


Summary:
The goal of this code was to implement 2 different filters for a LIDAR scanner
for a robot. The LIDAR scanner will input its measurements as a fixed float 
array to the 'update' function. The robot was assumed to be of reasonable 
compute power running a Linux OS and Python 2.7


range_filter:
The first implemented filter was a range based filter called 'range_filter'. 
This filter is designed to accept a fixed array of float value measurements and 
returns a new float array with any values too large or small filtered out. The
'range_filter' is constructed by passing the array size 'N', min value, and max 
value. A scan of size 'N' is filtered by passing the array to 'update' where 
the resulting filtered newSCAN of size 'N' is returned.

#EXAMPLE
import filters
filR = filters.range_filter(N, range_min, range_max)
newSCAN = filR.update(SCAN)


temporal_median_filter:
The second implemented filter was a time median based filter called 
'temporal_median_filter'. This filter is designed to accept and store a series 
LIDAR Scans in the form of fixed size float arrays. In turn, the filte computes 
and returns a new float array of the medians from the Scans. The 
'temporal_median_filter' is constructed by passing the array size 'N' and 
total Scans to store 'D'. If more than 'D' Scans are passed into the filter, 
a FIFO logic will be followed where only the most recent Scans are stored. 
A Scan of size 'N' is filtered by passing the array to 'update' where the 
resulting filtered newSCAN of size 'N' is returned.

#EXAMPLE
import filters
filT = filters.temporal_median_filter(N, D)
newSCAN = filT.update(SCAN)