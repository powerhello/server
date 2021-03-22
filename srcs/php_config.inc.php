declare(strict_types=1);

$cfg['blowfish_secret'] = '';
/* User used to manipulate with storage */
$i = 0;
$i++;

<!--$cfg['Servers'][$i]['controlhost'] = '';
 $cfg['Servers'][$i]['controlport'] = '';-->
<!--$cfg['Servers'][$i]['controluser'] = 'root';-->
<!--$cfg['Servers'][$i]['controlpass'] = '';-->
$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';