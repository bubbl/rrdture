<?php
$lastmod = date("F d, Y g:i A", filemtime("img/day.png"));
$page = $_SERVER['PHP_SELF'];
$sec = "600";
?>
<html>
<head>
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="refresh" content="<?php echo $sec?>">
    <meta name="viewport" content="width=device-width, initial-scale=1,0, maximum-scale=1.0, user-scalable=0;"/ >
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/pure-min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/nivo-slider.css" media="screen">
    <link rel="stylesheet" href="css/bubbl-theme.css" media="screen" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Dosis' rel='stylesheet' type='text/css'>
    <title>The Unwritten Words - Temperature Log</title>
</head>
<body>
<div class="pure-menu pure-menu-open pure-menu-horizontal" id="float">
    <a href="/" class="pure-menu-heading"><i class="fa fa-sun-o"></i> Temperature</a>
    <ul>
        <li><a href="/charts"><i class="fa fa-database"></i> MySQL Charts</a></li>
        <li><a href="about"><i class="fa fa-question-circle"></i> About</a></li>
        <li><a href="http://www.bartbania.com">The Unwritten Words <i class="fa fa-external-link"></i></a></li>
        <li><a href="https://github.com/bubbl/rrdture"><i class="fa fa-github"></i> Git repository</a></li>
        <li><a href="https://twitter.com/RRDTureBot"><i class="fa fa-twitter"></i> Tweets</a></li>
    </ul>
</div>
<div id="modif">
    <i>Last Modified: <?=$lastmod?> <?php echo "(refreshed every 10 minutes)";?></i> <i class="fa fa-refresh fa-spin"></i>
</div>
<div id="wrapper">
    <div class="slider-wrapper bubbl-theme">
        <div id="slider" class="nivoSlider">
            <a href="img/hour.png"><img src="img/hour.png" alt="" title="#caption1"></img></a>
            <a href="img/day.png"><img src="img/day.png" alt="" title="#caption2"></img></a>
            <a href="img/week.png"><img src="img/week.png" alt="" title="#caption3"></img></a>
            <a href="img/week.png"><img src="img/month.png" alt="" title="#caption4"></img></a>
            <a href="img/year.png"><img src="img/year.png" alt="" title="#caption5"></img></a>
            <a href="img/avg.png"><img src="img/avg.png" alt="" title="#caption6"></img></a>
        </div>
        <div id="caption1" class="nivo-html-caption">
            <strong>Hourly temperatures</strong> <span></span> <em>Showing last 6 hours</em>.
        </div>
        <div id="caption2" class="nivo-html-caption">
            <strong>Daily temperatures</strong> <span></span> <em>Showing the last 24 hours</em>.
        </div>
        <div id="caption3" class="nivo-html-caption">
            <strong>Weekly temperatures</strong> <span></span> <em>Showing the last week</em>.
        </div>
        <div id="caption4" class="nivo-html-caption">
            <strong>Monthly temperatures</strong> <span></span>Showing the last month<em></em>.
        </div>
        <div id="caption5" class="nivo-html-caption">
            <strong>Yearly temperatures</strong> <span></span> <em>Showing whole year</em>.
        </div>
        <div id="caption6" class="nivo-html-caption">
            <strong>Weekly averages</strong> <span></span> <em>Last week averages</em>.
        </div>

    </div>
<div id="footer">
    <i class="fa fa-paper-plane-o"></i> <a href="mailto:contact@bartbania.com"><i>contact@bartbania.com</i></a>
</div>
</div>
<script src="js/jquery.min.js"></script>
<script src="js/jquery.nivo.slider.pack.js"></script>
<script>
    $(window).load(function() {
        $('#slider').nivoSlider({
            pauseTime: 10000,
            pauseOnHover: true,
            captionOpacity: 1,
            startSlide: 1,
            directionNav: false
        });
    });
</script>
<script type="text/javascript">
        if (screen.width <= 720) {
        window.location = "mobile/mindex.php";
    }
</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-40478354-1', 'bartbania.com');
  ga('send', 'pageview');

</script>
</body>
</html>
