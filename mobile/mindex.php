<?php
$lastmod = date("F d, Y g:i A", filemtime("../img/day.png"));
$page = $_SERVER['PHP_SELF'];
$sec = "600";
?>
<html>
<head>
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="refresh" content="<?php echo $sec?>">
    <link href="../css/font-awesome.min.css" rel="stylesheet">
    <link href="../css/pure-min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Dosis' rel='stylesheet' type='text/css'>
    <title>The Unwritten Words - Temperature Log</title>
</head>
<body>
<div class="pure-menu pure-menu-open pure-menu-horizontal">
    <a href="/" class="pure-menu-heading"><i class="fa fa-sun-o"></i> Temperature</a>
    <ul>
        <li><a href="/charts"><i class="fa fa-database"></i> MySQL Charts</a></li>
        <li><a href="/about"><i class="fa fa-question-circle"></i> About</a></li>
        <li><a href="http://www.bartbania.com">The Unwritten Words <i class="fa fa-external-link"></i></a></li>
        <li><a href="https://gitlab.com/bartlomiej.bania/rrdtool"><i class="fa fa-github"></i> Git repository</a></li>
        <li><a href="https://twitter.com/RRDTureBot"><i class="fa fa-twitter"></i> Tweets</a></li>
    </ul>
</div>
<div id="modif">
    <i>Last Modified: <?=$lastmod?> <?php echo "(refreshed every 10 minutes)";?></i> <i class="fa fa-refresh fa-spin"></i>
</div>
<div id="wrapper">
            <a href="../img/hour.png"><img src="../img/hour.png" alt=""></img></a>
            <a href="../img/day.png"><img src="../img/day.png" alt=""></img></a>
            <a href="../img/week.png"><img src="../img/week.png" alt=""></img></a>
            <a href="../img/week.png"><img src="../img/month.png" alt=""></img></a>
            <a href="../img/year.png"><img src="../img/year.png" alt=""></img></a>
            <a href="../img/avg.png"><img src="../img/avg.png" alt=""></img></a>
<div id="footer">
    <i class="fa fa-paper-plane-o"></i> <a href="mailto:contact@bartbania.com"><i>contact@bartbania.com</i></a>
</div>
</div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
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
