#-- CircusTent_GAMS.gnuplot

set pointintervalbox 3
set term png size 1920,1080
set title "Giga AMOs/sec for T-Head Buildroot"
set output "GAMS.png"
set ylabel "Giga AMOs/sec (GAMS)"
set xlabel "Machine"
set xrange [0:6]
set xtics 0,1,6

plot  'CIRCUSTENT_GAMS.txt' using 1:3:2 with labels point offset 2,2 tc rgb "blue" title "GAMS"
