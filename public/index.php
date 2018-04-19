<!DOCTYPE html>
<html>
<head>
    <title>Telega</title>
</head>
<body>
    <h1 style="text-align: center">Telega virtual machine verify configuration file on
        <a href="http://<?= $_SERVER['SERVER_ADDR']; ?>"><?= $_SERVER['SERVER_ADDR']; ?></a>
        or
        <a href="http://domain.com/">http://domain.com/</a>
    </h1>
    <h2 style="text-align: center">Remote ip: <?= $_SERVER['REMOTE_ADDR']; ?></h2>
    <?php phpinfo(); ?>
</body>
</html>