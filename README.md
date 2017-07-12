Yii2 CMS
==================
CMS packages for Yii2

Installation
------------

The preferred way to install this extension is through [composer](http://getcomposer.org/download/).

Either run

```
php composer.phar require --prefer-dist alkurn/yii2-cms "dev-master"
```

or add

```
"alkurn/yii2-cms": "*"
```
#Usages
```

'modules' => [
                'cms' => [
                            'class' => 'alkurn\cms\Module',
                        ],
             ],
             
```       
#Allow Access
     
```        'as access' => [

             'allowActions' => [
                                    'cms/default/page',
                                    'cms/default/blogs',
                                    'cms/default/blog',
                                ]
             ],
```

to the require section of your `composer.json` file.


