#!/bin/bash

############################
#
# Parameters to adjust
#
############################
RRDPATH=""
IMGPATH=""
RRDFILE=""
LAT=""
LON=""

# Graph Colors
RAWCOLOUR="#FF0000"
RAWCOLOUR2="#CC3366"
RAWCOLOUR3="#336699"
RAWCOLOUR4="#006600"
RAWCOLOUR5="#000000"
TRENDCOLOUR="#FFFF00"

# Calculating sunset/sunrise based on location from LAT LON
SUNRISEHR=`/usr/bin/sunwait sun up $LAT $LON -p | sed -n '/Sun transits/{:a;n;/Civil twilight/b;p;ba}' | cut -c 30-31`
SUNRISEMIN=`/usr/bin/sunwait sun up $LAT $LON -p | sed -n '/Sun transits/{:a;n;/Civil twilight/b;p;ba}' | cut -c 32-33`
SUNSETHR=`/usr/bin/sunwait sun up $LAT $LON -p | sed -n '/Sun transits/{:a;n;/Civil twilight/b;p;ba}' | cut -c 45-46`
SUNSETMIN=`/usr/bin/sunwait sun up $LAT $LON -p | sed -n '/Sun transits/{:a;n;/Civil twilight/b;p;ba}' | cut -c 47-48`
SUNR=$(($SUNRISEHR * 3600 + $SUNRISEMIN * 60))
SUNS=$(($SUNSETHR * 3600 + $SUNSETMIN * 60))

#hour
rrdtool graph $IMGPATH/hour.png --start -6h --end now \
-v "Last 6 hours (°C)" \
--full-size-mode \
--width=700 --height=400 \
--slope-mode \
--color=SHADEB#9999CC \
--watermark="© Bart Bania - 2014" \
DEF:temp1=$RRDPATH/$RRDFILE:a:AVERAGE \
DEF:temp2=$RRDPATH/$RRDFILE:b:AVERAGE \
DEF:temp3=$RRDPATH/$RRDFILE:c:AVERAGE \
DEF:temp4=$RRDPATH/$RRDFILE:d:AVERAGE \
DEF:temp5=$RRDPATH/$RRDFILE:e:AVERAGE \
CDEF:nightplus=LTIME,86400,%,$SUNR,LT,INF,LTIME,86400,%,$SUNS,GT,INF,UNKN,temp1,*,IF,IF \
CDEF:nightminus=LTIME,86400,%,$SUNR,LT,NEGINF,LTIME,86400,%,$SUNS,GT,NEGINF,UNKN,temp1,*,IF,IF \
AREA:nightplus#CCCCCCAA \
AREA:nightminus#CCCCCCAA \
COMMENT:"  Location      Last        Avg\l" \
LINE1:temp1$RAWCOLOUR:"Water     " \
GPRINT:temp1:LAST:"%5.1lf °C" \
GPRINT:temp1:AVERAGE:"%5.1lf °C" \
COMMENT:"\t\t\t\t\t\t\tSunrise\: $SUNRISEHR\:$SUNRISEMIN\l" \
LINE1:temp2$RAWCOLOUR2:"NaN1      " \
GPRINT:temp2:LAST:"%5.1lf °C" \
GPRINT:temp2:AVERAGE:"%5.1lf °C" \
COMMENT:"\t\t\t\t\t\t\tSunset\:  $SUNSETHR\:$SUNSETMIN\l" \
LINE1:temp3$RAWCOLOUR3:"Server Fan" \
GPRINT:temp3:LAST:"%5.1lf °C" \
GPRINT:temp3:AVERAGE:"%5.1lf °C\l" \
LINE1:temp4$RAWCOLOUR4:"Main Room " \
GPRINT:temp4:LAST:"%5.1lf °C" \
GPRINT:temp4:AVERAGE:"%5.1lf °C\l" \
LINE1:temp5$RAWCOLOUR5:"Hall      " \
GPRINT:temp5:LAST:"%5.1lf °C" \
GPRINT:temp5:AVERAGE:"%5.1lf °C\l" \
HRULE:0#0000FF:"freezing\l"

#day
rrdtool graph $IMGPATH/day.png --start -1d --end now \
-v "Last day (°C)" \
--full-size-mode \
--width=700 --height=400 \
--slope-mode \
--color=SHADEA#9999CC \
--watermark="© Bart Bania - 2014" \
DEF:temp1=$RRDPATH/$RRDFILE:a:AVERAGE \
DEF:temp2=$RRDPATH/$RRDFILE:b:AVERAGE \
DEF:temp3=$RRDPATH/$RRDFILE:c:AVERAGE \
DEF:temp4=$RRDPATH/$RRDFILE:d:AVERAGE \
DEF:temp5=$RRDPATH/$RRDFILE:e:AVERAGE \
CDEF:trend1=temp4,21600,TREND \
CDEF:trend2=temp5,21600,TREND \
CDEF:trend3=temp1,21600,TREND \
CDEF:nightplus=LTIME,86400,%,$SUNR,LT,INF,LTIME,86400,%,$SUNS,GT,INF,UNKN,temp1,*,IF,IF \
CDEF:nightminus=LTIME,86400,%,$SUNR,LT,NEGINF,LTIME,86400,%,$SUNS,GT,NEGINF,UNKN,temp1,*,IF,IF \
AREA:nightplus#CCCCCCAA \
AREA:nightminus#CCCCCCAA \
COMMENT:"  Location      Last        Avg\l" \
LINE1:temp1$RAWCOLOUR:"Water     " \
GPRINT:temp1:LAST:"%5.1lf °C" \
GPRINT:temp1:AVERAGE:"%5.1lf °C" \
COMMENT:"\t\t\t\t\t\t\tSunrise\: $SUNRISEHR\:$SUNRISEMIN\l" \
LINE1:temp2$RAWCOLOUR2:"NaN1      " \
GPRINT:temp2:LAST:"%5.1lf °C" \
GPRINT:temp2:AVERAGE:"%5.1lf °C" \
COMMENT:"\t\t\t\t\t\t\tSunset\:  $SUNSETHR\:$SUNSETMIN\l" \
LINE1:temp3$RAWCOLOUR3:"Server Fan" \
GPRINT:temp3:LAST:"%5.1lf °C" \
GPRINT:temp3:AVERAGE:"%5.1lf °C\l" \
LINE1:temp4$RAWCOLOUR4:"Main Room " \
GPRINT:temp4:LAST:"%5.1lf °C" \
GPRINT:temp4:AVERAGE:"%5.1lf °C\l" \
LINE1:temp5$RAWCOLOUR5:"Hall      " \
GPRINT:temp5:LAST:"%5.1lf °C" \
GPRINT:temp5:AVERAGE:"%5.1lf °C\l" \
HRULE:0#0000FF:"freezing\l"

#week
rrdtool graph $IMGPATH/week.png --start -1w \
--full-size-mode \
-v "Last week (°C)" \
--width=700 --height=400 \
--slope-mode \
--color=SHADEB#9999CC \
--watermark="© Bart Bania - 2014" \
DEF:temp1=$RRDPATH/$RRDFILE:a:AVERAGE \
DEF:temp2=$RRDPATH/$RRDFILE:b:AVERAGE \
DEF:temp3=$RRDPATH/$RRDFILE:c:AVERAGE \
DEF:temp4=$RRDPATH/$RRDFILE:d:AVERAGE \
DEF:temp5=$RRDPATH/$RRDFILE:e:AVERAGE \
CDEF:nightplus=LTIME,86400,%,$SUNR,LT,INF,LTIME,86400,%,$SUNS,GT,INF,UNKN,temp1,*,IF,IF \
CDEF:nightminus=LTIME,86400,%,$SUNR,LT,NEGINF,LTIME,86400,%,$SUNS,GT,NEGINF,UNKN,temp1,*,IF,IF \
AREA:nightplus#CCCCCCAA \
AREA:nightminus#CCCCCCAA \
COMMENT:"  Location      Last        Avg\l" \
LINE1:temp1$RAWCOLOUR:"Water     " \
GPRINT:temp1:LAST:"%5.1lf °C" \
GPRINT:temp1:AVERAGE:"%5.1lf °C\l" \
LINE1:temp2$RAWCOLOUR2:"NaN1      " \
GPRINT:temp2:LAST:"%5.1lf °C" \
GPRINT:temp2:AVERAGE:"%5.1lf °C\l" \
LINE1:temp3$RAWCOLOUR3:"Server Fan" \
GPRINT:temp3:LAST:"%5.1lf °C" \
GPRINT:temp3:AVERAGE:"%5.1lf °C\l" \
LINE1:temp4$RAWCOLOUR4:"Main Room " \
GPRINT:temp4:LAST:"%5.1lf °C" \
GPRINT:temp4:AVERAGE:"%5.1lf °C\l" \
LINE1:temp5$RAWCOLOUR5:"Hall      " \
GPRINT:temp5:LAST:"%5.1lf °C" \
GPRINT:temp5:AVERAGE:"%5.1lf °C\l" \
HRULE:0#0000FF:"freezing\l"

#month
rrdtool graph $IMGPATH/month.png --start -1m \
-v "Last month (°C)" \
--full-size-mode \
--width=700 --height=400 \
--slope-mode \
--color=SHADEA#9999CC \
--watermark="© Bart Bania - 2014" \
DEF:temp1=$RRDPATH/$RRDFILE:a:AVERAGE \
DEF:temp2=$RRDPATH/$RRDFILE:b:AVERAGE \
DEF:temp3=$RRDPATH/$RRDFILE:c:AVERAGE \
DEF:temp4=$RRDPATH/$RRDFILE:d:AVERAGE \
DEF:temp5=$RRDPATH/$RRDFILE:e:AVERAGE \
COMMENT:"  Location      Last        Avg\l" \
LINE1:temp1$RAWCOLOUR:"Water     " \
GPRINT:temp1:LAST:"%5.1lf °C" \
GPRINT:temp1:AVERAGE:"%5.1lf °C\l" \
LINE1:temp2$RAWCOLOUR2:"NaN1      " \
GPRINT:temp2:LAST:"%5.1lf °C" \
GPRINT:temp2:AVERAGE:"%5.1lf °C\l" \
LINE1:temp3$RAWCOLOUR3:"Server Fan" \
GPRINT:temp3:LAST:"%5.1lf °C" \
GPRINT:temp3:AVERAGE:"%5.1lf °C\l" \
LINE1:temp4$RAWCOLOUR4:"Main Room " \
GPRINT:temp4:LAST:"%5.1lf °C" \
GPRINT:temp4:AVERAGE:"%5.1lf °C\l" \
LINE1:temp5$RAWCOLOUR5:"Hall      " \
GPRINT:temp5:LAST:"%5.1lf °C" \
GPRINT:temp5:AVERAGE:"%5.1lf °C\l" \
HRULE:0#0000FF:"freezing\l"

#year
rrdtool graph $IMGPATH/year.png --start -1y \
--full-size-mode \
-v "Last year (°C)" \
--width=700 --height=400 \
--color=SHADEB#9999CC \
--slope-mode \
--watermark="© Bart Bania - 2014" \
DEF:temp1=$RRDPATH/$RRDFILE:a:AVERAGE \
DEF:temp2=$RRDPATH/$RRDFILE:b:AVERAGE \
DEF:temp3=$RRDPATH/$RRDFILE:c:AVERAGE \
DEF:temp4=$RRDPATH/$RRDFILE:d:AVERAGE \
DEF:temp5=$RRDPATH/$RRDFILE:e:AVERAGE \
COMMENT:"  Location      Last        Avg\l" \
LINE1:temp1$RAWCOLOUR:"Water     " \
GPRINT:temp1:LAST:"%5.1lf °C" \
GPRINT:temp1:AVERAGE:"%5.1lf °C\l" \
LINE1:temp2$RAWCOLOUR2:"NaN1      " \
GPRINT:temp2:LAST:"%5.1lf °C" \
GPRINT:temp2:AVERAGE:"%5.1lf °C\l" \
LINE1:temp3$RAWCOLOUR3:"Server Fan" \
GPRINT:temp3:LAST:"%5.1lf °C" \
GPRINT:temp3:AVERAGE:"%5.1lf °C\l" \
LINE1:temp4$RAWCOLOUR4:"Main Room " \
GPRINT:temp4:LAST:"%5.1lf °C" \
GPRINT:temp4:AVERAGE:"%5.1lf °C\l" \
LINE1:temp5$RAWCOLOUR5:"Hall      " \
GPRINT:temp5:LAST:"%5.1lf °C" \
GPRINT:temp5:AVERAGE:"%5.1lf °C\l" \
HRULE:0#0000FF:"freezing\l"

#averages
rrdtool graph $IMGPATH/avg.png --start -1w \
-v "Weekly averages (°C)" \
--full-size-mode \
--width=700 --height=400 \
--slope-mode \
--color=SHADEB#9999CC \
--watermark="© Bart Bania - 2014" \
DEF:temp1=$RRDPATH/$RRDFILE:a:AVERAGE \
DEF:temp2=$RRDPATH/$RRDFILE:b:AVERAGE \
DEF:temp3=$RRDPATH/$RRDFILE:c:AVERAGE \
DEF:temp4=$RRDPATH/$RRDFILE:d:AVERAGE \
DEF:temp5=$RRDPATH/$RRDFILE:e:AVERAGE \
CDEF:trend1=temp4,86400,TREND \
CDEF:trend2=temp5,86400,TREND \
CDEF:trend3=temp1,86400,TREND \
CDEF:trend4=temp2,86400,TREND \
CDEF:trend5=temp3,86400,TREND \
CDEF:nightplus=LTIME,86400,%,$SUNR,LT,INF,LTIME,86400,%,$SUNS,GT,INF,UNKN,temp1,*,IF,IF \
CDEF:nightminus=LTIME,86400,%,$SUNR,LT,NEGINF,LTIME,86400,%,$SUNS,GT,NEGINF,UNKN,temp1,*,IF,IF \
AREA:nightplus#CCCCCCAA \
AREA:nightminus#CCCCCCAA \
LINE2:trend1$RAWCOLOUR4:"Main Room 6h average\l" \
LINE2:trend2$RAWCOLOUR5:"Hall 6h average\l" \
LINE2:trend3$RAWCOLOUR:"Water 6h average\l" \
LINE2:trend4$RAWCOLOUR2:"NaN1 6h average\l" \
LINE2:trend5$TRENDCOLOUR:"Server Fan 6h average"
