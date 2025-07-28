<?php
// ** MySQL settings - You can get this info from your .env file or environment variables ** //
define('DB_NAME', getenv('MYSQL_DATABASE') ?: 'wordpress');
define('DB_USER', getenv('MYSQL_USER') ?: 'wordpress_user');
define('DB_PASSWORD', getenv('MYSQL_PASSWORD') ?: 'secure_password');
define('DB_HOST', getenv('MYSQL_HOST') ?: 'mariadb'); // Service name in docker-compose.yml
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// ** Authentication Unique Keys and Salts. **
define('AUTH_KEY',         '%XB;pc]33--<4h,a*#|p/C%72!D!?D%bI-(!,4P;>m0/*+sTIoau*.$H3AS[AxgK');
define('SECURE_AUTH_KEY',  ';zt4;Ixd0Ji|;PAQz8-VWp-U5nEROx0h=tNR{.T^ a<f-|K|+(+D[`$[.H+@x2tD');
define('LOGGED_IN_KEY',    ']dWF:R-vRFPiwW}&@K)Q)B2Q>XbU(!v%|E[&D5s>ICB$l$uI#.e|/T`Ab}d!fYts');
define('NONCE_KEY',        'Si&sLh^#,&lHFV6+!25=L:#rbF)XkJGm_sOEhwTmniBQT80jHg;dHPj:5Jb$m!Yl');
define('AUTH_SALT',        '=fa)PI0<8^Fe`a|[)DCi23d4QIba)7@x=%:p+:8{5S7N4HL(t1?F=mhH1B+R(lr;');
define('SECURE_AUTH_SALT', 'p0+kg@J:nEY&wq,yp@q9MRkh.$Lenll7>$1Uq^0&a6@L#aURiP@pj-+U[:`ipzIz');
define('LOGGED_IN_SALT',   'L@}0M>KQrcC/?6AohgaYi88V#x4(Gy}}S-j{2 &Zwr[6z*l9$Em(0S4F}];Fqp6r');
define('NONCE_SALT',       'z^vF]C>>l$GrL0]8ZV~.AQlUT@+1@3FA_VJQ^<jV2+*N-aK=,{*MQxNyAw+4[]*=');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

// Set proper file permissions
define('FS_METHOD', 'direct');

// If behind a proxy (e.g., nginx), ensure HTTPS is detected
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

/* That's all, stop editing! Happy publishing. */
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');