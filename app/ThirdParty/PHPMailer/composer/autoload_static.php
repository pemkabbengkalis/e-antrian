<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit57829a5f574e5ce70681b9bf1ba2fde3
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'PHPMailer\\PHPMailer\\' => 20,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'PHPMailer\\PHPMailer\\' => 
        array (
            0 => __DIR__ . '/..' . '/phpmailer/phpmailer/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit57829a5f574e5ce70681b9bf1ba2fde3::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit57829a5f574e5ce70681b9bf1ba2fde3::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
