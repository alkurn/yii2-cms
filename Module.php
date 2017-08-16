<?php

namespace alkurn\cms;
use backend\modules\auth\Module as AuthModule;
/**
 * item module definition class
 */
class Module extends AuthModule
{
    /**
     * @inheritdoc
     */
    public $defaultRoute = 'cms-item';

    /**
     * @var array
     * @see [[items]]
     */
    protected $_menus = [];

    /**
     * @var array
     * @see [[items]]
     */
    protected $_moduleItems = [
        'cms-item'        => 'Pages',
        'blog'        => 'Blog',
    ];

    /**
     * @var array
     * @see [[items]]
     */
    protected $_normalizeMenus;

    /**
     * Nav bar items
     * @var array
     */

    public $navbar;

    /**
     * @var string Main layout using for module. Default to layout of parent module.
     * Its used when `layout` set to 'left-menu', 'right-menu' or 'top-menu'.
     */
    public $mainLayout = '';

    /**
     * @inheritdoc
     */

    public function init()
    {
        parent::init();
    }


}
